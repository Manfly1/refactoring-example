module Errors
  class NoCardForAccount < StandardError
    def message
      puts 'No cards'
    end
  end
end
