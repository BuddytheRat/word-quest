class Scene
	def initialize
		@display_queue = Array.new
		@scene_over = false
	end

	def is_over?
		@scene_over
	end

	def step

	end

  def alert(alert)
    #puts @display_queue.class
    @display_queue << alert
  end

	def display
		@display_queue.each { |str| puts str }
    @display_queue.clear
	end
end