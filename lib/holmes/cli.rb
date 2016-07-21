module Holmes
  class CLI
    attr_reader :game

    def initialize
      @game = Holmes::Game.new
      @playing = true
    end

    def start
      while playing?
        prompt "What would you like to do?",
               "View the map" => -> { view_map },
               "View the directory" => -> { view_directory },
               "Accuse someone" => -> { accuse },
               "Quit" => -> { quit }
      end
    end

    def playing?
      @playing
    end

    def view_map
    end

    def view_directory
    end

    def accuse
    end

    def quit
      @playing = false
    end

    def prompt(message, options)
      answer = nil

      until answer
        slowputs(message)
        slowputs("-" * message.size)
        options.keys.each.with_index { |key, index| slowputs("#{index + 1}) #{key}") }
        result = gets
        abort("Exiting without saving!") unless result
        answer = result.to_i unless result.strip =~ /\D/
        answer = nil unless (1..options.size).include?(answer)
        slowputs("Let's try that again...") unless answer
      end

      key = options.keys[answer - 1]

      begin
        options[key].call
      rescue => e
        slowputs "Something bad happened: #{e} (#{e.class})\n\t#{e.backtrace.join("\n\t")}", :fast
      end
    end

    def slowprint(msg, speed = :normal)
      factor =
        case speed
        when :slow
          2.0
        when :normal
          1.0
        when :fast
          0.25
        else
          1.0
        end

      msg.split("").each do |c|
        amount =
          if c == " "
            rand(0.0375..0.075)
          elsif c == "-"
            0.001
          elsif c == "\n"
            rand(0.25..0.375)
          else
            rand(0.0125..0.0375)
          end

        sleep(factor * amount)
        print c
      end
    end

    def slowputs(msg, speed = :normal)
      slowprint(msg, speed)
      slowprint("\n", speed)
    end

    def self.start
      new.start
    end
  end
end
