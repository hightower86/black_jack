
require_relative "player"
require_relative "bank"
require_relative "deck"

class Game

  def initialize
    @dealer = Player.new({ :name => "Dealer",  :cards => [] })
    @bank = Bank.new({ :player_account => 100, :dealer_account => 100, :game_account => 0 })
    init
  end

  def init
    puts "Сыграем в Black Jack?.. Как тебя зовут?"
    user_name = gets.chomp
    puts "Привет, #{user_name}, Погнали!"
    @player = Player.new({ :name => user_name, :cards => [] })
  end

  def start
    @deck = Deck.new
    @player.cards = []
    @dealer.cards = []
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
    give_cards(@dealer,2)
    info
    next_step
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
    if (dealer_points <= 21 && dealer_points > player_points) || player_points > 21 
      puts "К сожалению, Вы проиграли :((("
      @bank.dealer_account += @bank.game_account
      @bank.game_account -= @bank.game_account
    elsif  player_points <= 21 && dealer_points < player_points || dealer_points > 21
      puts "Поздравляем! ВЫ победили!!!"
      @bank.player_account += @bank.game_account
      @bank.game_account -= @bank.game_account
    elsif player_points == dealer_points || (player_points > 21 && dealer_points > 21)
      puts "На этот раз победила ДРУЖБА!!!"
    end
    puts "Хотите сыграть еще раз? Y/N"
    if gets.chomp == "Y"
      start
    else
      abort "До встречи!"
    end
  end

  def info
    str = ""
    @dealer.cards.each {str += "*"} 
    puts "Карты дилера: #{str}"
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
    sleep 1
    dealer_points = count_points(@dealer.cards)
    if dealer_points < 16 && @dealer.cards.size < 3
      give_cards(@dealer,1)
      puts "Дилер взял карту..."
      info
      sleep 1
      next_step if check
    else 
      puts "Дилер пропустил ход..."
      sleep 1
      next_step
    end
    info
  end

  def check
    if @dealer.cards.size >= 3 && @player.cards.size >= 3
      false
      open_cards
    else
      true  
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
      puts "Вы взяли карту..."
      sleep 1
      info
      check
      dealer_move
    when 3
      open_cards
    end
  end
end

game = Game.new
game.start
# game.next_step