class Scene
  @@scenes = Hash.new
  @@id = 1

  attr_reader :jump_to
	def initialize(title, subtitle, description, symbol = nil)
    @title = title
    @subtitle = subtitle
    @description = description
		@display_queue = Array.new
		@scene_over = false
    @jump_to = nil
    @frame = 0

    symbol ||= "#{@@id}_#{title.gsub(' ', '_').downcase}".to_sym
    @@scenes[symbol] = self
    @@id += 1
	end

	def is_over?
		@scene_over
	end

  def jumping?
    @jump_to
  end

	def step
    @frame += 1
	end

  def end_scene
  end

  def alert(alert, newlines = 0)
    #puts @display_queue.class
    @display_queue << alert + "\n" * newlines
  end

  def title_string
    alert("#{@title} - #{@subtitle}", 2)
  end

  def description
    alert("#{@description}")
  end

	def display
		@display_queue.each { |str| puts str }
    @display_queue.clear
	end
end