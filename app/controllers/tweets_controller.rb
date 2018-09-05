class TweetsController < ApplicationController
  def create
    token = cookies.signed[:twitter_session_token]
    session = Session.find_by(token: token)

    if session
      user = session.user
      tweet = user.tweets.new(tweet_params)

      if tweet.save
        render json: {
          tweet: {
            username: user.username,
            message: tweet.message
          }
        }
      else
        render json: {
          success: false
        }
      end
    else
      render json: {
        success: false
      }
    end
  end

  def destroy
    token = cookies.signed[:twitter_session_token]
    session = Session.find_by(token: token)

    if session
      user = session.user
      tweet = Tweet.find_by(id: params[:id], user_id: user.id)

      if tweet and tweet.destroy
        render json: {
          success: true
        }
      else
        render json: {
          success: false
        }
      end
    else
      render json: {
        success: false
      }
    end
  end

  def index
    @tweets = Tweet.all.order(created_at: :desc)
    render 'tweets/index'
  end

  def index_by_user
    user = User.find_by(username: params[:username])
    @tweets_by_user = Tweet.where(user_id: user.id).order(created_at: :desc)
    if @tweets_by_user
      render 'tweets/index_by_user'
    else
      render json: {
        tweet: []
      }
    end
  end

  def search
    tweets = Tweet.fuzzy_search(message: params[:keyword])

    if tweets
      tweets.each do |tweet|
        render json: {
          tweet: {
            message: tweet.message
          }
        }
      end
    else
      render json: {
        tweet: []
      }
    end
  end

  private

    def tweet_params
      params.require(:tweet).permit(:message)
    end
end
