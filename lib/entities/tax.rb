module Entities
  class Tax
    USUAL_TYPE = 'usual'.freeze
    CAPITALIST_TYPE = 'capitalist'.freeze
    VIRTUAL_TYPE = 'virtual'.freeze
    DEFAULT_TAX = 0
    TAXES = {
      USUAL_TYPE: 0.05,
      CAPITALIST_TYPE: 0.04,
      VIRTUAL_TYPE: 0.88
    }.freeze

    def initialize(type)
      @type = type
    end

    def tax(_amount)
      raise NotImplementedError 'Method tax not implemented'
    end

    def default_tax
      DEFAULT_TAX
    end
  end
end
