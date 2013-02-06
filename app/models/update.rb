class Update < ActiveRecord::Base
  belongs_to :issue

  validates_length_of   :description, :minimum => 10
end
