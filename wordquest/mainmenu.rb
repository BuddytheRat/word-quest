class MainMenu < Scene
  def initialize(player)
    super(player, "WordQuest", "The Path to Mt. Ogris",
          "", :mainmenu)
    @game_file = File.exist?('save.yml')
  end

  def step
    @frame += 1
    options = ['1']
    puts title_string
    puts "1. Start New Adventure\n\n"
    if @game_file
      options += ['2']
      puts "2. Continue Your Quest\n\n"
    end
    puts "Please enter a number:"
    choice = @player.prompt(options)
    case choice
    when '1'
      Battle.new(@player, 'Open Field', 'Outside of Town', Monster.new('Slime', @player.level)).queue
      Battle.new(@player, 'Deck of the Pinnacle', 'The Eastern Sea', Monster.new('Skeleton Pirate', @player.level+1)).queue
      Battle.new(@player, 'Fiery Magma Pit', 'The Belly of Mt. Ogris', Monster.new('Dragon', @player.level+2)).queue
      Scene.new(@player, 'Victory', 'You have fulfilled the prophecy!',
                "With your enemies slain, your village is now safe.\n\n\ Congratulations!").queue
      Scene.new(@player, 'Game Over', 'You Died',
                "You have fallen in battle..\n\nAll is lost..",
                :gameover)
      Scene.next_scene
    when '2'
      Scene.load
    end

  end
end