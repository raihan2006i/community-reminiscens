# For the naive bayes implementation
store = StuffClassifier::RedisStorage.new('classifier')
THEMES_BAYES_TRAINER = StuffClassifier::Bayes.new('themes_bayes_trained_data', storage: store)