#!/usr/bin/env ruby
# frozen_string_literal: true

require 'ruby-pinyin'

def rename_micro_posts(dir)
  Dir.glob("#{dir}/*/*/*/*.txt") do |filename|
    basename = File.basename(filename, '.txt')
    dirname = File.dirname(filename)
    md_basename = generate_md_basename(dirname)
    puts `mv "#{dirname}/#{basename}.txt" "#{dirname}/#{md_basename[0..124]}.md"`
  end
end

def append_images(dir)
  Dir.glob("#{dir}/*/*/*/*.md") do |filename|
    dirname = File.dirname(filename).sub('/Users/sfxu/projects/writings/_micro_posts/', '')
    `echo "\n" >> "#{filename}"`
    9.times do |i|
      `echo '![]({{ "/assets/images/#{dirname}/#{i + 1}.jpg" | relative_url }})' >> "#{filename}"`
    end
  end
end

def generate_md_basename(dirname)
  basename_with_date = dirname.gsub('/', '-').sub(/.*_micro_posts-/, '')
  date, basename_without_date = basename_with_date.split('_')
  pinyin_basename = PinYin.permlink(basename_without_date).downcase
  # puts "basename_with_date: #{basename_with_date}"
  # puts "basename_without_date: #{basename_without_date}"
  # puts "date: #{date}"
  # puts "pinyin_basename: #{pinyin_basename}"
  "#{date}-#{pinyin_basename}"
end

def rename_post_folders(dir)
  Dir.glob("#{dir}/*/*/*") do |dirname|
    md_basename = generate_md_basename(dirname)
    puts `mv "#{dirname}" "$(dirname "#{dirname}")/#{md_basename[0..19]}"`
  end
end

append_images(ARGV[0])
