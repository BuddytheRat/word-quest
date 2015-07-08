$LOAD_PATH.unshift(File.dirname(__FILE__))

class WordQuest
  require 'wordquest/player'
  require 'wordquest/scene'
  require 'wordquest/scenes'
  require 'wordquest/battle'

  def initialize
    # Start or load game here
    @player = Player.new
    puts "What is your name?"
    @player.set_name

    @display_queue = Array.new

    GameOver.new
    @scenes = [Battle.new(@player, 'Open Field', 'Outside of Town'),
               Battle.new(@player, 'Fiery Magma Pit', 'The Belly of Mt. Ogris'),
               Battle.new(@player, 'Deck of the Pinnacle', 'The Eastern Sea'),
               Victory.new]
    game_loop
  end

  def refresh_screen
    system('cls')
    current_scene.display
  end

  def current_scene
    @scenes[0]
  end

  def queue_scene(scene)
    @scenes << scene
  end

  def jump_to_scene(scene)
    @scenes.clear
    @scenes << scene
  end

  def insert_scene(scene)
    @scenes.insert(1, scene)
  end

  def next_scene
    @scenes.shift
  end

  def game_loop
    loop do
      current_scene.step
      refresh_screen
      @player.input
      jump_to_scene(current_scene.jump_to) if current_scene.jumping?
      next_scene if current_scene.is_over?
    end
  end
end

@quest = WordQuest.new