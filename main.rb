require 'yaml'
require_relative 'game'
require_relative 'hangman'

# Retrieves the wanted file inputted by user and displays the game
def load_game
  saved = list_of_games
  choice = ''
  loop do
    choice = gets.chomp
    break if saved.include?(choice)
  end

  loaded_game = Psych.unsafe_load(File.read("#{Dir.pwd}/saved_games/#{choice}"))
  loaded_game.game
end

# Displays list of saved games and asks user to pick one of them
def list_of_games
  saved = []
  puts 'Select a game to load. If none appear, there are no saved games'
  dir_path = "#{Dir.pwd}/saved_games"
  Dir.foreach(dir_path) do |filename|
    next if ['.', '..'].include?(filename)

    saved.push(filename)
    puts filename
  end
  puts
  saved
end

puts "Welcome to Hangman!\nThe purpose of this game is to guess the unknown word in 6 or less turns!"
puts "To save your game at any given time, type 'save'\n\n"

# Continuoulsy allows user to play the game, save the game, or exit
loop do
  choice = ''
  loop do
    puts "Do you want to:\n[1] Load a game\n[2] Play a new game\n[3] Exit\n\n"
    choice = gets.chomp
    puts
    break if %w[1 2 3].include?(choice)
  end

  case choice
  when '2'
    access = File.readlines('google-10000-english-no-swears.txt').map(&:chomp)
    word = access.sample
    word = access.sample while word.length < 5 || word.length > 12
    game = Game.new(word)
    game.game
  when '1'
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
    load_game
  else
    break
  end
end
