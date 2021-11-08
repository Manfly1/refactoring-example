class CloseError < StandardError
  def message
    puts 'Bye-bye'
  end
end