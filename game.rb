
require_relative "player"
# require_relative "dealer"
require_relative "bank"
require_relative "deck"


puts "Сыграем в Black Jack?.. Как тебя зовут?"
user_name = gets.chomp
puts "Привет, #{user_name}, Погнали!"

deck = Deck.new
player = Player.new({ :name => user_name, :cards => [] })
dealer = Player.new({ :name => "Dealer",  :cards => [] })
bank = Bank.new({ :player_account => 100, :dealer_account => 100, :game_account => 0 })

bank.player_account -= 10
bank.dealer_account -= 10
bank.game_account += 20
puts "Ставки сделаны: остаток на Вашем счете #{player_account}, У Дилера #{dealer_account},
      в банке игры: #{game_account}"
      