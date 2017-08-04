class Deck
  # @@cards = []
  # def self.init_deck
  #   # @@cards = []
  #   suits = ["+", "<3", "<>", "^"] 
  #   values = (2..10).to_a << "K" << "Q" << "J" << "A"
  #   suits.each do |suit|
  #     values.each { |value| @@cards << value.to_s + suit }
  #   end
  # end

  def initialize
    @cards = []
    suits = ["+", "<3", "<>", "^"] 
    values = (2..10).to_a << "K" << "Q" << "J" << "A"
    suits.each do |suit|
      values.each { |value| @cards << value.to_s + suit }
    end
  end

  def mix
    @cards.shuffle!
  end

end

deck = Deck.new
