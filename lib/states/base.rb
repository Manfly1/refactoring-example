module States
  class Base
    include Modules::Helper
    include Modules::Validate
    include Modules::Statistic

    APPLY_COMMAND = 'y'.freeze

    def initialize(context)
      @context = context
    end

    def action
      raise Errors::CloseError
    end

    def save_context
      @context.save
    end
  end
end
