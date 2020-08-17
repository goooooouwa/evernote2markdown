require 'ruby-pinyin'

def run
  Dir.glob('../input/_notes/*/*.md') do |filename|
    file = File.open(filename)
    puts file.read
    puts "check #{filename}? [Y/n]"
    check_file = 'y'
    # check_file = gets.chomp
    unless check_file.downcase == 'n'
      insert_title(filename)
      insert_created_date(filename)
      # insert_category(filename)
      unless filename.match(/.*([0-9]{4}-[0-9]{2}-[0-9]{2})-.*/)
        add_current_date_prefix_to_filename(filename)
        # add_created_date_prefix_to_filename(filename)
      end
      convert_filename_to_pinyin(filename)
    end
  end
end

def insert_title(filename)
  basename = File.basename(filename, ".md")
  if basename.match(/.*([0-9]{4}-[0-9]{2}-[0-9]{2})-.*/)
    basename = basename.slice(11..-1)
  end
  puts "insert front matter 'title: #{basename}'? [Y/n]"
  insert_title = 'y'
  # insert_title = gets.chomp
  unless insert_title.downcase == 'n'
    puts "gsed -i '1 a title: #{basename}' \"#{filename}\""
    `gsed -i '1 a title: #{basename}' "#{filename}"`
    puts "inserted"
  end
end

def insert_created_date(filename)
  basename = File.basename(filename, ".md")
  if basename.match(/.*([0-9]{4}-[0-9]{2}-[0-9]{2})-.*/)
    created_at = basename.slice(0..9)
  else
    created_at = File.ctime(filename).strftime("%Y-%m-%d")
  end
  puts "insert front matter 'date: #{created_at}'? [Y/n]"
  insert_date = 'y'
  # insert_date = gets.chomp
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

def convert_filename_to_pinyin(filename)
  basename = File.basename(filename, ".md")
  dirname = File.dirname(filename)
  if basename.match(/.*([0-9]{4}-[0-9]{2}-[0-9]{2})-.*/)
    date = basename.slice(0..9)
    chinese_name = basename.slice(11..-1)
    converted_filename = "#{date}-#{PinYin.permlink(chinese_name).downcase}.md"
  else
    converted_filename = "#{PinYin.permlink(basename).downcase}.md"
  end
  puts "convert filename from '#{filename}' to '#{converted_filename}'? [Y/n]"
  convert_filename = 'y'
  # convert_filename = gets.chomp
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
  puts "add date prefix '#{current_date}-'? [Y/n]"
  add_date_prefix = gets.chomp
  unless add_date_prefix.downcase == 'n'
    puts "mv \"#{filename}\" \"#{dirname}/#{filename_with_date_prefix}\""
    `mv "#{filename}" "#{dirname}/#{filename_with_date_prefix}"`
    puts "prefix added"
  end
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
