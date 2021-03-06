class Scene
  @@scenes = Hash.new
  @@scene_queue = Array.new
  @@id = 0

	def initialize(player, title, subtitle, description, symbol = nil)
    @player = player
    @title = title
    @subtitle = subtitle
    @description = description
    @symbol = symbol
		@scene_over = false
    @frame = 0

    @symbol ||= "#{@@id}_#{title.gsub(' ', '_').downcase}".to_sym
    @@scenes[@symbol] = self
    @@id += 1
	end

  def Scene.current
    @@scenes[@@scene_queue.first]
  end

  def queue
    @@scene_queue << @symbol
  end

  def Scene.queue_next(symbol)
    @@scene_queue.insert(1, symbol)
  end

  def Scene.next_scene
    @@scene_queue.shift
  end

  def Scene.jump_to(symbol)
    @@scene_queue.unshift(symbol)
  end

  def Scene.all
    @@scenes.keys
  end

  def Scene.save
    scene_data = [@@scenes, @@scene_queue]
    save = YAML.dump(scene_data)
    game_file = File.new('save.yml', 'w')
    game_file.write save
    game_file.close
  end

  def Scene.load
    if File.exist?('save.yml')
      game_file = File.new('save.yml', 'r')
      scene_data = YAML.load(game_file)
      @@scenes = scene_data[0]
      @@scene_queue = scene_data[1]
    end
  end

	def step
    @frame += 1
    puts title_string
    puts description
    @player.confirm
    Scene.next_scene
	end

  def title_string
    "#{@title} - #{@subtitle}\n\n"
  end

  def description
    "#{@description}"
  end
end