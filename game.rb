
require_relative "player"
require_relative "methods"
require_relative "bank"
require_relative "deck"

include Methods


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
puts "Ставки сделаны: остаток на Вашем счете #{bank.player_account}, 
у Дилера #{bank.dealer_account},
в банке игры: #{bank.game_account}"
sleep 1
puts "Раздача карт ... "
sleep 1
deck.mix
player_cards = [] << deck.cards.slice!(0) << deck.cards.slice!(0)
player_points = count_points(player_cards)
puts "Ваши карты: #{player_cards} сумма очков по ним: #{ player_points}" 
# p player_points
# puts deck.cards.length
dealer_cards = [] << deck.cards.slice!(0) << deck.cards.slice!(0)
puts "Карты дилера: #{dealer_cards}. Сумма очков: ***"
# puts deck.cards.length
# count_cards("сообщение")
puts "Ваш ход... Выберите вариант:
1. Пропустить ход
2. Добавить карту
3. Открыть карты"
choise = gets.chomp.to_i
case choise
when 1
  # пропускаем ход
when 2
  player_cards << deck.cards.slice!(0)
  player_points = count_points(player_cards)
  puts "Ваши карты: #{player_cards} сумма очков по ним: #{ player_points}" 
when 3
  remove_station
when 0
  Exit 
end