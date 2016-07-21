module Holmes
  class Game
    attr_reader :directory, :map, :suspects

    def initialize
      @directory = Holmes::Directory.new
      @map = Holmes::Map.new
    end
  end
end
