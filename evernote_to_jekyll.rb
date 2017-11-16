require 'nokogiri'
require 'shellwords'
require 'pathname'


def to_jekyll_name_group(html_file_location)
  html_filename = Pathname.new(html_file_location).basename
  page = Nokogiri::HTML(open(html_file_location))
  created = page.css('meta[name=created]')[0].attributes["content"].value
  prefix = created.split[0]
  {
    html_filename: "#{html_filename}.html",
    html_resources: "#{html_filename}.resources",
    jekyll_filename: "#{prefix}-#{html_filename}.html",
    jekyll_resources: "#{prefix}-#{html_filename}"
  }
end

def print_rename_commands_for_files(path_to_HTML_files)
  path_to_HTML_files.each do |path_to_HTML_file|
    name_group = to_jekyll_name_group(path_to_HTML_file)
    print "mv #{name_group[:html_filename].shellescape} #{name_group[:jekyll_filename].shellescape}\n"
    # not every html file has a corresponding resources folder
    print "mv #{name_group[:html_resources].shellescape} #{name_group[:jekyll_resources].shellescape}\n"
  end
end

def evernote_to_jekyll(directory)
  print_rename_commands_for_files(Dir["#{directory}/*.html"])
end
