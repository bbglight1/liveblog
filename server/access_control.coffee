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