module States
  class AccountLoad < Base
    def action
      if @context.state.accounts.empty?
        puts I18n.t(:no_active_account_message)
        return @answer = read_input
      end

      login = read_login
      password = read_password
      @context.state.extant_account = get_account(login, password)
      puts I18n.t(:no_account_message) unless @context.state.extant_account
    end

    def next
      return States::CreateAccount.new(@context) if @answer == APPLY_COMMAND
      return States::Welcome.new(@context) if @context.state.accounts.empty? && @answer != APPLY_COMMAND

      MenuAccount.new(@context)
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
      @context.state.accounts.detect { |account| account.login == login && account.password == password }
    end
  end
end
