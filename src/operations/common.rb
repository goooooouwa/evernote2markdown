#!/usr/bin/env ruby
# frozen_string_literal: true

def batch_process_dir(dir)
  Dir.glob("#{dir}/*.md") do |filename|
    basename = File.basename(filename)
    if basename.match(/^[0-9]{4}-[0-9]{2}-[0-9]{2}-[0-9a-z-]+[.]md$/)
      puts "skip processed file: #{basename}..."
      next
    end
    puts `head -7 "#{filename}"`
    yield(filename)
  end
end
