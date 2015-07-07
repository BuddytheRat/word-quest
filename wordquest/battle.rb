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

  def step
    #Battle Start
    title_string
    alert(@monster.word.join(''))
    if @frame == 0
      alert("You encounter a wild #{@monster.name}!")
      alert("Press enter to continue!")
    elsif @frame > 1 && !input_valid?(@player.last_input)
      alert("Sorry, that input isn't valid! Try again?")  
    elsif @frame >= 1 && !@monster.is_dead?
    #Battle Round
      #verify_input
      matches = @monster.check_letter(@player.last_input) if @frame > 1
      @guesses << @player.last_input if @frame > 1
      alert("#{@player.name}: Level #{@player.level}, #{@player.hp} HP")
      alert("#{@monster.name}: Level #{@monster.level}, #{@monster.hp} HP")
      alert("#{@monster.blanks}")
      case matches
      when 0
        alert("#{@player.name} missed!")
      when 1
        alert("#{@player.name} hits the monster!")
      when 2
        alert("#{@player.name} scores a critical hit!")
      end
      if !@monster.is_dead? && @frame > 1
        damage = @monster.attack
        @player.damage(damage)
        alert("#{@monster.name} hit #{@player.name} for #{damage} HP!", 2)
      end
      alert("Guesses: #{@guesses.join(' ').to_s.upcase}")
    end
    #Battle End
    if @monster.is_dead?
      @player.gain_xp(@monster.xp)
      @player.gain_gold(@monster.gold)
      alert("#{@monster.name} falls!")
      alert("Gained #{@monster.xp} XP!")
      alert("Gained #{@monster.gold} gold!")
      alert("Press enter to continue...")
      @scene_over = true
    end
    super
  end
end