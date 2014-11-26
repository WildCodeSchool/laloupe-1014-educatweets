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
  %p= "J'ai trouvé #{@@liste.count} tweets contenant le mot \"educatice\""
  %p= "Ils ont été rédigés par #{@bavards.count} personnes"

%a{href: '/recherche'} Lancer la recherche
.bavards
  %h2 Les plus bavards
  - @bavards.each do |nom, compteur|
    %p= "#{compteur} par @#{nom}" 
