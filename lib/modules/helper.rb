module Helper
  CLOSE_COMMAND = 'close'.freeze

  def read_input
    input = $stdin.gets.chomp
    raise Errors::CloseError if input == CLOSE_COMMAND

    input
  end

  def read_input_with_title(title)
    puts title
    read_input
  end
end
