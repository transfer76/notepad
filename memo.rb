class Memo < Post
  def read_from_console
    puts 'This is new note (all before \'end\'): '

    line = nil

    until line == 'end'
      line = STDIN.gets.chomp
      @text << line
    end

    @text.pop
  end

  def to_strings
    time_string = "Created: #{@created_at.strftime('%Y.%m.%d, %H:%M:%S')} \n"

    @text.unshift(time_string)
  end

  def to_db_hash
    super.merge('text' => @text.join('\n'))
  end

  def load_data(data_hash)
    super(data_hash)

    @text = data_hash['text'].split('\n')
  end
end
