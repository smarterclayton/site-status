class Issue < ActiveRecord::Base
  has_many :updates, :order => "created_at ASC"
  validates_presence_of :title
  validate :dates_in_order

  def dates_in_order
    errors.add(:ends_at, ' time must be later than the start time') if scheduled? && starts_at >= ends_at
  end

  def status
    resolved? ? :resolved : :investigating
  end

  def resolved?
    resolved_at.present?
  end

  def resolve
    if updates.empty? or updates.last.changed?
      errors[:updates] << "No update was provided with the resolution or the last update was not saved"
      false
    else
      self.resolved_at = updates.last.created_at
      save
    end
  end

  def scheduled?
    begins_at.present?
  end

  def unschedule
    Rails.logger.debug "Unschedule!"
    self.begins_at = nil
    self.ends_at = nil
    self.timezone = nil
  end

  def starts_at
    begins_at or created_at
  end

  def begins_at
    return super.in_time_zone(timezone) if timezone && super.present?
    super
  end
  def ends_at
    return super.in_time_zone(timezone) if timezone && super.present?
    super
  end

  scope :resolved, :conditions => 'resolved_at IS NOT NULL'
  scope :unresolved, :conditions => {:resolved_at => nil}, :order => 'created_at DESC'
  scope :started_at, lambda{ |date| where('begins_at is null or begins_at < ?', date).order('begins_at DESC') }

  scope :active, lambda{ unresolved.started_at(DateTime.now) }
  scope :upcoming, lambda{ unresolved.where('begins_at > ?', DateTime.now).order('begins_at ASC') }
  scope :resolved_since, lambda{ |date| where("resolved_at > ?", date.beginning_of_day).order('resolved_at DESC') }
end

