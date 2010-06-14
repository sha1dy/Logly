require 'java'
require 'hadoop-0.20.2-core.jar'
require 'commons-logging-1.0.4.jar'

puts "ENV['CLASSPATH'] = #{ENV['CLASSPATH']}"

uri = '/test_compressed.seq'

conf = Java::OrgApacheHadoopConf::Configuration.new
conf.set('fs.default.name', 'hdfs://localhost:9000')

fs = Java::OrgApacheHadoopFs::FileSystem.get(Java::JavaNet::URI.create(uri), conf)

path = Java::OrgApacheHadoopFs::Path.new(uri)
key = Java::OrgApacheHadoopIo::IntWritable.new
value = Java::OrgApacheHadoopIo::Text.new 
writer = Java::OrgApacheHadoopIo::SequenceFile.createWriter(fs, conf, path, key.getClass(), value.getClass(), 
  Java::OrgApacheHadoopIo::SequenceFile::CompressionType::BLOCK)

for i in 0..1000000
  key.set(i)
  value.set('test' * 10)
  writer.append(key, value)
end

Java::OrgApacheHadoopIo::IOUtils.closeStream(writer)
