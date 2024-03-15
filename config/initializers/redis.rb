require 'redis-namespace'

REDIS = Redis.new
REDIS_CACHE = Redis::Namespace.new(:cache, redis: REDIS)
