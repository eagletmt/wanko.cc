activate :dotenv

activate :deploy do |deploy|
  deploy.build_before = true
  deploy.method = :rsync
  deploy.flags = '-avzz'
  deploy.host = ENV['DEPLOY_HOST']
  deploy.port = ENV['DEPLOY_PORT']
  deploy.path = ENV['DEPLOY_PATH']
  deploy.clean = true
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
