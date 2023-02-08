class Hangman
  attr_accessor :num_of_guesses, :guess_list, :correct_list
  attr_reader :word

  def initialize(word)
    @word = word
    @num_of_guesses = 6
    @guess = Array.new(@word.length, '_')
    @guess_list = []
    @correct_list = []
  end

  # Print out the current word, with the correct guesses 
  def print_guess
    @guess.each do |element|
      print "#{element}  "
    end
    puts "\n\n"
  end

  # Returns whether the user has solved the hangman puzzle
  def final_guess_right?
    @word.split('') == @guess
  end

  # Checks whether the given user input for a guess is valid
  def valid_guess?(letter)
    return false if letter.downcase == 'save'

    return true if letter.length > 1

    @guess_list.include?(letter) || @correct_list.include?(letter)
  end

  # Given a guess, check and update @guess accordingly
  def change_lists(letter)
    if @word.include?(letter)
      @correct_list.push(letter)
      reveal_letter(letter)
    else
      @guess_list.push(letter)
      @num_of_guesses -= 1
    end
  end

  private

  # Pretty print for the user's current final guess
  def reveal_letter(letter)
    @word.split('').each_with_index {|value, index|
      if value == letter
        @guess[index] = letter
      end
    }
  end
end
