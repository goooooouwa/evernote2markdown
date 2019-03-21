# frozen_string_literal: true

require 'nokogiri'
require 'shellwords'

class ENHTMLConverter
  def initialize(html_path)
    raise ArgumentError, "Invalid path: #{html_path}" unless html_path

    @html_path = html_path
  end

  def name_map
    html_page = Nokogiri::HTML(open(@html_path))
    creation_date = html_page.css('meta[name=created]')[0]
    raise ArgumentError, "No creation date in #{@html_path}" unless creation_date

    date_prefix = creation_date.attributes['content']
                               .value.split[0]
    filename = File.basename(@html_path, File.extname(@html_path))
    {
      html_filename: "#{filename}.html",
      html_resources: "#{filename}.resources",
      jekyll_filename: "#{date_prefix}-#{filename}.html",
      jekyll_resources: "#{date_prefix}-#{filename}"
    }
  end

  def generate_rename_command
    name_map = self.name_map
    # not every html file has a corresponding resources folder
    <<~HEREDOC
      mv #{name_map[:html_filename].shellescape} #{name_map[:jekyll_filename].shellescape}
      mv #{name_map[:html_resources].shellescape} #{name_map[:jekyll_resources].shellescape}
    HEREDOC
  rescue ArgumentError => e
    e.to_s
  end

  def self.generate_rename_commands(dir)
    sanitized_html_paths = Dir["#{dir}/*.html"].reject do |html_path|
      filename = File.basename(html_path)
      filename == 'index.html'
    end.reject do |html_path|
      file_basename = File.basename(html_path, File.extname(html_path))
      /[0-9]{4}-[0-9]{2}-[0-9]{2}-.*/.match? file_basename
    end

    commands = ''
    sanitized_html_paths.each do |html_path|
      commands += new(html_path).generate_rename_command
    end
    commands
  rescue ArgumentError => e
    commands += e.to_s
  end
end
