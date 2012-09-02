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
