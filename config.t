baseURL = "http://example.org/"
languageCode = "en-us"
title = "ZAINABED"
description = "Zainabed.com is a website that contains programming tutorials. These tutorials primarily cover programming technologies like Java, Spring Boot, AngularJS, Web Design, MongoDB, Microservices, and MySQL."
theme = "PaperMod"

custom_css = ["css/custom.css"]

[menu]
[[menu.main]]
  identifier = 'Search'
  name = 'Search'
  pre = "<i class='fa fa-heart'></i>"
  url = '/search/'
  weight = -110
  [menu.main.params]
    class = 'highlight-menu-item'
[[menu.main]]
  identifier = 'Blogs'
  name = 'Blogs'
  pre = "<i class='fa fa-heart'></i>"
  url = '/blogs/'
  weight = -110
  [menu.main.params]
    class = 'highlight-menu-item'
[[menu.main]]
  identifier = 'Categories'
  name = 'Categories'
  pre = "<i class='fa fa-heart'></i>"
  url = '/categories/'
  weight = -110
  [menu.main.params]
    class = 'highlight-menu-item'
[[menu.main]]
  identifier = 'Archives'
  name = 'Archives'
  pre = "<i class='fa fa-heart'></i>"
  url = '/archives/'
  weight = -110
  [menu.main.params]
    class = 'highlight-menu-item'
[permalinks]
  blogs = '/:year/:month/:title.html'

[taxonomies]
  author = "authors"
  tag = "tags"
  category = "categories"

[outputs]
  home = [ "HTML", "RSS", "JSON" ]

[markup]
  [markup.goldmark]
    [markup.goldmark.renderer]
      unsafe = true

[params]
  [params.label]
    icon = "/images/logo-complementry-sm.png"

[sitemap]
  changefreq = 'monthly'
  filename = 'sitemap.xml'
  priority = 0.5

[[socialIcons]]
  name = "github"
  url = "https://github.com/adityatelange/hugo-PaperMod"
