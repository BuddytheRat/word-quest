class Scene
	def initialize(title, subtitle, description)
    @title = title
    @subtitle = subtitle
    @description = description
		@display_queue = Array.new
		@scene_over = false
    @frame = 0
	end

	def is_over?
		@scene_over
	end

	def step
    @frame += 1
	end

  def alert(alert, newlines = 0)
    #puts @display_queue.class
    @display_queue << alert + "\n" * newlines
  end

  def title_string
    alert("#{@title} - #{@subtitle}", 2)
  end

	def display
		@display_queue.each { |str| puts str }
    @display_queue.clear
	end
end