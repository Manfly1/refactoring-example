module States
  class DestroyAccount < BaseState
    def action
      puts I18n.t(:destroy_account_message)
      @answer = read_input
      return unless @answer == APPLY_COMMAND

      @context.accounts.delete_if { |account| account.login == @context.extant_account.login }
      @context.save
    end

    def step
      return BaseState.new(@context) if @answer == APPLY_COMMAND

      MenuAccount.new(@context)
    end
  end
end
