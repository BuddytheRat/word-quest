class Battle < Scene
  require_relative 'battle/monster'
  def initialize(player, title, subtitle)
    super(title, subtitle, nil)
    @player = player
    @monster = Monster.new('Slime', @player.level)
    @guesses = Array.new
  end

  def input_valid?(input)
    input.length == 1 && input =~ /[a-z]/i
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

  def invalid_input_str
    alert("Sorry, that input isn't valid! Try again?")  
  end

  def player_loss_str
    alert("#{@player.name} has perished!")
    alert("Game Over")
  end

  #Logic
  def step
    #Battle Start
    title_string
    alert(@monster.word.join(''))#DEBUG
    if @frame == 0
      battle_begin_str
    #Invalid Input
    elsif @frame > 1 && !input_valid?(@player.last_input)
      invalid_input_str
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
      @jump_to = @@scenes[:gameover]
    elsif @monster.is_dead?
      @player.gain_xp(@monster.xp)
      @player.gain_gold(@monster.gold)
      battle_end_str
      @scene_over = true
    end
    super
  end
end