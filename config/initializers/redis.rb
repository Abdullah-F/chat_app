if Rails.env.test?
  RedisClient = MockRedis.new
else
  RedisClient = Redis.new(url: ENV.fetch('REDIS_URL'))
end
