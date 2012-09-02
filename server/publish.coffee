###
blog entries - we call it Articles
article =
  id: uuid
  author: 'Tyr Chen'
  title: 'this is my first article'
  content: 'lots of html tags'
  created_at: new Date()
  published: false
  tags: []
  topic: topic name
###

Articles = new Meteor.Collection 'articles'
Meteor.publish 'articles', ->
  return Articles.find published: true, sort: 'created_at': -1


###
blog categories - we call it Topics
topic =
  id: uuid
  name: 'Programming' # unique
  description: 'description of the topic'
  created_at: new Date()
  articles: 0
###

Topics = new Meteor.Collection 'topics'
Meteor.publish 'topics', ->
  return Topics.find {}, sort: 'articles': -1


# access control
Meteor.startup ->
  isStaff = (userId, articles) ->
    console.log userId, articles
    return true

  canModify = (userId, articles) ->
    _.all articles, (article) ->
      article.author is userId

  Articles.allow
    insert: isStaff
    update: canModify
    remove: canModify

  Topics.allow
    insert: isStaff
    update: isStaff


# bootstrap
# if database is empty, on startup, create some basic data

if Topics.find().count() is 0
  data = [
    {name: '代码人生', description: ''}
    {name: '创业历程', description: ''}
    {name: '探索发现', description: ''}
    {name: '奇思妙想', description: ''}
    {name: '作品大全', description: ''}
    {name: '自我介绍', description: ''}
  ]
  now = (new Date()).getTime()
  for item in data
    Topics.insert
      name: item.name
      description: item.description
      articles: 0
      created_at: now
