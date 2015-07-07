$LOAD_PATH.unshift(File.dirname(__FILE__))

class WordQuest
  require 'wordquest/player'
  require 'wordquest/scene'
  require 'wordquest/battle'

  def initialize
    # Start or load game here
    @player = Player.new
    puts "What is your name?"
    @player.set_name

    @display_queue = Array.new
    @scenes = [Battle.new(@player), Battle.new(@player), Battle.new(@player)]
    game_loop
  end

  def refresh_screen
    system('cls')
    current_scene.display
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
      refresh_screen
      @player.input
      next_scene if current_scene.is_over?
    end
  end
end

@quest = WordQuest.new