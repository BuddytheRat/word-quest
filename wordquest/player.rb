class Player
  attr_reader :name, :level, :hp, :last_input
  def initialize
    # do some stuff
    @level = 1
    @name = "Dee"
    @hp = 10
    @xp = 0
    @gold = 10
    @items = Array.new
    @last_input = String.new
  end
 
  def set_name
    input
    @name = @last_input
  end

  def gain_xp(xp)
    @xp += xp
  end

  def gain_gold(gold)
    @gold += gold
  end

  def damage(damage)
    @hp -= damage
  end

  def is_dead?
    @hp <= 0 ? true : false
  end

  def input
    @last_input = gets.chomp
  end
end