class Battle < Scene
  require_relative 'battle/monster'
  def initialize(player)
    super()
    @player = player
    @monster = Monster.new('Slime', @player.level)
    @round = 0
  end

  def step
    alert("#{@monster.word.join}")
    #Battle Round
    if @round >= 1 && !@monster.is_dead?
      matches = @monster.check_letter(@player.last_input) if @round > 1
      alert("#{@player.name}: Level #{@player.level}, #{@player.hp} HP\n")
      alert("#{@monster.name}: Level #{@monster.level}, #{@monster.hp} HP\n")
      alert("#{@monster.blanks}\n")
      case matches
      when 0
        alert("#{@player.name} missed!")
      when 1
        alert("#{@player.name} hits the monster!")
      when 2
        alert("#{@player.name} scores a critical hit!")
      end
      if !@monster.is_dead? && @round > 1
        damage = @monster.attack
        @player.damage(damage)
        alert("#{@monster.name} hit #{@player.name} for #{damage} HP!")
      end
    #Battle Start
    elsif @round == 0
      alert("You encounter a wild #{@monster.name}!")
      alert("Press enter to continue!")
    end
    #Battle End
    if @monster.is_dead?
      alert("#{@monster.name} falls!")
      # player gains XP and gold
      alert("Press enter to continue!")
      @scene_over = true
    end
    @round += 1
  end
end