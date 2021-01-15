require 'pry'
class Transfer
   attr_accessor :status, :amount, :sender, :receiver
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = 'pending'
    @amount = amount
  end

  def valid?
    self.sender.valid? && self.receiver.valid?
  end

  def execute_transaction
    if self.sender.balance > @amount && @status == 'pending' && self.valid?
      self.sender.balance -= @amount
      self.receiver.balance += @amount
      @status = 'complete'
    else
      @status = 'rejected'
      return "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @status == 'complete'
      self.sender.balance += @amount
      self.receiver.balance -= @amount
      @status = 'reversed'
    end
  end
end
