$LOAD_PATH.unshift(File.dirname(__FILE__))

class WordQuest
  require 'wordquest/player'
  require 'wordquest/battle'

  def initialize
    # Start or load game here
    @player = Player.new
    puts "What is your name?"
    @player.set_name

    @display_queue = Array.new
    @scenes = [Battle.new(@player), Battle.new(@player), Battle.new(@player)]
    @in_battle = false

    game_loop
  end

  def refresh_screen
    system('cls')
    @display_queue.each { |string| puts string }
    @display_queue.clear
  end

  def alert(alert)
    @display_queue << alert
  end

  def in_battle?
    @in_battle
  end

  def current_scene
    @scenes[0]
  end

  def next_scene
    @scenes.shift
  end

  def game_loop
    loop do
      current_scene.step
      alert(current_scene.display)
      refresh_screen
      @player.input
      next_scene if current_scene.is_over?
    end
  end
end

@quest = WordQuest.new