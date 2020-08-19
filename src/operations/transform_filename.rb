#!/usr/bin/env ruby
# frozen_string_literal: true

require 'ruby-pinyin'
require_relative './common'

def move_to_category_folder(filename, category)
  basename = File.basename(filename, '.md')
  dirname = File.dirname(filename)
  underscored_category = category.split(' ').join('_')
  ask_question filename, "Move #{basename}.md to folder: #{underscored_category} ? [Y/n]"
  return if STDIN.gets.chomp.downcase == 'n'

  execute_command("mkdir -p #{dirname}/#{underscored_category}/")
  execute_command("mv \"#{filename}\" \"#{dirname}/#{underscored_category}/#{basename}.md\"")
end

def convert_to_pinyin(filename)
  basename = File.basename(filename, '.md')
  if basename.match(/.*([0-9]{4}-[0-9]{2}-[0-9]{2})-.*/)
    date = basename.slice(0..9)
    chinese_name = basename.slice(11..-1)
    "#{date}-#{PinYin.permlink(chinese_name).downcase}.md"
  else
    "#{PinYin.permlink(basename).downcase}.md"
  end
end

def convert_filename(filename)
  basename = File.basename(filename)
  dirname = File.dirname(filename)
  converted_filename = convert_to_pinyin(filename)
  ask_question filename, "Rename '#{basename}'.md to '#{converted_filename}'? [Y/n]"
  return if STDIN.gets.chomp.downcase == 'n'

  execute_command("mv \"#{filename}\" \"#{dirname}/#{converted_filename}\"")
end

def add_current_date_prefix(filename)
  basename = File.basename(filename, '.md')
  dirname = File.dirname(filename)
  current_date = File.ctime(filename).strftime('%Y-%m-%d')
  filename_with_date_prefix = "#{current_date}-#{basename}.md"
  ask_question filename, "Prefix #{basename}.md with '#{current_date}-'? [Y/n]"
  return if STDIN.gets.chomp.downcase == 'n'

  execute_command("mv \"#{filename}\" \"#{dirname}/#{filename_with_date_prefix}\"")
end

# date.md format:
# |filename|date|
def iteratively_search_created_date(date_file, term)
  puts "grep '#{term}' \"#{date_file}\""
  match = `grep '#{term}' "#{date_file}`
  created_at = match.split('|')[-2]
  if created_at.nil?
    puts 'Created date not found. Enter a new search term:'
    term = STDIN.gets.chomp
    return iteratively_search_created_date(term)
  end
  puts created_at
  created_at
end

# date_file = "../input/date.md"
def add_created_date_prefix_by_search(filename, date_file)
  basename = File.basename(filename, '.md')
  dirname = File.dirname(filename)
  created_at = iteratively_search_created_date(date_file, basename)
  filename_with_date_prefix = "#{created_at}-#{basename}.md"
  ask_question filename, "Prefix #{basename}.md with '#{current_date}-'? [Y/n]"
  return if STDIN.gets.chomp.downcase == 'n'

  execute_command("mv \"#{filename}\" \"#{dirname}/#{filename_with_date_prefix}\"")
end
