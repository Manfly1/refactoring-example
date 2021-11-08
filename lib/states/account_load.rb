module States
  class AccountLoad < State
    def action
      if @situation.accounts.empty?
        puts I18n.t(:no_active_account_message)
        return @answer = read_input
      end

      login = read_login
      password = read_password
      @context.current_account = get_account(login, password)
      puts I18n.t(:no_account_message) unless @situation.current_account
    end

    def next
      return CreateAccount.new(@situation) if @answer == APPLY_COMMAND
      MenuAccount.new(@situation)
    end

    private

    def read_login
      puts I18n.t(:login_message)
      read_input
    end

    def read_password
      puts I18n.t(:password_message)
      read_input
    end

    def get_account(login, password)
      @situation.accounts.detect { |account| account.login == login && account.password == password }
    end
  end
end