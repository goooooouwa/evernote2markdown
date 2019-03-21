#!/usr/bin/env ruby
# frozen_string_literal: true

require 'bundler/setup'
require './src/en_html_converter'

puts ENHTMLConverter.generate_rename_commands(ENV['PATH_TO_HTML'])
