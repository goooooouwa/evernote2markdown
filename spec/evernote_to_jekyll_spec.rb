# frozen_string_literal: true

require './src/evernote_to_jekyll.rb'

RSpec.describe 'evernote_to_jekyll' do
  it '#evernote_to_jekyll' do
  end

  it '#print_rename_commands_for_files' do
  end

  it '#to_jekyll_name_group' do
    path = './spec/fixtures/exported-note.html'

    expected_result = {
      html_filename: 'exported-note.html',
      html_resources: 'exported-note.resources',
      jekyll_filename: '2017-11-16-exported-note.html',
      jekyll_resources: '2017-11-16-exported-note'
    }

    expect(to_jekyll_name_group(path)).to eq(expected_result)
  end
end
