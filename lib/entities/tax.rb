module Entities
  class Tax
    USUAL_TYPE = 'usual'.freeze
    CAPITALIST_TYPE = 'capitalist'.freeze
    VIRTUAL_TYPE = 'virtual'.freeze
    INITIAL_TAX = 0

    def initialize(type)
      @type = type
    end

    def tax(amount)
      raise NotImplementedError
    end

    def initial_tax
      INITIAL_TAX
    end
  end
end