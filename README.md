# evernote-notes-rename-for-jekyll
- Scripts for convert evernote HTML files and resources to Jekyll format.
- Scripts to generate Jekyll front matter and date prefix for markdown files.

## Setup

```bash
bundle install
```

## Commands

### 1. Add date prefix to HTML note files

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

### 2. Copy date prefix from HTML to markdown files

What it does

Copy date prefix from HTML note files to markdown files. If you already have front matter in your markdown file, you can directly run command 4.

#### Data Flow

`date prefix in html filenames -> markdown filenames`

#### How to use

1. Generate the `rename_markdown.sh` to rename your markdown files:

```bash
export PATH_TO_HTML=/path/to/your/exported/html/note/files
export MD_PATH=/path/to/markdown/files
./bin/2_generate_markdown_rename_script.sh
```

2. Examine the generated `rename_markdown.sh` script in `out` directory,
3. If everything looks good, go to your `$MD_PATH` and run the script:

```bash
bash ./rename_markdown.sh
```

### 3. Insert front matter to HTML or markdown files

#### What it does

- parse front matter from `name` meta attribute in html file, then insert it to html files.

- parse front matter from first line in markdown file in the format `2019-03-20-title`, then insert it to markdown files.

#### Data Flow

- html: `meta[name] -> front matter -> insert to html`

- markdown: `first line -> front matter -> insert to markdown`

#### How to use

```bash
export PATH_TO_HTML=/path/to/your/exported/html/note/files
./bin/3_insert_front_matter.rb
```

### 4. Add date prefix to filename

#### What it does

Parse date prefix from front matter, and add it to filename.

#### Data Flow

`front matter -> filename`

#### How to use

```bash
export TEMP=/path/to/your/markdown/files
./bin/4_add_date_prefix_to_file.sh
```

## Test

```bash
rspec
```

