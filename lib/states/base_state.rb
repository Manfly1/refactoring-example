module States
  class BaseState
    include Modules::Helper
    include Modules::Validate
    include Modules::Statistic

    APPLY_COMMAND = 'y'.freeze

    def initialize(situation)
      @situation = situation
    end

    def step
      BaseState.new.state(read_input, @situation)
    end

    def action
      raise Errors::CloseError
    end

    def save_situation
      @situation.save
    end
  end
end
