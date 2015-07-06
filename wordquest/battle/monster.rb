class Monster
  attr_reader :name, :level, :blanks, :hp, :word
  def initialize(name, level)
    @name = name
    @level = level
    file = File.open("5desk.txt") do |f|
      words = f.readlines
      words = words.select { |word| word.length >= 6 && word.length <= @level + 6 && word[0] =~ /[a=z]/ }
      @word = words.sample.split('')[0..-2]
      @blanks = '_' * @word.length
    end
    @hp = @word.length
  end

  def fill_blank(i, char)
    @blanks[i] = char
  end

  def blanks
    @blanks.split('').join(' ')
  end

  def is_dead?
    @hp <= 0 ? true : false
  end

  def attack
    @level + rand(@level)
  end
  
  def check_letter(letter)
    matches = 0
    @word.each_with_index do |char, i|
      if letter.downcase == char.to_s.downcase
        fill_blank(i, char)
        @word[i] = nil
        matches += 1
        @hp -= matches
      end
    end
    matches
  end
end