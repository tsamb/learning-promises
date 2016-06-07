require 'sinatra'
require 'json'
enable :sessions

before do
  response['Access-Control-Allow-Origin'] = 'http://code.jquery.com'
end

get '/' do
  File.read(File.join('public', 'index.html'))
end

get '/five_second_route' do
  sleep 5
  return {emoji: "straight face", time: 5}.to_json
end

get '/three_second_route' do
  sleep 3
  status 404
  return "sorry not found"
  return {emoji: "smiley face", time: 3}.to_json
end

get '/eight_second_route' do
  sleep 8
  return {emoji: "frowny face", time: 8}.to_json
end

get '/random_delay_route' do
  sleep_time = rand(2..10)
  sleep sleep_time
  return {emoji: "confused face", time: sleep_time}.to_json
end

get '/login' do
  if params[:username] == "sam" && params[:password] == "password"
    session[:logged_in] == true
  end
end

get '/logout' do
  session.clear
end

get '/empty_bank_account' do
  if session[:logged_in]
    "YOUR BANK ACCOUNT HAS BEEN EMPTIED!"
  else
    "UNAUTHORIZED"
  end
end
