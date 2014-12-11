class Player

  def initialize
    @steps = []
    @hps = []
    @max_lost_in_battle = 0
  end

  def play_turn(warrior)
    decision = make_decision(warrior)
    warrior.send(decision)
    #puts decision
    #puts "@hps, #{@hps}"
    #puts @max_lost_in_battle
  end

  private


  def make_decision(warrior)
    action = nil
    safety_examine(warrior)
    rest = should_rest?(warrior)
    if warrior_safe?(warrior)
      action = rest ? 'rest!' : 'walk!'
    elsif warrior.feel.empty?
      # not safe but losting hp
      action = 'walk!'
    else
      action = 'attack!'
    end
    @hps << warrior.health
    @steps << action
    return action
  end

  def warrior_safe?(warrior)
    return warrior.feel.empty? && (@hps.last.nil? || warrior.health >= @hps.last)
  end

  def safety_examine(warrior)
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

  end

  def should_rest?(warrior)
    return warrior.health <= @max_lost_in_battle
  end
end
