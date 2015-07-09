class Battle < Scene
  require_relative 'battle/monster'
  def initialize(player, title, subtitle, monster, symbol = nil)
    super(player, title, subtitle, symbol)
    @monster = monster
    @guesses = Array.new
  end

  def battle_intro
    puts "You encounter a wild #{@monster.name}!"
    puts "Press enter to continue..."
    @player.confirm
  end

  def battle_round
    matches = @monster.check_letter(@player.last_input)
    puts "#{@monster.name}: #{@monster.hp} HP, Level #{@monster.level}"
    puts "#{@player.name}: #{@player.hp} HP, Level #{@player.level}"
    puts
    puts "#{@monster.blanks}"
    puts
    round_results(matches) if @frame > 2
    puts "GUESSES: #{@guesses.join(' ')}"
    if @monster.is_dead? && @player.is_alive?
      battle_end
    else
      @guesses << @player.input_command
    end
  end

  def round_results(matches)
    if matches == 0
      damage = @monster.attack
      @player.damage(damage)
      puts "#{@monster.name} hits #{@player.name} for #{damage} damage!"
    end
    puts "#{@player.name} hits #{@monster.name} for #{matches} damage!" if matches == 1
    puts "Critical hit on #{@monster.name}! #{matches} damage!" if matches > 1
    puts
  end

  def battle_end
    @player.reset_input
    @player.gain_gold(@monster.gold)
    @player.gain_xp(@monster.xp)
    puts "#{@monster.name} falls!"
    puts "#{@player.name} gains:"
    puts "    #{@monster.gold} gold!"
    puts "    #{@monster.xp} xp!"
    puts "Press enter to continue..."
    @player.confirm
    Scene.next_scene
  end

  def step
    @frame += 1
    puts title_string
    battle_intro if @frame == 1
    battle_round if @frame > 1 && @monster.is_alive? && @player.is_alive?
    Scene.jump_to(:gameover) if @player.is_dead?
  end
end