module States
  class BaseState
    include Helper

    APPLY_COMMAND = 'y'.freeze

    def initialize(situation); end

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
