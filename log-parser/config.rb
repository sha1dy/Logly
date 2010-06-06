class LogConfig
  def initialize(filename)
    @config = YAML.load_file(filename)
    validate!
  end
  
  def log_file_pattern
    return @config['log-file-pattern']
  end
  
  def log_message_pattern
    return @config['log-message-pattern']
  end
  
  def log_fields
    return @config['log-fields']
  end
  
  def mongodb_server
    return @config['mongodb-server']
  end
  
  private
  def validate!
    if @config.nil? then return end
    if log_file_pattern.nil? then raise 'Log file pattern isnt defined' end
    if log_message_pattern.nil? then raise 'Log message pattern isnt defined' end
    if log_fields.nil? then raise 'Log fields arent defined' end
    if mongodb_server.nil? then raise 'MongoDB server isnt defined' end
  end
end