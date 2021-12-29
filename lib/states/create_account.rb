module States
  class CreateAccount < Base
    CREATE_ACCOUNT_STATE = 'create'.freeze

    def action
      @errors = []
      @context.extant_account = Entities::Account.new(name: name_input, login: login_input, age: age_input,
                                                      password: password_input)
      unless @errors.empty?
        print_errors
        return
      end

      @context.accounts << @context.extant_account
      @context.save
    end

    def next
      return MenuAccount.new(@context) if @errors.empty?

      CreateAccount.new(@context)
    end

    private

    def print_errors
      @errors.each { |error| puts error }
    end

    def name_input
      puts 'Enter your name'
      validation = Validation::Name.new(read_input)
      validated_value(validation, read_input)
    end

    def login_input
      puts 'Enter your login'
      validated_value(Validation::Login, read_input, @context.accounts)
    end

    def password_input
      puts 'Enter your password'
      validated_value(Validation::Password, read_input)
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
