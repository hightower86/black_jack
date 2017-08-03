class Bank
  attr_reader :player_account, :dealer_account, :game_account
  attr_writer :player_account, :dealer_account, :game_account

  def initialize(options)
     @player_account = options[:player_account]
     @dealer_account = options[:dealer_account]
     @game_account = options[:game_account]
  end
end