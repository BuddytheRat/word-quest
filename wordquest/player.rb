class Player
  attr_reader :name, :level, :hp, :last_input
  def initialize
    # do some stuff
    @level = 1
    @name = "Def"
    @hp = 100
    @last_input = String.new
  end

  def set_name
    input
    @name = @last_input
  end

  def damage(damage)
    @hp -= damage
  end

  def input
    @last_input = gets.chomp
  end
end