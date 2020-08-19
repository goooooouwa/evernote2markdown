#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './operations/insert_front_matter.rb'
require_relative './operations/transform_filename.rb'

def batch_insert_tag(dir)
  batch_process_dir(dir) do |filename|
    insert_tag(filename)
  end
end

def batch_insert_title(dir)
  batch_process_dir(dir) do |filename|
    insert_title(filename)
  end
end

def batch_insert_date(dir)
  batch_process_dir(dir) do |filename|
    insert_date_from_filename(filename)
  end
end

def batch_insert_category_from_folder(dir)
  batch_process_dir(dir) do |filename|
    insert_category(get_category_from_folder(filename), filename)
  end
end

def batch_insert_and_move_to_category(dir)
  batch_process_dir(dir) do |filename|
    category = get_category_from_user(filename)
    insert_category(filename, category)
    move_to_category_folder(filename, category)
  end
end

def batch_convert_filename(dir)
  batch_process_dir(dir) do |filename|
    convert_filename(filename)
  end
end

def batch_add_current_date_prefix(dir)
  batch_process_dir(dir) do |filename|
    add_current_date_prefix(filename)
  end
end

def batch_add_created_date_prefix_by_search(dir)
  batch_process_dir(dir) do |filename|
    add_created_date_prefix_by_search(filename)
  end
end

# command line params:
# 1. md files directory, e.g. path/to/writings/_notes
def run(dir)
  batch_insert_tag(dir)

  batch_insert_title(dir)
  batch_convert_filename(dir)

  # batch_add_current_date_prefix(dir)
  # batch_add_created_date_prefix_by_search(dir)
  batch_insert_date(dir)

  # batch_insert_category_from_folder(dir)
  batch_insert_and_move_to_category(dir)
end

run(ARGV[0])
