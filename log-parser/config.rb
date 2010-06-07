module Logly
  class Config
    def initialize(filename)
      @config = YAML.load_file(filename)      
      for log_config in @config['logs']
        @logs << LogConfig.new(log_config)
      end
      validate!
    end
    
    def logs
      return @logs
    end
    
    def mongodb_server
      return @config['mongodb-server']
    end
    
    private
    def validate!
      if @config.nil? then return end
      if logs.nil? then raise 'Logs arent defined' end
      if mongodb_server.nil? then raise 'MongoDB server isnt defined' end
    end
  end

  class LogConfig
    def initialize(log_config)
      @log_config = log_config
      validate!
    end
  
    def log_file_pattern
      return @log_config['log-file-pattern']
    end
  
    def log_message_pattern
      return @log_config['log-message-pattern']
    end
  
    def log_fields
      return @log_config['log-fields']
    end
  
    private
    def validate!
      if @log_config.nil? then return end
      if log_file_pattern.nil? then raise 'Log file pattern isnt defined' end
      if log_message_pattern.nil? then raise 'Log message pattern isnt defined' end
      if log_fields.nil? then raise 'Log fields arent defined' end
    end
  end
end