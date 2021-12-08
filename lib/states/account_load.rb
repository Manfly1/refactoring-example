module States
  class AccountLoad < Base
    def next
      return CreateAccount.new(@context) if @answer == APPLY_COMMAND

      MenuAccount.new(@context)
    end

    def action
      if @context.accounts.empty?
        puts I18n.t(:no_active_account_message)
        return @answer = read_input
      end

      login = read_login
      password = read_password
      @context.extant_account = get_account(login, password)
      puts I18n.t(:no_account_message) unless @context.extant_account
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
      @context.accounts.detect { |account| account.login == login && account.password == password }
    end
  end
end
