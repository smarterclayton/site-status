module FormHelper
  def errors_for(resource)
    resource.errors.full_messages.map do |m|
      content_tag(:div, m)
    end.join.html_safe
  end

  def editable?
    controller.respond_to?(:editable?) ? controller.editable? : false
  end

  def server_time(time)
    time.in_time_zone('Eastern Time (US & Canada)').strftime("%-I:%M%P EST")
  end

  def server_datetime(time)
    time.in_time_zone('Eastern Time (US & Canada)').strftime("%b %-d, %-I:%M%P EST")
  end
  def to_markup(s, &block)
    prefix = capture_haml &block if block_given?
    paragraphs = s.split(/^\s*$/m)
    paragraphs[0] = "#{prefix}#{h(paragraphs[0])}".html_safe if prefix
    paragraphs.map{ |s| content_tag(:p, s) }.join.html_safe
  end
end
