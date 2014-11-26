require 'sinatra'
require 'twitter'
require 'dotenv'
require 'pry'
require_relative 'bavard'

Dotenv.load

client = Twitter::REST::Client.new do |config|
  config.consumer_key    = ENV['CONSUMER_KEY']
  config.consumer_secret = ENV['CONSUMER_SECRET']
end

@@liste = []

get '/recherche' do
  # récupération des Tweets
  recherche = client.search("educatice")
  # simplification des Tweets
  @@liste = recherche.map do |tweet|
    {nom: tweet.user.screen_name, message: tweet.text} 
  end
  redirect to '/'
end

get '/' do
  @bavards = plus_bavard(@@liste).sort_by { |tweet| tweet.last }.reverse.to_h 
  haml :index
end


__END__

@@ layout
%html
  %h1 Dojo EducaTweets
  = yield

@@ index
.title 
  = "J'ai trouvé #{@@liste.count} tweets contenant le mot \"educatice\""
%a{href: '/recherche'} Lancer la recherche
.bavards
  %h2 Les plus bavards
  - @bavards.each do |bavard|
    = "#{bavard.key} : #{bavard.value}" 
