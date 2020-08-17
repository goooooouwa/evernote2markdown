require 'ruby-pinyin'

def run
  Dir.glob('./_notes/*/*.md') do |filename|
    puts filename.match(/.*([0-9]{4}-[0-9]{2}-[0-9]{2})-.*/)
    unless filename.match(/.*([0-9]{4}-[0-9]{2}-[0-9]{2})-.*/)
      #   puts "check #{filename}? [Y/n]"
      #   check_file = gets.chomp
      check_file = 'y'
      unless check_file.downcase == 'n'
        # insert_title(filename)
        # insert_date(filename)
        # insert_category(filename)
        # convert_filename(filename)
        # add_current_date_prefix_to_filename(filename)
        add_created_date_prefix_to_filename(filename)
      end
    end
  end
end

def insert_title(filename)
  basename = File.basename(filename, ".md")
  puts "insert front matter 'title: #{basename}'? [Y/n]"
  insert_title = gets.chomp
  unless insert_title.downcase == 'n'
    puts "gsed -i '1 a title: #{basename}' \"#{filename}\""
    `gsed -i '1 a title: #{basename}' "#{filename}"`
    puts "inserted"
  end
end

def insert_date(filename)
  created_at = File.ctime(filename).strftime("%Y-%m-%d")
  puts "insert front matter 'date: #{created_at}'? [Y/n]"
  insert_date = gets.chomp
  unless insert_date.downcase == 'n'
    puts "gsed -i '1 a date: #{created_at}' \"#{filename}\""
    `gsed -i '1 a date: #{created_at}' "#{filename}"`
    puts "inserted"
  end
end

def insert_category(filename)
  category = File.dirname(filename).split('/').last
  puts "insert front matter 'category: #{category}'? [Y/n]"
  insert_category = gets.chomp
  unless insert_category.downcase == 'n'
    puts "gsed -i '1 a category: #{category}' \"#{filename}\""
    `gsed -i '1 a category: #{category}' "#{filename}"`
    puts "inserted"
  end
end

def convert_filename(filename)
  basename = File.basename(filename, ".md")
  dirname = File.dirname(filename)
  converted_filename = "#{PinYin.permlink(basename).downcase}.md"
  puts "convert filename to '#{converted_filename}'? [Y/n]"
  convert_filename = gets.chomp
  unless convert_filename.downcase == 'n'
    puts "mv \"#{filename}\" \"#{dirname}/#{converted_filename}\""
    `mv "#{filename}" "#{dirname}/#{converted_filename}"`
    puts "converted"
  end
end

def add_current_date_prefix_to_filename(filename)
  basename = File.basename(filename, ".md")
  dirname = File.dirname(filename)
  current_date = File.ctime(filename).strftime("%Y-%m-%d")
  filename_with_date_prefix = "#{current_date}-#{basename}.md"
  puts "add date prefix '#{current_date}-'? [Y/n]"
  add_date_prefix = gets.chomp
  unless add_date_prefix.downcase == 'n'
    puts "mv \"#{filename}\" \"#{dirname}/#{filename_with_date_prefix}\""
    `mv "#{filename}" "#{dirname}/#{filename_with_date_prefix}"`
    puts "prefix added"
  end
end

def add_created_date_prefix_to_filename(filename)
  basename = File.basename(filename, ".md")
  dirname = File.dirname(filename)
  created_at = grep_search(basename)
  filename_with_date_prefix = "#{created_at}-#{basename}.md"
  puts "mv \"#{filename}\" \"#{dirname}/#{filename_with_date_prefix}\""
  `mv "#{filename}" "#{dirname}/#{filename_with_date_prefix}"`
  puts "prefix added"
end

# date.md format:
# |filename|date|
def grep_search(term)
  puts "grep '#{term}' ../input/date.md"
  match = `grep '#{term}' ../input/date.md`
  created_at = match.split('|')[-2]
  if created_at.nil?
    puts "Created date not found. Enter a new search term:"
    term = gets.chomp
    return grep_search(term)
  end
  puts created_at
  created_at
end

run
