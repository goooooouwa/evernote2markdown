---
title: "Safari issue: 导出的PDF中文无法拷贝"
date: "2018-09-12"
---

## Issue Description

使用Safari将网站导出的PDF文件后，文件中的中文内容无法正常拷贝。

## Insights:

- 所有网站，使用Safari应用程序打印的PDF无法拷贝中文
- 部分网站（字体？），使用Chrome应用程序打印的PDF可以拷贝中文
- 所有网站，使用Skia/PDF m69制作的PDF基本可用

打印PDF中文拷贝影响因素包括：网站、应用程序、制作程序。

Test Report:

**App**

**内容**

**导出方式**

**信息**

**拷贝文字结果**

 **PDF文件地址**

**Chrome**

Apple Kyoto 将于星期六在京都市四条通盛大开幕

文件 -> 打印 -> 使用Preview打开

应用程序：Chrome 制作程序：Quartz

OK

https://goooooouwa.github.io/assets/attachments/2018-09-12-issue-safari-export-pdf-chinese-characters-copy-fail/test-result/chrome/open-in-preview/apple-news.pdf

**Chrome**

头文字D全车型盘点

文件 -> 打印 -> 使用Preview打开

应用程序：Chrome 制作程序：Quartz

Fail

https://goooooouwa.github.io/assets/attachments/2018-09-12-issue-safari-export-pdf-chinese-characters-copy-fail/test-result/chrome/open-in-preview/initial-d-bbs.pdf

**Chrome**

Apple Kyoto 将于星期六在京都市四条通盛大开幕

文件 -> 打印 -> 使用系统对话框打印

应用程序：Chrome 制作程序：Quartz

OK

https://goooooouwa.github.io/assets/attachments/2018-09-12-issue-safari-export-pdf-chinese-characters-copy-fail/test-result/chrome/print-using-system-dailog/apple-news.pdf

**Chrome**

头文字D全车型盘点

文件 -> 打印 -> 使用系统对话框打印

应用程序：Chrome 制作程序：Quartz

Fail

https://goooooouwa.github.io/assets/attachments/2018-09-12-issue-safari-export-pdf-chinese-characters-copy-fail/test-result/chrome/print-using-system-dailog/initial-d-bbs.pdf

**Chrome**

Apple Kyoto 将于星期六在京都市四条通盛大开幕

文件 -> 打印 -> 另存为PDF

应用程序：Mozilla/5.0 (Macintosh; Intel Mac OS X 10\_13\_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36 制作程序：Skia/PDF m69

OK

https://goooooouwa.github.io/assets/attachments/2018-09-12-issue-safari-export-pdf-chinese-characters-copy-fail/test-result/chrome/save-as-pdf/apple-news.pdf

**Chrome**

头文字D全车型盘点

文件 -> 打印 -> 另存为PDF

应用程序：Mozilla/5.0 (Macintosh; Intel Mac OS X 10\_13\_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.81 Safari/537.36 制作程序：Skia/PDF m69

Partially OK. 用Adobe Acrobat 拷贝OK； 用Preview可以拷贝文字, 但拷贝内容的顺序是反的（字从右到左）

https://goooooouwa.github.io/assets/attachments/2018-09-12-issue-safari-export-pdf-chinese-characters-copy-fail/test-result/chrome/save-as-pdf/initial-d-bbs.pdf

**Safari**

Apple Kyoto 将于星期六在京都市四条通盛大开幕

文件 -> 打印

应用程序：Safari 制作程序：Quartz

Fail

https://goooooouwa.github.io/assets/attachments/2018-09-12-issue-safari-export-pdf-chinese-characters-copy-fail/test-result/safari/file-print/apple-news.pdf

**Safari**

头文字D全车型盘点

文件 -> 打印

应用程序：Safari 制作程序：Quartz

Fail

https://goooooouwa.github.io/assets/attachments/2018-09-12-issue-safari-export-pdf-chinese-characters-copy-fail/test-result/safari/file-print/initial-d-bbs.pdf

**Safari**

Apple Kyoto 将于星期六在京都市四条通盛大开幕

导出为PDF

应用程序：无 制作程序：Quartz

OK

https://goooooouwa.github.io/assets/attachments/2018-09-12-issue-safari-export-pdf-chinese-characters-copy-fail/test-result/safari/export-as-pdf/apple-news.pdf

**Safari**

头文字D全车型盘点

导出为PDF

应用程序：无 制作程序：Quartz

OK

https://goooooouwa.github.io/assets/attachments/2018-09-12-issue-safari-export-pdf-chinese-characters-copy-fail/test-result/safari/export-as-pdf/initial-d-bbs.pdf

**Safari**

Apple Kyoto 将于星期六在京都市四条通盛大开幕

Reader -> 打印

应用程序：Safari 制作程序：Quartz

Fail

https://goooooouwa.github.io/assets/attachments/2018-09-12-issue-safari-export-pdf-chinese-characters-copy-fail/test-result/safari/reader-mode-print/apple-news.pdf

**Safari**

Evernote 联系我们 (头文字D全车型盘点 not available in Reader mode）

Reader -> 打印

应用程序：Safari 制作程序：Quartz

Fail

https://goooooouwa.github.io/assets/attachments/2018-09-12-issue-safari-export-pdf-chinese-characters-copy-fail/test-result/safari/reader-mode-print/contact-us-evernote.pdf
