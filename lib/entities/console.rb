module Entities
  class Console
    def initialize
      @context = Context.new
      @context.state = States::Welcome.new(@context)
    end

    def start
      loop do
        @context.state.action
        @context.state = @context.state.next
      end
    rescue Errors::CloseError
      puts 'Bye-bye'
    end
  end
end
