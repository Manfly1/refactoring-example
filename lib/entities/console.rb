module Entities
  class Console
    include Storage

    STORAGE_FILE = 'account.yml'.freeze
   
    def initialize
      @situation = Storage.new(STORAGE_FILE)
      @situation.state = States::State.new(@situation)
    end

    def run
      loop do
        @situation.state.action
        @situation.state = @situation.state.next
      end
    rescue CloseError
    end
  end
end