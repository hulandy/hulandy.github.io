---
layout: default
title: 首页
---

# 欢迎来到我的博客

## 最新文章
{% for post in site.posts limit:5 %}
### [{{ post.title }}]({{ post.url }})
{{ post.date | date: "%Y年%m月%d日" }}

{{ post.excerpt | truncatewords: 30 }}

{% endfor %}

## 页面
- [关于](pages/about)
- [联系](pages/contact)
