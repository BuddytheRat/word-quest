class Scene
  @@scenes = Hash.new
  @@scene_queue = Array.new
  @@id = 1

  attr_reader :jump_to
	def initialize(title, subtitle, description, symbol = nil)
    @title = title
    @subtitle = subtitle
    @description = description
		@display_queue = Array.new
		@scene_over = false
    @frame = 0

    symbol ||= "#{@@id}_#{title.gsub(' ', '_').downcase}".to_sym
    @@scenes[symbol] = self
    @@id += 1
	end

  def Scene.current_scene
    @@scenes[@@scene_queue.first]
  end

  def Scene.queue_next(scene)
    @@scene_queue.insert(1, scene)
  end

  def Scene.next_scene
    @@scene_queue.shift
  end

  def Scene.all
    @@scenes.keys
  end

	def step
    @frame += 1
	end

  def alert(alert, newlines = 0)
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