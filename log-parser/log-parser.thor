require 'parser.rb'
require 'config.rb'
require '../common/mongo-helper.rb'
require 'pp'

class LogParser < Thor
  desc 'parse', 'specified file and save new log lines to db'
  def parse(log_filename, config_filename)
    puts "Using config #{config_filename}"
    puts "Parsing #{log_filename}"
    unless File.exists?(log_filename) 
      puts "Destination #{log_filename} doesn't exist"
      exit
    end
    unless File.exists?(config_filename)
      puts "Config #{config_filename} doesn't exist"
      exit
    end
    
    config = LogConfig.new(config_filename)
    mongo_helper = MongoHelper.new(config)
    
    File.open(log_filename) do |f|
      f.each_line do |line|
        parsed_line = Parser.parse(line, config.log_message_pattern, config.log_fields)
        mongo_helper.upload(parsed_line)
      end
    end
  end
end