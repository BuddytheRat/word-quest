$LOAD_PATH.unshift(File.dirname(__FILE__))

class WordQuest
  require 'wordquest/player'
  require 'wordquest/scene'
  require 'wordquest/scenes'
  require 'wordquest/battle'

  def initialize
    # Start or load game here
    @player = Player.new
    #puts "What is your name?"
    #@player.set_name

    @display_queue = Array.new

    Battle.new(@player, 'Open Field', 'Outside of Town').queue
    Battle.new(@player, 'Deck of the Pinnacle', 'The Eastern Sea').queue
    Battle.new(@player, 'Fiery Magma Pit', 'The Belly of Mt. Ogris').queue
    Victory.new.queue

    GameOver.new

    puts Scene.all.to_s

    game_loop
  end

  def refresh_screen
    system('cls')
    Scene.current.display
  end

  def game_loop
    loop do
      Scene.current.step
      refresh_screen
    end
  end
end

@quest = WordQuest.new