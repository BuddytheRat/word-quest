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
		display_string = String.new
		@display_queue.each { |str| display_string += str + "\n" }
    @display_queue.clear
		display_string
	end
end