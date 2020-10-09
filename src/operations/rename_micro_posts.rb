#!/usr/bin/env ruby
# frozen_string_literal: true

require 'ruby-pinyin'

def run(dir)
  Dir.glob("#{dir}/*/*/*/*.txt") do |filename|
    basename = File.basename(filename, '.txt')
    dirname = File.dirname(filename)
    basename_with_date = dirname.gsub('/', '-').sub(/.*_micro-posts-/, '')
    date, basename_without_date = basename_with_date.split('_')
    pinyin_basename = PinYin.permlink(basename_without_date).downcase
    md_basename = "#{date}-#{pinyin_basename}"
    # puts "basename_with_date: #{basename_with_date}"
    # puts "basename_without_date: #{basename_without_date}"
    # puts "date: #{date}"
    # puts "pinyin_basename: #{pinyin_basename}"
    # puts "md_basename: #{md_basename}"
    puts `mv "#{dirname}/#{basename}.txt" "#{dir}/#{md_basename[0..124]}.md"`
  end
end

run(ARGV[0])
