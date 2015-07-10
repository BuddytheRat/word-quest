class Dialogue < Scene
  def initialize(player, title, subtitle, description, symbol = nil)
    super(player, title, subtitle, description, symbol = nil)
    
  end

  def step
    @frame += 1
    puts title_string
    
  end
end