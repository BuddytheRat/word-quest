class GameOver < Scene
  def initialize
    super('Game Over',
          'You Died',
          "Your have fallen in battle.. All is lost..",
          :gameover)
  end

  def step
    title_string
    description
  end
end

class Victory < Scene
  def initialize
    super('Victory',
          'You have fulfilled the prophecy!',
          "With the three slimes slain, your village is now safe.\n\nCongratulations!")
  end

  def step
    title_string
    description
  end
end