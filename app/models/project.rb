require 'net/http'

class Project

  API_KEY = 'DONORSCHOOSE'
  BASE_URI = "http://api.donorschoose.org/common/json_feed.html?max=20&APIKey=#{API_KEY}"

  class << self
    attr_writer :redis

    def redis
      @redis ||= $redis
    end
  end

  def self.find_by(params)
    uri = build_uri(params)
    if projects = fetch_from(uri)
      JSON.parse projects
    end
  end

  def self.fetch_and_publish(params, user_token=nil)
    uri = build_uri(params)
    queue_job(uri, user_token)
  end

  def self.build_uri(params=nil)
    if params
      BASE_URI + "&" + params.join("&")
    else
      BASE_URI
    end
  end

  def self.queue_job(uri, token)
    Resque.enqueue Fetcher, uri, token
  end

  def self.fetch_from(uri)
    redis.get(uri)
  end
end
