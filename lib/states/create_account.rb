module States
  class CreateAccount < BaseState

    def action
      @errors = []
      @situation.current_account = Entities::Account.new(name: name_input,
                                                       age: age_input,
                                                       login: login_input,
                                                       password: password_input)
      return if errors?

      @situation.accounts << @situation.current_account
      @situation.save
    end

    def next
      return CreateAccount.new(@situation) if @next_state == 'create'

      MenuAccount.new(@situation)
    end

    private

    def errors?
      return false if @errors.empty?

      @errors.each { |error| puts error }
      @next_state = 'create'
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