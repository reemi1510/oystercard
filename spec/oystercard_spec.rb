require "oystercard"

describe Oystercard do
  describe 'oystercard' do
    it "has a balance" do
      expect(subject.balance).to eq(0)
    end
  end
  describe '#top_up' do
    it {is_expected.to respond_to(:top_up).with(1).argument}
  end

  it "can top up balance" do
    expect { subject.top_up 1}.to change{ subject.balance}.by 1
  end

  it "raises an error if balance exceeds £90" do
    maximum_balance = Oystercard::MAX_BALANCE
    subject.top_up(maximum_balance)
    expect{ subject.top_up 1 }.to raise_error("cannot exceed £#{maximum_balance}")
  end

  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }
  end

  it "deducts fare from balance" do
    subject.top_up(20)
    expect { subject.deduct 3}.to change{ subject.balance}.by -3
  end

  context "journey" do
    before(:each) do
      subject.top_up(Oystercard::MAX_BALANCE)
    end

    it "is initially not in journey" do
      expect(subject).not_to be_in_journey
    end

    it "can touch in" do
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it "can touch out" do
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end

end
