# frozen_string_literal: true

require './src/evernote_to_jekyll.rb'

RSpec.describe 'evernote_to_jekyll' do
  before(:all) do
    @html_dir = './spec/fixtures'
  end

  it '#evernote_to_jekyll' do
    rename_commands = <<~HEREDOC
      mv exported-note.html 2017-11-16-exported-note.html
      mv exported-note.resources 2017-11-16-exported-note
    HEREDOC
    expect(evernote_to_jekyll(@html_dir)).to eq(rename_commands)
  end

  it '#get_rename_commands' do
    html_paths = Dir["#{@html_dir}/*.html"]
    rename_commands = <<~HEREDOC
      mv exported-note.html 2017-11-16-exported-note.html
      mv exported-note.resources 2017-11-16-exported-note
    HEREDOC
    expect(get_rename_commands(html_paths)).to eq(rename_commands)
  end

  it '#html_to_jekyll' do
    html_path = "#{@html_dir}/exported-note.html"

    expected_result = {
      html_filename: 'exported-note.html',
      html_resources: 'exported-note.resources',
      jekyll_filename: '2017-11-16-exported-note.html',
      jekyll_resources: '2017-11-16-exported-note'
    }

    expect(html_to_jekyll(html_path)).to eq(expected_result)
  end
end
