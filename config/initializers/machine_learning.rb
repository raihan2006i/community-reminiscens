# For the naive bayes implementation
if Rails.env.production?
  store = StuffClassifier::RedisStorage.new('classifier', { url:'redis://rediscloud:BTZLNERLTsfXxG82@pub-redis-19599.eu-west-1-2.1.ec2.garantiadata.com:19599' })
else
  store = StuffClassifier::RedisStorage.new('classifier')
end
THEMES_BAYES_TRAINER = StuffClassifier::Bayes.new('themes_bayes_trained_data', storage: store)