require "sinatra"
require "assistly"
require "./pivotal"

Assistly.configure do |config|
  config.support_email      = "help@example.com"
  config.subdomain          = ENV["ASSISTLY_SUBDOMAIN"]
  config.consumer_key       = ENV["CONSUMER_KEY"]
  config.consumer_secret    = ENV["CONSUMER_SECRET"]
  config.oauth_token        = ENV["OAUTH_TOKEN"]
  config.oauth_token_secret = ENV["OAUTH_TOKEN_SECRET"]
end

use Rack::Auth::Basic do |username, password|
  username == ENV["HTTP_BASIC_USERNAME"] && password == ENV["HTTP_BASIC_PASSWORD"]
end

get "/" do
  content_type "text/xml", :charset => "utf-8"
  Pivotal.new.cases_to_xml Assistly.cases(
    :labels => ENV["ASSISTLY_LABELS"] || "", 
    :channels => ENV["ASSISTLY_CHANNELS"] || "",
    :status => "new,open,pending", 
    :count => 100).results
end