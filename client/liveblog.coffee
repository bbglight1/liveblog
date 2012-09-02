delay = (ms, func) -> Meteor.setTimeout func, ms

Articles = new Meteor.Collection 'articles'
Topics = new Meteor.Collection 'topics'

Session.set 'topic_id', null
Session.set 'article_id', null


Meteor.subscribe 'topics'
Meteor.subscribe 'articles'

# topics
Template.topics.topics = ->
  Topics.find {}, sort: 'articles': -1

Template.topics.site_name = ->
  'Tyr的博客'