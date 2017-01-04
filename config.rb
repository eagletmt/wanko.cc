activate :dotenv

activate :rsync do |rsync|
  rsync.production_server = ENV['DEPLOY_HOST']
  rsync.path = ENV['DEPLOY_PATH']
  rsync.user = ENV['USER']
  rsync.rsync_flags = '-avzz'
end

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

configure :development do
  activate :livereload
end

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :asset_hash
end

# i18n 0.6.9
I18n.enforce_available_locales = true

activate :sprockets
bower_dir = JSON.parse(File.read(File.join(root, '.bowerrc')))['directory']
sprockets.append_path(File.join(root, bower_dir))
