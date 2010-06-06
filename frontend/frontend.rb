require 'rubygems'
require 'sinatra'
require '../common/mongo-helper.rb'
require 'config.rb'

get '/' do
  config = FrontendConfig.new
  mongo_helper = MongoHelper.new(config)
  
  logs = ''
  mongo_helper.get_logs.each do |log|
    logs = logs + log.inspect + '</br>'
  end
  
  return logs
end