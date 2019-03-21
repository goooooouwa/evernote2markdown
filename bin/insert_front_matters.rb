#!/usr/bin/env ruby

# insert front matter to html and markdown files.
# html: parse meta data -> front matter -> insert to file
# markdown: parse first line -> front matter -> insert to file

require "bundler/setup"
require './src/front_matter_parser'

insert_front_matters(ENV['PATH_TO_HTML'])
