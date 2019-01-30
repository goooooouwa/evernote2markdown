# frozen_string_literal: true

require 'nokogiri'

def parse_front_matter(path_to_HTML_file)
  page = Nokogiri::HTML(open(path_to_HTML_file))
  keywords_meta_elements = page.css('meta[name=keywords]')

  if keywords_meta_elements.empty?
    <<~FRONT_MATTER
      ---
      layout: post
      title: '#{page.title}'
      ---
    FRONT_MATTER
  else
    keywords = keywords_meta_elements.first.attributes['content'].value.split(', ')
    <<~FRONT_MATTER
      ---
      layout: post
      title: '#{page.title}'
      categories: #{keywords.join(' ')}
      ---
    FRONT_MATTER
  end
end

def insert_front_matter(front_matter, path_to_HTML_file)
  File.open(path_to_HTML_file, 'r+') do |file|
    lines = file.each_line.to_a
    lines.unshift(front_matter)
    file.rewind
    file.write(lines.join)
  end
end

def insert_front_matters(directory)
  files_without_front_matter = Dir["#{directory}/*.html"].reject do |path_to_HTML_file|
    File.open(path_to_HTML_file, &:readline) == "---\n"
  end

  files_without_front_matter.each do |file|
    front_matter = parse_front_matter(file)
    insert_front_matter(front_matter, file)
  end
end
