class Oystercard
  MAX_BALANCE = 90

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "cannot exceed £90" if amount + @balance > MAX_BALANCE
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end
end
