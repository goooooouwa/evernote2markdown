#!/usr/bin/env ruby
# frozen_string_literal: true

def ask_question(filename, question)
  display_content(filename)
  puts '=================== Question ======================'
  puts question
end

def display_content(filename)
  system 'clear'
  puts "============== File: #{filename} ================"
  puts `head -7 "#{filename}"`
end

def execute_command(command)
  `#{command}`
  puts "[Done] #{command}"
end

def batch_process_dir(dir)
  Dir.glob("#{dir}/*.md") do |filename|
    basename = File.basename(filename)
    if basename.match(/^[0-9]{4}-[0-9]{2}-[0-9]{2}-[0-9a-z-]+[.]md$/)
      puts "skip processed file: #{basename}..."
      next
    end
    yield(filename)
  end
end
