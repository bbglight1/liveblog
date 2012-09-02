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