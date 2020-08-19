#!/usr/bin/env ruby
# frozen_string_literal: true

require 'ruby-pinyin'

# command line params:
# 1. md files directory, e.g. path/to/writings/_notes
def run(dir)
  Dir.glob("#{dir}/*.md") do |filename|
    basename = File.basename(filename)
    if basename.match(/^[0-9]{4}-[0-9]{2}-[0-9]{2}-[0-9a-z-]+[.]md$/)
      puts "skip processed file: #{basename}..."
      next
    end

    puts "check #{basename}? [Y/n]"
    puts `head -7 "#{filename}"`
    check_file = STDIN.gets.chomp
    unless check_file.downcase == 'n'
      insert_front_matter_tag(filename)
      insert_title_front_matter(filename)
      insert_date_front_matter(filename)
      insert_category_by_user(convert_filename_to_pinyin(filename))
      unless filename.match(/.*([0-9]{4}-[0-9]{2}-[0-9]{2})-.*/)
        add_current_date_prefix_to_filename(filename)
        # add_created_date_prefix_to_filename(filename)
      end
    end
  end
end

def insert_title_front_matter(filename)
  basename = File.basename(filename, '.md')
  basename = basename.slice(11..-1) if basename.match(/.*([0-9]{4}-[0-9]{2}-[0-9]{2})-.*/)
  puts "insert front matter 'title: #{basename}'? [Y/n]"
  insert_title = STDIN.gets.chomp
  return if insert_title.downcase == 'n'

  puts "gsed -i '1 a title: #{basename}' \"#{filename}\""
  `gsed -i '1 a title: #{basename}' "#{filename}"`
  puts 'inserted'
end

def insert_front_matter_tag(filename)
  puts "insert front matter 'tag: ---'? [Y/n]"
  insert_title = STDIN.gets.chomp
  return if insert_title.downcase == 'n'

  puts "gsed -i '1 i ---' \"#{filename}\""
  `gsed -i '1 i ---' "#{filename}"`
  `gsed -i '1 i ---' "#{filename}"`
  puts 'front matter tag inserted'
end

def insert_date_front_matter(filename)
  basename = File.basename(filename, '.md')
  created_at = if basename.match(/.*([0-9]{4}-[0-9]{2}-[0-9]{2})-.*/)
                 basename.slice(0..9)
               else
                 puts 'Enter a date:'
                 STDIN.gets.chomp
               end
  puts "insert front matter 'date: #{created_at}'? [Y/n]"
  insert_date = STDIN.gets.chomp
  return if insert_date.downcase == 'n'

  puts "gsed -i '1 a date: #{created_at}' \"#{filename}\""
  `gsed -i '1 a date: #{created_at}' "#{filename}"`
  puts 'inserted'
end

def insert_category_from_dir(filename)
  category = File.dirname(filename).split('/').last
  insert_category(filename, category)
end

def insert_category(filename, category)
  puts "insert front matter 'category: #{category}'? [Y/n]"
  insert_category = STDIN.gets.chomp
  return if insert_category.downcase == 'n'

  puts "gsed -i '1 a category: #{category}' \"#{filename}\""
  `gsed -i '1 a category: #{category}' "#{filename}"`
  puts 'category inserted'
end

def insert_category_by_user(filename)
  puts 'Enter category name:'
  category = STDIN.gets.chomp
  insert_category(filename, category)
  move_to_category_folder(filename, category)
end

def batch_insert_category(dir)
  Dir.glob("#{dir}/*.md") do |filename|
    insert_category_by_user(filename)
  end
end

def move_to_category_folder(filename, category)
  basename = File.basename(filename, '.md')
  dirname = File.dirname(filename)
  underscored_category = category.split(' ').join('_')
  puts "move #{basename}.md to category folder: #{underscored_category} ? [Y/n]"
  move_file = STDIN.gets.chomp
  return if move_file.downcase == 'n'

  puts "mkdir -p #{dirname}/#{underscored_category}/"
  puts "mv \"#{filename}\" \"#{dirname}/#{underscored_category}/#{basename}.md\""
  `mkdir -p "#{dirname}/#{underscored_category}/"`
  `mv "#{filename}" "#{dirname}/#{underscored_category}/#{basename}.md"`
  puts 'categoriezd'
end

def convert_filename_to_pinyin(filename)
  basename = File.basename(filename, '.md')
  dirname = File.dirname(filename)
  if basename.match(/.*([0-9]{4}-[0-9]{2}-[0-9]{2})-.*/)
    date = basename.slice(0..9)
    chinese_name = basename.slice(11..-1)
    converted_filename = "#{date}-#{PinYin.permlink(chinese_name).downcase}.md"
  else
    converted_filename = "#{PinYin.permlink(basename).downcase}.md"
  end
  puts "convert filename from '#{filename}' to '#{converted_filename}'? [Y/n]"
  # convert_filename = 'y'
  convert_filename = STDIN.gets.chomp
  return if convert_filename.downcase == 'n'

  puts "mv \"#{filename}\" \"#{dirname}/#{converted_filename}\""
  `mv "#{filename}" "#{dirname}/#{converted_filename}"`
  puts 'converted'

  "#{dirname}/#{converted_filename}"
end

def add_current_date_prefix_to_filename(filename)
  basename = File.basename(filename, '.md')
  dirname = File.dirname(filename)
  current_date = File.ctime(filename).strftime('%Y-%m-%d')
  filename_with_date_prefix = "#{current_date}-#{basename}.md"
  puts "add date prefix '#{current_date}-'? [Y/n]"
  add_date_prefix = STDIN.gets.chomp
  return if add_date_prefix.downcase == 'n'

  puts "mv \"#{filename}\" \"#{dirname}/#{filename_with_date_prefix}\""
  `mv "#{filename}" "#{dirname}/#{filename_with_date_prefix}"`
  puts 'prefix added'
end

def add_created_date_prefix_to_filename(filename)
  basename = File.basename(filename, '.md')
  dirname = File.dirname(filename)
  created_at = grep_search(basename)
  filename_with_date_prefix = "#{created_at}-#{basename}.md"
  puts "add date prefix '#{current_date}-'? [Y/n]"
  add_date_prefix = STDIN.gets.chomp
  return if add_date_prefix.downcase == 'n'

  puts "mv \"#{filename}\" \"#{dirname}/#{filename_with_date_prefix}\""
  `mv "#{filename}" "#{dirname}/#{filename_with_date_prefix}"`
  puts 'prefix added'
end

# date.md format:
# |filename|date|
def grep_search(term)
  puts "grep '#{term}' ../input/date.md"
  match = `grep '#{term}' ../input/date.md`
  created_at = match.split('|')[-2]
  if created_at.nil?
    puts 'Created date not found. Enter a new search term:'
    term = STDIN.gets.chomp
    return grep_search(term)
  end
  puts created_at
  created_at
end

run(ARGV[0])
# batch_insert_category(ARGV[0])
