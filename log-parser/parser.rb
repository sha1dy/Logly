require 'pp'

class Parser
  def self.parse(line, pattern, fields)
    parsed_chunks = line.scan(Regexp.new(pattern))
    if parsed_chunks.length != fields.length 
      puts "Parsed fields count is #{parsed_chunks.length} but configured fields count is #{fields.length}" 
    end
    
    parsed_line = Hash.new()
    for field_index in 0..(fields.length - 1)
      parsed_line[fields[field_index]] = parsed_chunks[field_index]
    end
    pp parsed_line
    return parsed_line
  end
end