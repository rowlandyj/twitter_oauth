get '/' do
  if logged_in?
    redirect "/new_tweet"
  else
    erb :index
  end
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  # our request token is only valid until we use it to get an access token, so let's delete it from our session
  session.delete(:request_token)

  # at this point in the code is where you'll need to create your user account and store the access token
  user = User.find_by_username(@access_token.params[:screen_name])
  
  if !user
    user = User.create(username: @access_token.params[:screen_name], oauth_token: @access_token.token, oauth_secret: @access_token.secret)
  end
  session[:user_id] = user.id
  redirect '/new_tweet'
end

get '/new_tweet' do
  erb :new_tweet
end

post '/new_tweet' do
  current_user.tweet(params[:tweet_content])
end

get '/status/:job_id' do
  job_is_complete(params[:job_id]) ? "success" : "FAILLLLZZZzzzZZzzZZz" 
end
