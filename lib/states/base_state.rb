module States
  class BaseState
    include Modules::Helper
    include Modules::Validate
    include Modules::Statistic

    APPLY_COMMAND = 'y'.freeze

    def initialize(context)
      @context = context
    end

    def step
      BaseState.new.state(read_input, @context)
    end

    def action
      raise Errors::CloseError
    end

    def save_context
      @context.save
    end
  end
end
