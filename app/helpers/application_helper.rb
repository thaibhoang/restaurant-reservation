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
end
