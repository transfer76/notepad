require_relative 'post'
require_relative 'link'
require_relative 'memo'
require_relative 'task'

puts 'Hello! I\'m yours notepad!'
puts
puts 'What do you want to note?'

choices = Post.post_types.keys

choice = -1

until choice >= 0 && choice < choices.size
  choices.each_with_index do |type, index|
    puts "\t#{index}. #{type}"
  end
  choice = STDIN.gets.to_i
end

entry = Post.create(choices[choice])

entry.read_from_console

id = entry.save_to_db

puts " Yes! note is saved! id = #{id}"
