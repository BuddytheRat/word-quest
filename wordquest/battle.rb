class Battle
  require_relative 'battle/monster'
  def initialize(player)
    @player = player
    @monster = Monster.new('Slime', @player.level)
    @battle_string = Array.new
    @round = 1
    @battle_over = false
  end

  def step
    alert("#{@monster.word.join}")
    #Battle Round
    if @round > 1 && !@monster.is_dead?
      matches = @monster.check_letter(@player.last_input)
      case matches
      when 0
        alert("#{@player.name} missed!")
      when 1
        alert("#{@player.name} hits the monster!")
      when 2
        alert("#{@player.name} scores a critical hit!")
      end
      if !@monster.is_dead?
        damage = @monster.attack
        @player.damage(damage)
        alert("#{@monster.name} hit #{@player.name} for #{damage} HP!")
      end
    #Battle Start
    elsif @round == 1
      alert("You encounter a wild #{@monster.name}!")
    end
    #Battle End
    if @monster.is_dead?
      alert("#{@monster.name} falls!")
      # player gains XP and gold
      alert("Press enter to continue!")
      @battle_over = true
    end
    @round += 1
  end

  def is_over?
    @battle_over
  end

  # return string for displaying battle info
  def display
    string = "#{@monster.name}: Level #{@monster.level} - #{@monster.hp} HP\n\n",
             "#{@monster.blanks}\n\n",
             "#{battle_string}"
  end

  private
  def alert(alert)
    @battle_string << alert
  end

  def battle_string
    string = String.new
    @battle_string.length.times do |i|
      string << @battle_string.shift + "\n"
    end
    string
  end

end