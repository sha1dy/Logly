require 'rubygems'
require 'mongo'

class MongoHelper
  def initialize(config)
    @mongo = Mongo::Connection.new(config.mongodb_server).db("logly")
    @log_lines_coll = @mongo['log_lines']
  end
  
  def upload(log)
    @log_lines_coll.insert(log)
  end
  
  def get_logs
    return @log_lines_coll.find    
  end
end