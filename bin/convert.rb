#!/usr/bin/env ruby

require "bundler/setup"
require './src/evernote_to_jekyll'

puts evernote_to_jekyll(ENV['PATH_TO_HTML'])
