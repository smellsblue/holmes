module Holmes
  class CLI
    attr_reader :game

    def initialize
      @game = Holmes::Game.new
    end

    def start
    end

    def self.start
      new.start
    end
  end
end
