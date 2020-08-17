## Example

原始文件名：`_notes/business/企业的六大职能部门.md`

文件创建日期：2020-8-17

目标文件名：`2020-8-17-qi-ye-de-liu-da-zhi-neng-bu-men.md`

目标front matter:

```
---
title: 企业的六大职能部门
date: 2020-8-17
category: business
---
```

## 前提

创建一个文本文件并放置于某个目录中

## 功能

根据文件创建日期生成并添加date

根据中文文件名生成并添加title

根据目录生成并添加category

将中文文件名转换为英文字符文件名

将文件创建日期添加到文件名

可跳过操作

可跳过文件



### 根据中文文件名生成并添加title
for loop 每个目录的每个文件

得到文件的名字

insert到文件的front matter

### 根据文件创建日期生成并添加date
for loop 每个目录的每个文件

得到文件的创建日期

insert到文件的front matter

### 根据目录生成并添加category

for loop 每个目录的每个文件

得到文件的父目录

### 将中文文件名转换为英文字符文件名

for loop 每个目录的每个文件

生成英文字符文件名

重命名文件

### 将文件创建日期添加到文件名

for loop 每个目录的每个文件

得到文件创建日期

重命名文件

### 可跳过操作

执行操作前等待用户输入

### 可跳过文件

处理文件前等待用户输入