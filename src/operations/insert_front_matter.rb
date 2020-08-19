#!/usr/bin/env ruby
# frozen_string_literal: true

require './common'

def insert_tag(filename)
  puts "insert front matter 'tag: ---'? [Y/n]"
  return if STDIN.gets.chomp.downcase == 'n'

  puts "gsed -i '1 i ---' \"#{filename}\""
  `gsed -i '1 i ---' "#{filename}"`
  `gsed -i '1 i ---' "#{filename}"`
  puts 'front matter tag inserted'
end

def insert_title(filename)
  basename = File.basename(filename, '.md')
  basename = basename.slice(11..-1) if basename.match(/.*([0-9]{4}-[0-9]{2}-[0-9]{2})-.*/)
  puts "insert front matter 'title: #{basename}'? [Y/n]"
  return if STDIN.gets.chomp.downcase == 'n'

  puts "gsed -i '1 a title: #{basename}' \"#{filename}\""
  `gsed -i '1 a title: #{basename}' "#{filename}"`
  puts 'title front matter inserted'
end

def get_created_at(filename)
  basename = File.basename(filename, '.md')
  if basename.match(/.*([0-9]{4}-[0-9]{2}-[0-9]{2})-.*/)
    basename.slice(0..9)
  else
    puts 'Date not found. Enter a date:'
    STDIN.gets.chomp
  end
end

def insert_date_from_filename(filename)
  created_at = get_created_at(filename)
  puts "insert front matter 'date: #{created_at}'? [Y/n]"
  return if STDIN.gets.chomp.downcase == 'n'

  puts "gsed -i '1 a date: #{created_at}' \"#{filename}\""
  `gsed -i '1 a date: #{created_at}' "#{filename}"`
  puts 'date front matter inserted'
end

def get_category_from_user(_filename)
  puts 'Enter category name:'
  STDIN.gets.chomp
end

def get_category_from_folder(filename)
  File.dirname(filename).split('/').last
end

def insert_category(filename, category)
  puts "insert front matter 'category: #{category}'? [Y/n]"
  return if STDIN.gets.chomp.downcase == 'n'

  puts "gsed -i '1 a category: #{category}' \"#{filename}\""
  `gsed -i '1 a category: #{category}' "#{filename}"`
  puts 'category inserted'
end
