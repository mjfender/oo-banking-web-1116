require 'pry'

class Transfer
  # your code here
  attr_reader
  attr_writer
  attr_accessor :status, :sender, :receiver, :amount

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
    @completed_transactions = []
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if valid? && @status != "complete" && sender.balance - amount >= 0
      sender.balance -= amount
      receiver.deposit(amount)
      @status = "complete"
    else 
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    pre_reversal_sender = sender.balance
    pre_reversal_recipient = receiver.balance
    if @status == "complete"
      @status = "reversed"
      sender.deposit(amount)
      receiver.balance -= @amount
      "Transaction was reversed."
    end
  end

end
