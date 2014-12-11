class Player

  def initialize
    @steps = []
    @hps = []
    @max_lost_in_battle = 0
  end

  def play_turn(warrior)
    decision = make_decision(warrior)
    warrior.send(decision)
  end

  private


  def make_decision(warrior)
    action = nil
    rest = should_rest?(warrior)
    @hps << warrior.health
    if warrior.feel.empty?
      action = rest ? 'rest!' : 'walk!'
    else
      action = 'attack!'
    end
    @steps << action
    return action
  end

  def should_rest?(warrior)
    index = -1
    lost_in_latest_battle = 0
    if @hps.length > 1 && @hps[-1] < @hps[-2]
      index = -2
      while index > -(@hps.length) && @hps[index] < @hps[index - 1] do
        index = index - 1
      end
      lost_in_latest_battle = @hps[index] - @hps[-1]
    else
      lost_in_latest_battle = 0
    end

    @max_lost_in_battle = lost_in_latest_battle > @max_lost_in_battle ? lost_in_latest_battle : @max_lost_in_battle
    return warrior.health <= @max_lost_in_battle
  end


end
