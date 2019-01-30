# evernote-notes-rename-for-jekyll
scripts for rename exported evernote HTML files and resources to jekyll format

## Setup

```bash
bundle install
export PATH_TO_HTML=/path/to/your/exported/html/note/files
```

## Rename HTML note files

1. Generate the `rename.sh` to rename your exported note files:

```bash
./bin/generate.sh # the `rename.sh` will be generated in the `out` directory and a copy will be send to $PATH_TO_HTML
```

2. Examine the generated `rename.sh` script in `out` directory,
3. If everything looks good, go to your `$PATH_TO_HTML` and run the script:

```bash
bash ./rename.sh
```

Hopefully, you will now have all your exported note files renamed to jekyll format. :)

## insert front matter to HTML note files

```bash
./bin/insert.rb
```

## Test

```bash
rspec
```

