module States
  class Base
    include Modules::Helper
    include Modules::Validates
    include Modules::Statistic

    APPLY_COMMAND = 'y'.freeze

    def initialize(context)
      @context = context
    end

    def action
      raise NotImplementedError
    end

    def next
      Factories::StateFactory.new.state(read_input, @context)
    end

    def save_context
      @context.save
    end
  end
end
