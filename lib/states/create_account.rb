module States
  class CreateAccount < Base
    CREATE_ACCOUNT_STATE = 'create'.freeze

    def action
      @errors = []
      @context.state.extant_account = Entities::Account.new(name: name_input, login: login_input, age: age_input,
                                                            password: password_input)
      return if errors

      @context.state.accounts << @context.state.extant_account
      @context.state.save
    end

    def next
      return CreateAccount.new(@context) if errors

      MenuAccount.new(@context)
    end

    private

    def errors
      return false if errors?

      @errors.each { |error| puts error }
      @next_state = CREATE_ACCOUNT_STATE
      true
    end

    def errors?
      @errors.empty?
    end

    def name_input
      puts 'Enter your name'
      read_input
    end

    def login_input
      puts 'Enter your login'
      read_input
    end

    def password_input
      puts 'Enter your password'
      read_input
    end

    def age_input
      puts 'Enter your age'
      read_input
    end

    def validated_value(validator, *args)
      validator = validator.new(args)
      @errors << validator.errors unless validator.valid?
      validator.value
    end
  end
end
