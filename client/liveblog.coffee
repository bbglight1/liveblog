delay = (ms, func) -> Meteor.setTimeout func, ms

Articles = new Meteor.Collection 'articles'
Topics = new Meteor.Collection 'topics'

Session.set 'topic_name', null
Session.set 'article_slug', null


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

setupHighlighter = ->
  SyntaxHighlighter.all()

Meteor.startup ->
  Backbone.history.start pushState: true
  setupEpicEditor()
  setupHighlighter()
