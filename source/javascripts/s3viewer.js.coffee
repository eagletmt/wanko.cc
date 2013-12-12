window.init = ->
  document.getElementById('view-button').addEventListener('click', viewObjects)
  document.getElementById('clear-config-button').addEventListener('click', (evt) ->
    evt.preventDefault()
    if confirm('Clear localStorage. Are you sure?')
      window.localStorage.clear()
      getConfigForm().reset()
  )
  loadFromLocalStorage(getConfigForm())

getConfigForm = ->
  document.getElementById('config')

viewObjects = (evt) ->
  evt.preventDefault()
  config = {}
  for key in ['accessKeyId', 'secretAccessKey', 'region']
    config[key] = document.getElementById(key).value
  bucket = document.getElementById('bucket').value
  s3 = new AWS.S3(config)
  errorMessage = document.getElementById('error-message')
  s3.listObjects({Bucket: bucket}, (err, data) ->
    if err
      errorMessage.textContent = err.toString()
    else
      config.bucket = bucket
      if document.getElementById('save').checked
        saveToLocalStorage(config)
      errorMessage.textContent = ''
      tree = {}
      for object in data.Contents
        segments = object.Key.split('/')
        name = segments.pop()
        ptr = tree
        for segment in segments
          ptr[segment] = ptr[segment] || {}
          ptr = ptr[segment]
        ptr[name] = object.LastModified
      ul = document.getElementById('objects')
      ul.innerHTML = ''
      buildTree(tree, ul)
  )

buildTree = (tree, ul) ->
  for key, child of tree
    li = document.createElement('li')
    if child instanceof Date
      li.textContent = "#{key} [#{child.toString()}]"
    else
      li.textContent = key
      ul2 = document.createElement('ul')
      buildTree(child, ul2)
      li.appendChild(ul2)
    ul.appendChild(li)

loadFromLocalStorage = (form) ->
  storage = window.localStorage
  config = {}
  for key in ['accessKeyId', 'secretAccessKey', 'region', 'bucket']
    if val = storage.getItem(key)
      form.elements[key].value = val

saveToLocalStorage = (config) ->
  storage = window.localStorage
  for key, val of config
    storage.setItem(key, val)
