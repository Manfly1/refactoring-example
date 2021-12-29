class Console
  STORAGE_FILE = 'accounts.yml'.freeze

  def initialize
    @context = Context.new
    @context.state = States::Base.new(STORAGE_FILE)
    @context.state.state = States::Welcome.new(@context)
  end

  def start
    loop do
      @context.state.state.action
      @context.state.state = @context.state.state.next
    end
  rescue Errors::CloseError
    puts 'Bye-bye'
  end
end
