# frozen_string_literal: true

require './src/en_html_converter.rb'

RSpec.describe ENHTMLConverter do
  before(:all) do
    @html_dir = './spec/fixtures'
  end

  it '.generate_rename_commands' do
    generate_rename_commands = <<~HEREDOC
      mv exported-note.html 2017-11-16-exported-note.html
      mv exported-note.resources 2017-11-16-exported-note
    HEREDOC
    expect(ENHTMLConverter.generate_rename_commands(@html_dir)).to eq(generate_rename_commands)
  end

  it '#generate_rename_command' do
    html_path = "#{@html_dir}/exported-note.html"

    generated_rename_command = <<~HEREDOC
      mv exported-note.html 2017-11-16-exported-note.html
      mv exported-note.resources 2017-11-16-exported-note
    HEREDOC
    expect(ENHTMLConverter.new(html_path).generate_rename_command).to eq(generated_rename_command)
  end

  it '#name_map' do
    html_path = "#{@html_dir}/exported-note.html"

    name_map = {
      html_filename: 'exported-note.html',
      html_resources: 'exported-note.resources',
      jekyll_filename: '2017-11-16-exported-note.html',
      jekyll_resources: '2017-11-16-exported-note'
    }

    expect(ENHTMLConverter.new(html_path).name_map).to eq(name_map)
  end
end
