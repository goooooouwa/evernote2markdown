# evernote-notes-rename-for-jekyll
scripts for rename exported evernote HTML files and resources to jekyll format

## Setup

```bash
bundle install
export PATH_TO_HTML = /path/to/your/exported/note/files
```

## Run

1. Generate the `rename_commands.sh` to rename your exported note files:

```bash
./bin/generate_rename_commands.sh # the `rename_commands.sh` will be generated in the `out` directory and a copy will be send to $PATH_TO_HTML ready for use.
```

2. Examine the generated `rename_commands.sh` script,
3. If everything looks good, go to your `$PATH_TO_HTML` and run the script:

```bash
bash ./rename_commands.sh
```

Hopefully, you will now have all your exported note files renamed to jekyll format. :)

## Test

```bash
rspec
```

