# frozen_string_literal: true

require 'nokogiri'

def parse_front_matter(html_path)
  html_page = Nokogiri::HTML(open(html_path))
  keywords_meta_elements = html_page.css('meta[name=keywords]')

  if keywords_meta_elements.empty?
    <<~FRONT_MATTER
      ---
      layout: post
      title: '#{html_page.title}'
      ---
    FRONT_MATTER
  else
    keywords = keywords_meta_elements.first.attributes['content']
                                     .value.split(', ')
    <<~FRONT_MATTER
      ---
      layout: post
      title: '#{html_page.title}'
      categories: #{keywords.join(' ')}
      ---
    FRONT_MATTER
  end
end

def insert_front_matter(front_matter, file)
  File.open(file, 'r+') do |f|
    lines = f.each_line.to_a
    lines.unshift(front_matter)
    f.rewind
    f.write(lines.join)
  end
end

def insert_front_matters(dir)
  sanitized_html_paths = Dir["#{dir}/*.html"].reject do |html_path|
    File.open(html_path, &:readline) == "---\n"
  end

  sanitized_html_paths.each do |html_path|
    front_matter = parse_front_matter(html_path)
    insert_front_matter(front_matter, html_path)
  end
end
