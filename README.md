# evernote-notes-rename-for-jekyll
- Scripts for convert evernote HTML files and resources to Jekyll format.
- Scripts to generate Jekyll front matter and date prefix for markdown files.

## Setup

```bash
bundle install
```

## Commands

### 1. [HTML] [date prefix] Add date prefix to HTML note files

#### What it does

Parse date prefix from `date` meta attribute and add it to HTML note files.

#### Data Flow

`meta[date] -> date prefix -> html filename`

#### How to use

1. Generate the `rename_html.sh` to rename your exported HTML files:

```bash
export PATH_TO_HTML=/path/to/your/exported/html/note/files
./bin/1_generate_html_rename_script.sh
```

2. Examine the generated `rename_html.sh` script in `out` directory,
3. If everything looks good, go to your `$PATH_TO_HTML` and run the script:

```bash
bash ./rename_html.sh
```

Hopefully, you will now have all your exported note files renamed to jekyll format. :)

### 2. [HTML] [front matter] Insert front matter to HTML files

#### What it does

parse front matter from `name` meta attribute in html file, then insert it to html files.

#### Data Flow

`meta[name] -> front matter -> insert to html`

#### How to use

```bash
export PATH_TO_HTML=/path/to/your/exported/html/note/files
./bin/2_insert_front_matter_to_html.rb
```

### 3. [Markdown] [front matter] Insert front matter to markdown files

#### What it does

parse front matter from first line in markdown file in the format `2019-03-20-title`, then insert it to markdown files.

#### Data Flow

 `first line -> front matter -> insert to markdown`

#### How to use

```bash
export PATH_TO_MD=/path/to/your/markdown/files
./bin/3_insert_front_matter_to_markdown.rb
```

### 4.1. [Markdown] [date prefix] Add date prefix to filename

#### What it does

Parse date prefix from front matter, and add it to filename.

#### Data Flow

`front matter -> filename`

#### How to use

```bash
export PATH_TO_MD=/path/to/your/markdown/files
./bin/4_1_add_date_prefix_to_file.sh
```

### 4.2. [Markdown] [date prefix] Copy date prefix from HTML to markdown files

What it does

Copy date prefix from HTML note files to markdown files. If you already have front matter in your markdown file, you can ignore this one.

#### Data Flow

`date prefix in html filenames -> markdown filenames`

#### How to use

1. Generate the `rename_markdown.sh` to rename your markdown files:

```bash
export PATH_TO_HTML=/path/to/your/exported/html/note/files
export PATH_TO_MD=/path/to/markdown/files
./bin/4_2_generate_markdown_rename_script.sh
```

2. Examine the generated `rename_markdown.sh` script in `out` directory,
3. If everything looks good, go to your `$PATH_TO_MD` and run the script:

```bash
bash ./rename_markdown.sh
```

### Test

```bash
rspec
```

