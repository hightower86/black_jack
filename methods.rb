module Methods
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
end