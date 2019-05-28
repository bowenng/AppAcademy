class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  def self.random_word
    DICTIONARY.sample
  end

  def initialize
    @secret_word = self.class.random_word
    @guess_word = Array.new(@secret_word.length, "_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def guess_word
    @guess_word
  end

  def attempted_chars
    @attempted_chars
  end

  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end

  def already_attempted?(char)
    if @attempted_chars.include? char
      return true
    else
      return false
    end
  end

  def get_matching_indices(char)
    indices = []
    @secret_word.each_char.with_index {|c,i| indices << i if char == c}
    indices
  end

  def fill_indices(char, indices)
    indices.each {|i| @guess_word[i] = char}
  end

  def try_guess(char)
    if already_attempted?(char)
      print "that has already been attempted"
      return false
    else
      @attempted_chars << char

      matching_indices = get_matching_indices(char)
      if matching_indices.empty?
        @remaining_incorrect_guesses -= 1
      else
        fill_indices(char, matching_indices)
      end

      return true
    end
  end

  def ask_user_for_guess
    print "Enter a char"
    user_input = gets.chomp
    try_guess(user_input)
  end

  def win?
    if @guess_word.join("") == @secret_word
      print "WIN"
      return true
    else
      return false
    end
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      print "LOSE"
      return true
    else
      return false
    end
  end

  def game_over?
    did_win = win?
    did_lose = lose?

    if did_win || did_lose
      print @secret_word
      return true
    else
      return false
    end
  end
end
