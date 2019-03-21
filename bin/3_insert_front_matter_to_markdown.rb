#!/usr/bin/env ruby

require "bundler/setup"
require './src/front_matter_parser'

insert_front_matters(ENV['MD_PATH'])
