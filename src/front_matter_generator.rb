#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './operations/insert_front_matter.rb'
require_relative './operations/transform_filename.rb'

def a1_batch_insert_tag(dir)
  batch_process_dir(dir) do |filename|
    insert_tag(filename)
  end
end

def a1_batch_insert_title(dir)
  batch_process_dir(dir) do |filename|
    insert_title(filename)
  end
end

def a1_batch_insert_date(dir)
  batch_process_dir(dir) do |filename|
    insert_date_from_filename(filename)
  end
end

def b3_batch_insert_category_from_folder(dir)
  batch_process_dir(dir) do |filename|
    insert_category(get_category_from_folder(filename), filename)
  end
end

def b3_batch_insert_and_move_to_category(dir)
  batch_process_dir(dir) do |filename|
    category = get_category_from_folder(filename)
    insert_category(filename, category)
    move_to_category_folder(filename, category)
  end
end

def b2_batch_permlink_filename(dir)
  batch_process_dir(dir) do |filename|
    permlink_filename(filename)
  end
end

def b1_batch_add_current_date_prefix(dir)
  batch_process_dir(dir) do |filename|
    add_current_date_prefix(filename)
  end
end

def b1_batch_add_created_date_prefix_by_search(dir)
  batch_process_dir(dir) do |filename|
    add_created_date_prefix_by_search(filename)
  end
end

# command line params:
# 1. md files directory, e.g. path/to/writings/_notes
def run(dir)
  # ## insert front matter
  a1_batch_insert_tag(dir)
  a1_batch_insert_title(dir)
  a1_batch_insert_date(dir)

  # ## transform filename
  # b1_batch_add_current_date_prefix(dir)
  # b1_batch_add_created_date_prefix_by_search(dir)
  b2_batch_permlink_filename(dir)
  # b3_batch_insert_category_from_folder(dir)
  b3_batch_insert_and_move_to_category(dir)
end

run(ARGV[0])
