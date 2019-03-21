# evernote-notes-rename-for-jekyll
scripts for rename exported evernote HTML files and resources to jekyll format

## Setup

```bash
bundle install
```

## Add date prefix to HTML note files

1. Generate the `rename_html.sh` to rename your exported HTML files:

```bash
export PATH_TO_HTML=/path/to/your/exported/html/note/files
./bin/generate_html_rename_script.sh
```

2. Examine the generated `rename_html.sh` script in `out` directory,
3. If everything looks good, go to your `$PATH_TO_HTML` and run the script:

```bash
bash ./rename_html.sh
```

Hopefully, you will now have all your exported note files renamed to jekyll format. :)

## insert front matter to HTML note files

```bash
export PATH_TO_HTML=/path/to/your/exported/html/note/files
./bin/insert_front_matter.rb
```

## Add date prefix to markdown files

### prerequesities
HTML note files has date prefix.

### Run

1. Generate the `rename_markdown.sh` to rename your markdown files:

```bash
export PATH_TO_HTML=/path/to/your/exported/html/note/files
export MD_PATH=/path/to/markdown/files
./bin/generate_markdown_rename_script.sh.sh
```

2. Examine the generated `rename_markdown.sh` script in `out` directory,
3. If everything looks good, go to your `$MD_PATH` and run the script:

```bash
bash ./rename_markdown.sh
```

## Test

```bash
rspec
```

