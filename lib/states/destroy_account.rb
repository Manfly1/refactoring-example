module States
  class DestroyAccount < BaseState
    def action
      puts I18n.t(:destroy_account_message)
      @answer = read_input
      return unless @answer == APPLY_COMMAND

      @situation.accounts.delete_if { |account| account.login == @situation.account.login }
      @situation.save
    end

    def next
      return BaseState.new(@situation) if @answer == APPLY_COMMAND
      MenuAccount.new(@situation)
    end
  end
end