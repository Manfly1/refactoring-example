module States
  class CreateAccount < Base
    CREATE_ACCOUNT_STATE = 'create'.freeze

    def action
      @errors = []
      name_input = read_input_with_title('Enter your name')
      login_input = read_input_with_title('Enter your login')
      age_input = read_input_with_title('Enter your age')
      password_input = read_input_with_title('Enter your password')

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
      validation = Validation::Name.new(name_input)
      validated_value(validation, name_input)
    end

    def login_input
      validated_value(Validation::Login, login_input, @context.accounts)
    end

    def password_input
      validated_value(Validation::Password, password_input)
    end

    def age_input
      validated_value(Validation::Age, age_input)
    end

    def validated_value(validator, *args)
      validator = validator.new(args)
      @errors << validator.errors unless validator.valid?
      validator.value
    end
  end
end
