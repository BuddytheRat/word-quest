class Battle < Scene
  require_relative 'battle/monster'
  def initialize(player, title, subtitle)
    super(title, subtitle, nil)
    @player = player
    @monster = Monster.new('Slime', @player.level)
    @guesses = Array.new
  end

  def battle_info_str
    alert("#{@player.name}: Level #{@player.level}, #{@player.hp} HP")
    alert("#{@monster.name}: Level #{@monster.level}, #{@monster.hp} HP")
    alert("#{@monster.blanks}")
  end

  #Display Strings
  def player_attack_str(matches)
    case matches
      when 0
        alert("#{@player.name} missed!")
      when 1
        alert("#{@player.name} hits the monster!")
      else
        alert("#{@player.name} scores a critical hit!")
    end 
  end

  def damage_str(damage)
    alert("#{@monster.name} hit #{@player.name} for #{damage} HP!", 2)
  end

  def guesses_str
    alert("Guesses: #{@guesses.join(' ').to_s.upcase}")
  end

  def battle_end_str
    alert("#{@monster.name} falls!")
    alert("Gained #{@monster.xp} XP!")
    alert("Gained #{@monster.gold} gold!")
    alert("Press enter to continue...")
  end

  def battle_begin_str
    alert("You encounter a wild #{@monster.name}!")
    alert("Press enter to continue!")
  end

  #Logic
  def step
    super
    #Battle Start
    title_string
    alert(@monster.word.join(''))
    if @frame == 0
      battle_begin_str
      @player.confirm

    #Battle Round
    elsif @frame >= 1 && !@monster.is_dead?
      matches = @monster.check_letter(@player.last_input) if @frame > 1
      @guesses << @player.last_input if @frame > 1 && !@guesses.include?(@player.last_input)
      battle_info_str
      player_attack_str(matches)
      if !@monster.is_dead? && @frame > 1
        damage = @monster.attack
        @player.damage(damage)
        damage_str(damage)
      end
      guesses_str
    end

    #Battle End
    if @player.is_dead?
      Scene.jump_to(:gameover)
    elsif @monster.is_dead?
      @player.gain_xp(@monster.xp)
      @player.gain_gold(@monster.gold)
      battle_end_str
      Scene.next_scene
      @player.confirm
    end
    @player.input_command
  end
end