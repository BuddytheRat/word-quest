$LOAD_PATH.unshift(File.dirname(__FILE__))

class WordQuest
  require 'YAML'
  require 'wordquest/player'
  require 'wordquest/scene'
  require 'wordquest/battle'

  def initialize
    # Start or load game here
    @player = Player.new

    Battle.new(@player, 'Open Field', 'Outside of Town', Monster.new('Slime', @player.level)).queue
    Battle.new(@player, 'Deck of the Pinnacle', 'The Eastern Sea', Monster.new('Skeleton Pirate', @player.level+1)).queue
    Battle.new(@player, 'Fiery Magma Pit', 'The Belly of Mt. Ogris', Monster.new('Dragon', @player.level+2)).queue
    Scene.new(@player, 'Victory', 'You have fulfilled the prophecy!',
               "With your enemies slain, your village is now safe.\n\n\ Congratulations!").queue
    Scene.new(@player, 'Game Over', 'You Died',
               "You have fallen in battle..\n\nAll is lost..",
               :gameover)

    Scene.load
    game_loop
  end

  def game_loop
    loop do
      system('cls')
      #Scene.save
      Scene.current.step
    end
  end
end

@quest = WordQuest.new