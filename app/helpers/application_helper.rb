# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def link_to_with_current_class(name, options = {}, html_options = {})
    link_to_unless current_page?(options), name, options, html_options do
      html_options[:class] = "#{html_options[:class]} current".strip
      link_to name, options, html_options
    end
  end

end
