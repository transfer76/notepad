require_relative 'lib/post'
require_relative 'lib/link'
require_relative 'lib/memo'
require_relative 'lib/task'
require 'optparse'

options = {}

OptionParser.new do |opt|
  opt.banner = 'Usage: read.rb [options]'
  opt.on('-h', 'Prints this help') do
    puts opt
    exit
  end

  opt.on('--type POST_TYPE', 'what type of messages to show (anything default)') { |o| options[:type] = o }
  opt.on('--id POST_ID', 'if id — to show only this text') { |o| options[:id] = o }
  opt.on('--limit NUMBER', 'how much last messeges to show (any default)') { |o| options[:limit] = o }
end.parse!

result = if options[:id].nil?
           Post.find_all(options[:limit], options[:type])
         else
           Post.find_by_id(options[:id])
         end

if result.is_a? Post
  puts "Note #{result.class.name}, id = #{options[:id]}"

  result.to_strings.each { |line| puts line }
else
  print '| id                 '
  print '| @type              '
  print '| @created_at        '
  print '| @text              '
  print '| @url               '
  print '| @due_date          '
  print '| '

  result.each do |row|
    puts
    row.each do |element|
      element_text = "| #{element.to_s.delete('\n')[0..17]}"
      element_text << ' ' * (21 - element_text.size)
      print element_text
    end
    print '|'
  end
  puts
end
