class Monster
  attr_reader :name, :level, :blanks, :hp, :xp, :gold, :word
  def initialize(name, level)
    @name = name
    @level = level
    file = File.open("5desk.txt") do |f|
      words = f.readlines
      words = words.select { |word| word.length >= 6 && word.length <= @level + 6 && word[0] =~ /[a-z]/ }
      @word = words.sample.split('')[0..-2]
      @blanks = '_' * @word.length
    end
    @hp = @word.size
    @xp = @level * 3
    @gold = rand(@level * 3)
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
    rand(@level * 3)
  end

  def check_letter(letter)
    matches = 0
    @word.each_with_index do |char, i|
      if letter.downcase == char.to_s.downcase
        fill_blank(i, char)
        @word[i] = nil
        matches += 1
      end
    end
    @hp -= matches
    matches
  end
end