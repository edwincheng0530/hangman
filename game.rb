require 'yaml'
require_relative 'hangman'

class Game
  def initialize(word)
    @hangman = Hangman.new(word)
    @saved = false
  end

  # Begins the game, keeping count of when a given game ends/stops
  def game
    until @hangman.final_guess_right? || @hangman.num_of_guesses.zero? || @saved
      @hangman.print_guess
      puts "Incorrect Guesses: #{@hangman.guess_list}"
      puts "Correct Guesses: #{@hangman.correct_list}\n\n"
      x = valid_guess
      right_or_wrong(x)
    end
    game_end
  end

  # Gets a valid guess from the alphabet that isn't already guessed
  def valid_guess
    guess = ''
    loop do
      puts "Guess ##{@hangman.num_of_guesses}:"
      guess = gets.chomp
      puts
      break unless @hangman.valid_guess?(guess)
    end
    guess
  end

  # Decides whether guessed letter is correct or not in context of the word
  def right_or_wrong(letter)
    save_game if letter.downcase == 'save'

    @hangman.change_lists(letter)
  end

  # Saves the game and creates a file on /saved_games with the serialized object
  def save_game
    puts 'What should I save this file as?:'
    name = gets.chomp
    serial = to_yaml
    File.open("saved_games/#{name}.txt", 'a') do |file|
      file.puts serial
    end
    @saved = true
  end

  # Signals the games end, congratulating or failing the user
  def game_end
    if @saved
      puts 'Game saved!'
      return
    end
    if @hangman.final_guess_right?
      puts "Congratulations! You guessed the right word! It was #{@hangman.word}"
    else
      puts "Errrrr you lose!\n\nThe correct word was: #{@hangman.word}"
    end
  end
end
