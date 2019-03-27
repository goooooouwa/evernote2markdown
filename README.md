# Evernote <=> Markdown

2-way transform between Evernote and Markdown format

## Welcome

作为一个经常东想西想的人，我经常在Evernote中记录一些想法，随着时间推移有些想法逐渐成熟，当我想将这些想法分享到我的博客（Jekyll），却苦于找不到趁手的工具。

本质上，我希望能将Evernote笔记转换成Markdown格式（最好Markdown也能转成笔记），这样我就可以将笔记发布到如Jekyll博客之类的写作平台。

EEvernote原生不支持Markdown，市面上有一些工具（如，马克飞象）和替代品（如，有道云笔记），但是这些工具有么收费、要么一堆广告，不符合开源精神。于是，我又在Github上寻找开源的Evernote转Markdown工具，比如[ever2simple](https://github.com/dougdiego/ever2simple)，[geeknotes](https://github.com/jeffkowalski/geeknote), [sublime-evernote](https://github.com/bordaigorl/sublime-evernote), vscode_evernote, [chienote](https://github.com/chiepomme/chienote), [evernote-dump](https://github.com/exomut/evernote-dump)。试用下来，这些工具要么支持的Markdown格式较少（如ever2simple），要么因为安全考虑被Evernote官方禁用（如geeknotes, sublime_evernote, vscode_evernote），要么已经多年不维护了（如chienote）。总之，当前市面上并没有一款免费开源的支持Evernote与Markdown互相转换的产品。

于是我开始自己写... 就有了这个项目。

现在，evernote2markdown已经支持将Evernote导出的html转换为Markdown，并且可以自动添加Jekyll的front matter。以后计划支持更多Markdown格式，并且支持将Markdown转换为Evernote富文本笔记。

如果你也是Evernote的忠实用户，而你也希望在Evernote中使用Markdown写笔记，或者将Evernote笔记导出为Markdown格式，欢迎加入evernote2markdown开源项目！

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
./bin/3_insert_front_matter_to_md.rb
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
./bin/4_2_generate_md_rename_script.sh
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

