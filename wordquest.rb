$LOAD_PATH.unshift(File.dirname(__FILE__))

class WordQuest
  require 'YAML'
  require 'wordquest/player'
  require 'wordquest/scene'
  require 'wordquest/mainmenu'
  require 'wordquest/battle'

  def initialize
    # Start or load game here
    @player = Player.new
    MainMenu.new(@player).queue

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