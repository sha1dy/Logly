require 'java'
require 'hadoop-0.20.2-core.jar'
require 'commons-logging-1.0.4.jar'

puts "ENV['CLASSPATH'] = #{ENV['CLASSPATH']}"

uri = '/test_compressed.seq'

conf = Java::OrgApacheHadoopConf::Configuration.new
conf.set('fs.default.name', 'hdfs://localhost:9000')

fs = Java::OrgApacheHadoopFs::FileSystem.get(Java::JavaNet::URI.create(uri), conf)

path = Java::OrgApacheHadoopFs::Path.new(uri)
reader = Java::OrgApacheHadoopIo::SequenceFile::Reader.new(fs, path, conf)
key = Java::OrgApacheHadoopIo::IntWritable.new
value = Java::OrgApacheHadoopIo::Text.new

for i in 0..10
  reader.next(key, value)
  puts key.to_s + ' ' + value.to_s
end
