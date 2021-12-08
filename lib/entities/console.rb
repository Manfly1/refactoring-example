module Entities
  class Console
    STORAGE_FILE = 'account.yml'.freeze

    def initialize
      @context = Context.new(STORAGE_FILE)
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
