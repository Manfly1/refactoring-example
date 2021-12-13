module States
  class CreateAccount < Base
    CREATE_ACCOUNT_STATE = 'create'.freeze

    def action
      @errors = []
      @context.extant_account = Entities::Account.new(name: name_input, login: login_input, age: age_input,
                                                      password: password_input)
      return if errors

      @context.accounts << @context.extant_account
      @context.save
    end

    def next
      return CreateAccount.new(@context) if @next_state == CREATE_ACCOUNT_STATE

      MenuAccount.new(@context)
    end

    private

    def errors
      return false if @errors.empty?

      @errors.each { |error| puts error }
      @next_state = CREATE_ACCOUNT_STATE
      true
    end

    def name_input
      puts I18n.t(:name_message)
      read_input
    end

    def login_input
      puts I18n.t(:login_message)
      read_input
    end

    def password_input
      puts I18n.t(:password_message)
      read_input
    end

    def age_input
      puts I18n.t(:age_message)
      read_input
    end
  end
end
