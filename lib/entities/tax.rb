module Entities
  class Tax
    USUAL_TYPE = 'usual'.freeze
    CAPITALIST_TYPE = 'capitalist'.freeze
    VIRTUAL_TYPE = 'virtual'.freeze
    INITIAL_TAX = 0

    def initialize(type)
      @type = type
    end

    def tax(_amount)
      case @type
      when USUAL_TYPE then amount * 0.02
      when CAPITALIST_TYPE then 10
      when VIRTUAL_TYPE then 1
      else
        initial_tax
      end
      raise Errors::CloseError
    end

    def initial_tax
      INITIAL_TAX
    end
  end
end
