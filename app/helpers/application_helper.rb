# app/helpers/application_helper.rb
module ApplicationHelper
    def markdown_to_html(text)
      renderer = Redcarpet::Render::HTML.new(hard_wrap: true)
      markdown = Redcarpet::Markdown.new(renderer, autolink: true, tables: true)
      markdown.render(text).html_safe
    end
  end
  