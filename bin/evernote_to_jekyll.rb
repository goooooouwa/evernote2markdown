# frozen_string_literal: true

require './src/evernote_to_jekyll'

puts evernote_to_jekyll(ENV['PATH_TO_HTML'])
