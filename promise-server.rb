require 'sinatra'
require 'json'
require 'securerandom'

configure do
  enable :sessions
  set :session_secret, SecureRandom.base64 
end

before do
  response['Access-Control-Allow-Origin'] = 'http://code.jquery.com'
end

get '/' do
  File.read(File.join('public', 'index.html'))
end

get '/double_the_data' do
  sleep 3
  if params[:num]
    return (params[:num].to_i * 2).to_s
  else
    return 400
  end
end

get '/sqrt' do
  sleep 2
  if params[:num]
    return Math.sqrt(params[:num].to_i).to_s
  else
    return 400
  end
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
    return "logged in"
  else
    return "login failed"
  end
end

get '/logout' do
  session.clear
  redirect '/'
end

get '/empty_bank_account' do
  if session[:logged_in]
    "YOUR BANK ACCOUNT HAS BEEN EMPTIED!"
  else
    "UNAUTHORIZED"
  end
end
