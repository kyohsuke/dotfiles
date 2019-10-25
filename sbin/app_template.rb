uncomment_lines 'Gemfile', "gem 'therubyracer'"
gem 'config'
gem "slim-rails"
gem 'twitter-bootswatch-rails', github: 'kyohsuke/twitter-bootswatch-rails'
gem 'twitter-bootswatch-rails-fontawesome'
gem 'twitter-bootswatch-rails-helpers'
gem 'execjs'
gem 'less-rails'
gem 'jquery-rails'

gem 'omniauth-twitter'
gem 'twitter'

gem_group :development do
  gem 'pry'
  gem 'pry-rails'
end

# run 'bundle lock --add-platform x86-mingw32 x86-mswin32 x64-mingw32 java'
run "bundle install"

default_template = ask("what does it use bootswatch template? [default:simplex]")
default_template = "simplex" if default_template.blank?
say "Default Template #=> #{default_template}"
generate "bootswatch:install", default_template
generate "bootswatch:import", "#{default_template} -f"
generate "bootswatch:layout", "#{default_template} -f"

application do
  "config.app_generators.stylesheet_engine :less"
  "config.assets.precompile += %w( #{default_template}.css #{default_template}.js )"
end
inject_into_file 'app/assets/stylesheets/application.css', after: " *= require_self" do
"
 *= require #{default_template}/loader
 *= require #{default_template}/bootswatch"
end

inject_into_file 'app/assets/javascripts/application.js', after: " *//= require_tree ." do
"
//= require #{default_template}/loader
//= require #{default_template}/bootswatch"
end

inject_into_file 'app/controllers/application_controller.rb', after: 'class ApplicationController < ActionController::Base' do
"
  layout '#{default_template}'
"
end

gsub_file "app/views/layouts/#{default_template}.html.slim", "= yield\n", ''
inject_into_file "app/views/layouts/#{default_template}.html.slim", after: 'body' do "
    div.navbar.navbar-default.navbar
      div.container
        div.navbar-header
          a.navbar-brand href=root_path = '#{@app_name}'
    div.container
      = yield
"
end

generate "config:install"
generate "controller", "home index --skip-routes"
generate "controller", "session create destroy --skip-routes --skip-template-engine"
route 'get "/signout" => "session#destroy"'
route 'get "/auth/:provider/callback" => "session#create"'
route 'root "home#index"'

initializer 'omniauth.rb' do <<-'FILE'
unless Settings.twitter.nil?
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :twitter, Settings.twitter[:consumer_key], Settings.twitter[:consumer_secret]
  end
end
FILE
end

inject_into_file 'app/controllers/application_controller.rb', before: "end" do "
  helper_method :signed_in?

  private
  def signed_in?
    get_client and return true if session[:oauth_token]
  end

  def get_client
    return @client unless @client.nil?

    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = Settings.twitter.consumer_key
      config.consumer_secret = Settings.twitter.consumer_secret
      config.access_token = session[:oauth_token]
      config.access_token_secret = session[:oauth_token_secret]
    end
  end

  def session_available?
    signed_in? and !@client.verify_credentials.nil?
  end
"
end

inject_into_file 'app/controllers/session_controller.rb', after: "def create" do
'
    auth = request.env["omniauth.auth"]
    redirect_to root_url, :notice => "cannot authentication." and return unless auth.provider == "twitter"

    session[:uid] = auth.uid
    session[:username] = auth.extra.access_token.params[:screen_name]
    session[:oauth_token] = auth.credentials.token
    session[:oauth_token_secret] = auth.credentials.secret

    redirect_to root_url, :notice => "cannot authentication." and return unless session_available?
    redirect_to root_url, :notice => "Signed in!"
'
end

inject_into_file 'app/controllers/session_controller.rb', after: "def destroy" do
'
  reset_session
  redirect_to root_url, :notice => "Signed out!"
'
end

create_file 'config/initializers/omniauth.rb' do <<-'FILE'
unless Settings.twitter.nil?
  Rails.application.config.middleware.use OmniAuth::Builder do
    provider :twitter, Settings.twitter[:consumer_key], Settings.twitter[:consumer_secret]
  end
end
FILE
end

empty_directory 'app/views/application'
create_file 'app/views/application/_login.html.slim' do
'- if signed_in?
  = "Welcome #{session[:username]} !"
  br
  = link_to "Sign Out", "/signout"
- else
  = link_to "Sign in with Twitter", "/auth/twitter"'
end

append_to_file 'app/views/home/index.html.slim' do
  '= render partial: "login"'
end

append_to_file 'config/settings.local.yml' do
'twitter:
  consumer_key: ""
  consumer_secret: ""'
end

rake "db:drop db:create"

remove_file "public/index.html"
remove_file "app/views/layouts/application.html.erb"

git :init
git add: "."
git commit: "-m 'First commit!'"

say "fill config/settings.local.yml at first."
