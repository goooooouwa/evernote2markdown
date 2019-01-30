# frozen_string_literal: true

require 'nokogiri'
require 'shellwords'

def html_to_jekyll(html_path)
  html_page = Nokogiri::HTML(open(html_path))
  date_prefix = html_page.css('meta[name=created]')[0]
                         .attributes['content']
                         .value.split[0]
  filename = File.basename(html_path, File.extname(html_path))
  {
    html_filename: "#{filename}.html",
    html_resources: "#{filename}.resources",
    jekyll_filename: "#{date_prefix}-#{filename}.html",
    jekyll_resources: "#{date_prefix}-#{filename}"
  }
end

def get_rename_commands(html_paths)
  commands = ''
  html_paths.each do |html_path|
    name_group = html_to_jekyll(html_path)
    commands += "mv #{name_group[:html_filename].shellescape} #{name_group[:jekyll_filename].shellescape}\n"
    # not every html file has a corresponding resources folder
    commands += "mv #{name_group[:html_resources].shellescape} #{name_group[:jekyll_resources].shellescape}\n"
  end
  commands
end

def evernote_to_jekyll(dir)
  sanitized_html_paths = Dir["#{dir}/*.html"].reject do |html_path|
    file_basename = File.basename(html_path, File.extname(html_path))
    /[0-9]{4}-[0-9]{2}-[0-9]{2}-.*/.match? file_basename
  end

  get_rename_commands(sanitized_html_paths)
end
