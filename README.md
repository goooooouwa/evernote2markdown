# evernote-notes-rename-for-jekyll
scripts for rename exported evernote HTML files and resources to jekyll format

## Setup

```bash
bundle install
export PATH_TO_HTML = /path/to/your/exported/note/files
```

## Run

1. Generate the `rename_commands.sh` to rename your exported note files

```bash
./bin/generate_rename_commands.sh # the `rename_commands.sh` will be generated and copied to your $PATH_TO_HTML.
```

2. Go to your `$PATH_TO_HTML` and run the generated script

```bash
bash ./rename_commands.sh
```

Hopefully, you will now have all your exported note files renamed to jekyll format. :)

## Test

```bash
rspec
```

