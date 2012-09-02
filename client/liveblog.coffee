# helpers
delay = (ms, func) -> Meteor.setTimeout func, ms

has_privillege = -> Meteor.user().is_staff

Current =
  set_topic: (name) ->
    Session.set 'topic_name', name

  set_article: (slug) ->
    Session.set 'article_slug', slug

  get_topic:  ->
    Session.get 'topic_name'

  get_article: ->
    Session.get 'article_slug'

# init collections and session
Articles = new Meteor.Collection 'articles'
Topics = new Meteor.Collection 'topics'

Current.set_topic()
Current.set_article()


Meteor.subscribe 'topics'
Meteor.subscribe 'articles'


site_name = ->
  '关于Tyr的一切'

# topics
Template.topics.topics = ->
  Topics.find {}, sort: 'articles': -1

Template.topics.site_name = site_name

Template.topics.events =
  'click .topic':  (e) ->
    e.preventDefault()
    console.log 'click: ', @
    Router.setTopic @name


# article edit
Template.article_edit.caption = ->
  article = Current.get_article()
  if article then "编辑#{article}" else '创建新文章'

Template.article_edit.events =
  'blur input[type="text"], blue textarea': (e) ->
    console.log 'Put warning here'

  'click #article-save': (e) ->
    e.preventDefault()
    node = (name, type='input') ->
      switch type
        when 'input' then $("#article-edit input[name=#{name}]")
        when 'textarea' then $("#article-edit textarea[name=#{name}]")

    if has_privillege()
      title = node('title').val()
      slug = node('slug').val()
      content = node('content', 'textarea').val()
      published = node('published').attr('checked') is 'checked'
      tags = _.filter(node('tags').val().split(' '), (tag) -> return tag)
      topic = node('topic').val()

      Articles.insert
        title: title
        slug: slug
        content: content
        published: published
        author: Meteor.user().name
        created_at: (new Date).getTime()
        tags: tags
        topic: topic

# router
SiteRouter = Backbone.Router.extend
  routes:
    ':topic_name': 'getTopic'
    'article/:article_slug': 'getArticle'

  getTopic: (topic_name) ->
    console.log 'getTopic:', topic_name
    Session.set 'topic_name', topic_name

  getArticle: (article_slug) ->
    console.log 'getArticle:', article_slug
    Session.set 'article_slug', article_slug

  setTopic: (topic_name) ->
    @navigate topic_name, true

  setArticle: (article_slug) ->
    @navigate article_slug, true

Router = new SiteRouter

setupEpicEditor = ->
  opts =
    container: 'article-content'
    basePath: 'epiceditor'
    theme:
      base:'/themes/base/epiceditor.css'
      preview:'/themes/preview/preview-dark.css'
      editor:'/themes/editor/epic-light.css'

  editor = new EpicEditor(opts).load()


Meteor.startup ->
  Backbone.history.start pushState: true

