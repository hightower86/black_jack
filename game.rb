
require_relative "player"
require_relative "methods"
require_relative "bank"
require_relative "deck"

class Game
  include Methods

  def initialize
    @deck = Deck.new
    # @player = Player.new({ :name => user_name, :cards => [] })
    @dealer = Player.new({ :name => "Dealer",  :cards => [] })
    @bank = Bank.new({ :player_account => 100, :dealer_account => 100, :game_account => 0 })
  end

  def start
    puts "Сыграем в Black Jack?.. Как тебя зовут?"
    user_name = gets.chomp
    puts "Привет, #{user_name}, Погнали!"
    @player = Player.new({ :name => user_name, :cards => [] })
    @bank.player_account -= 10
    @bank.dealer_account -= 10
    @bank.game_account += 20
    puts "Ставки сделаны: остаток на Вашем счете #{@bank.player_account}, 
    у Дилера #{@bank.dealer_account},
    в банке игры: #{@bank.game_account}"
    sleep 1
    puts "Раздача карт ... "
    sleep 1
    @deck.mix
    give_cards(@player,2)
    # player_cards = [] << deck.cards.slice!(0) << deck.cards.slice!(0)
    # player_points = count_points(@player.cards)
    # puts "Ваши карты: #{@player.cards} сумма очков по ним: #{player_points}" 

    give_cards(@dealer,2)
    # dealer_points = count_points(@dealer.cards)
    # puts "Карты дилера: #{@dealer.cards}. Сумма очков: #{dealer_points}"\
    info
  end

  def count_points(cards)
    points = 0
    cards.each do |card|
      if card[0] =~/[1KQJ]/
        points += 10
      elsif card[0] =~/[2-9]/
        points += card[0].to_i
      elsif card[0] =~/[A]/  
        if points <= 10
          points += 11
        else
          points += 1
        end
      end
    end
    points
  end

  def open_cards
    puts "Вскрываем карты!"
    dealer_points = count_points(@dealer.cards)
    player_points = count_points(@player.cards)
    puts "Карты дилера: #{@dealer.cards}. Сумма очков: #{dealer_points}"
    puts "Ваши карты: #{@player.cards}. Cумма очков: #{player_points}" 
    if dealer_points > player_points
      puts "К сожалению, Вы проиграли :((("
    elsif dealer_points < player_points
      puts "Поздравляем! ВЫ победили!!!"
    else
      puts "На этот раз победила ДРУЖБА!!!"
    end
  end

  def info
    puts "Карты дилера: #{@dealer.cards.each {|c| print "* "}}." 
          # "Сумма очков: #{count_points(@dealer.cards)}"
    puts "Ваши карты: #{@player.cards} сумма очков: #{count_points(@player.cards)}" 
  end

  def give_cards(player, count)
    while count > 0
      count -= 1
      player.cards << @deck.cards.slice!(0)
    end
  end

  def dealer_move
    puts "Ход дилера..."
    sleep 2
    dealer_points = count_points(@dealer.cards)
    if dealer_points < 18 && @dealer.cards.size < 3
      give_cards(@dealer,1)
    end
    check
    next_step
    info
  end
  def check
    if @dealer.cards.size == 3 && @player.cards.size == 3
      open_cards
    end
  end

  def next_step
    puts "Ваш ход... Выберите вариант:
    1. Пропустить ход
    2. Добавить карту
    3. Открыть карты"
    choise = gets.chomp.to_i
    case choise
    when 1
      dealer_move
    when 2
      if @player.cards.size < 3
        give_cards(@player,1)
      end
      check
      dealer_move
      info
    when 3
      open_cards
    end
  end
end

game = Game.new
game.start
game.next_step