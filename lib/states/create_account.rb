module States
  class CreateAccount < BaseState
    CREATE_ACCOUNT_STATE = 'create'.freeze

    def step
      return CreateAccount.new(@situation) if @next_state == CREATE_ACCOUNT_STATE

      MenuAccount.new(@situation)
    end

    def action
      @errors = []
      @situation.extant_account = Entities::Account.new(name: name_input, age: age_input, login: login_input,
                                                        password: password_input)
      return if errors?

      @situation.accounts << @situation.extant_account
      @situation.save
    end

    private

    def errors?
      return false if @errors.empty?

      @errors.each { |error| puts error }
      @next_state = CREATE_ACCOUNT_STATE
      true
    end

    def name_input
      puts I18n.t(:name_message)
    end

    def login_input
      puts I18n.t(:login_message)
    end

    def password_input
      puts I18n.t(:password_message)
    end

    def age_input
      puts I18n.t(:age_message)
    end
  end
end
