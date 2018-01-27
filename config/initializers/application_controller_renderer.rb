# Be sure to restart your server when you modify this file.

# ActiveSupport::Reloader.to_prepare do
#   ApplicationController.renderer.defaults.merge!(
#     http_host: 'example.org',
#     https: false
#   )
# end

# Load custom Folders in app
Dir[Rails.root.join('app/repository/**/*.rb')].each { |f| require f }
Dir[Rails.root.join('app/services/**/*.rb')].each { |f| require f }