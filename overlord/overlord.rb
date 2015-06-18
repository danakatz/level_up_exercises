# run `ruby overlord.rb` to run a webserver for this app

require 'sinatra'
require_relative 'models/bomb'

class Overlord < Sinatra::Base
  enable :sessions

  get '/' do
    if session[:exploded]
      redirect to('/bang')
    elsif session[:configured]
      erb :index, :layout => true
    else
      redirect to('/configure')
    end
  end

  post '/' do
    redirect to('/') if params['code'].empty?

    code = params['code']
    session[:deact_attempts] = 0 unless session[:deact_attempts]
    if bomb.active && !(code == bomb.deact_code || code == bomb.act_code)
      session[:deact_attempts] = session[:deact_attempts] + 1
    elsif bomb.active && (code == bomb.deact_code || code == bomb.act_code)
      session[:deact_attempts] = 0
    end

    if session[:deact_attempts] == 3
      session[:exploded] = true
      redirect to('/bang')
    else
      bomb.input_code(code)
      redirect to('/')
    end
  end

  get '/configure' do
    if session[:configured]
      erb :index, :layout => true
    else
      erb :configure, :layout => true
    end
  end

  post '/configure' do
    bomb.set_activation_code(params['act_code']) unless params['act_code'].empty?
    bomb.set_deactivation_code(params['deact_code']) unless params['deact_code'].empty?
    session[:configured] = true
    redirect to('/')
  end

  get '/bang' do
    if session[:exploded]
      erb :explosion, :layout => true
    else
      redirect to('/')
    end
  end

  helpers do
    def bomb
      session[:bomb] = Bomb.new unless session[:bomb]
      return session[:bomb]
    end

    def bomb_img_url
      if bomb.active
        "http://www.clipartlord.com/wp-content/uploads/2014/10/bomb8.png"
      else
        "http://4vector.com/i/free-vector-cartoon-bomb-clip-art_120883_cartoon-bomb-clip-art/Cartoon_Bomb_clip_art_hight.png"
      end
    end

    def input_label
      if bomb.active
        "Deactivation code: "
      else
        "Activation code: "
      end
    end
  end
end