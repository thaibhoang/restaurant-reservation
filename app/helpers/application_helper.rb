module ApplicationHelper
  def full_title(page_title = "")
    base_title = "OpenTable"
    return base_title if page_title.empty?

    "#{page_title} | #{base_title}"
  end

  def show_active(title, nav_link_name)
    return "" if title.empty? || title != nav_link_name

    "active"
  end

  def admin_page?(admin_page = "")
    admin_page == "admin"
  end

  def some_text_if_empty(resource)
    content_tag(:div, "Empty for now") if resource.empty?
  end

  def format_time(time, format = "%M:%S")
    time.blank? ? "" : time.to_s(format)
  end

  def format_date(date, format = :long)
    time.blank? ? "" : date.to_s(format)
  end
end
