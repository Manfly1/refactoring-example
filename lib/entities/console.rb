module Entities
  class Console

    STORAGE_FILE = 'account.yml'.freeze
   
    def initialize
      @situation = Storage.new(STORAGE_FILE)
      @situation.state = States::Welcome.new(@situation)
    end

    def start
      loop do
        @situation.state.action
        @situation.state = @situation.state.next
      end
    rescue CloseError
    end
  end
end