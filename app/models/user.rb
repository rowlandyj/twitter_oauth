class User < ActiveRecord::Base

  has_many :tweets

  def tweet(status)
    tweet = self.tweets.create(:status => status)
    TweetWorker.perform_in(1.minute, tweet.id)
  end
end
