module States
  class Base
    include Helper
    include Validates
    include Statistic
    include Storage

    APPLY_COMMAND = 'y'.freeze

    def initialize(context)
      @context = context
    end

    def action
      raise NotImplementedError
    end

    def next
      Factories::State.new.state(read_input, @context)
    end

    def save_context
      @context.save
    end
  end
end
