#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './common'

def insert_tag(filename)
  ask_question filename, "Insert 'tag: ---'? [Y/n]"
  # return if STDIN.gets.chomp.downcase == 'n'

  puts `gsed -i '1 i ---' "#{filename}"`
  puts `gsed -i '1 i ---' "#{filename}"`
end

def use_first_line_as_title(filename)
  first_line = `head -1 "#{filename}"`.sub(/\n/, '')[0..19]
  puts `gsed -i '1 i ---' "#{filename}"`
  puts `gsed -i '1 i ---' "#{filename}"`
  puts `gsed -i '1 a published: false' "#{filename}"`
  puts `gsed -i '1 a title: "#{first_line}"' "#{filename}"`
end

def insert_title(filename)
  basename = File.basename(filename, '.md')
  basename = basename.slice(11..-1) if basename.match(/.*([0-9]{4}-[0-9]{2}-[0-9]{2})-.*/)
  ask_question filename, "Insert 'title: #{basename}'? [Y/n]"
  # return if STDIN.gets.chomp.downcase == 'n'

  execute_command("gsed -i '1 a title: #{basename}' \"#{filename}\"")
end

def get_created_at(filename)
  basename = File.basename(filename, '.md')
  if basename.match(/.*([0-9]{4}-[0-9]{2}-[0-9]{2}).*/)
    basename.slice(0..9)
  else
    ask_question filename, 'Date not found. Enter a date:'
    STDIN.gets.chomp
  end
end

def insert_date_from_filename(filename)
  created_at = get_created_at(filename)
  ask_question filename, "Insert 'date: #{created_at}'? [Y/n]"
  # return if STDIN.gets.chomp.downcase == 'n'

  execute_command("gsed -i '1 a date: #{created_at}' \"#{filename}\"")
end

def get_category_from_user(filename)
  ask_question filename, 'Enter category name:'
  STDIN.gets.chomp
end

def get_category_from_folder(filename)
  File.dirname(filename).split('/').last
end

def insert_category(filename, category)
  ask_question filename, "Insert 'category: #{category}'? [Y/n]"
  # return if STDIN.gets.chomp.downcase == 'n'

  execute_command("gsed -i '1 a category: #{category}' \"#{filename}\"")
end
