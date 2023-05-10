class HangmanGame
  @@guessingWord = ""
  @@hiddenWord = ""
  @@incorrectGuesses = 0
  @@guesses = []


  def initialize()
    gameLoop()
  end

  def showBody(part)
    case part
    when "head"
      if @@incorrectGuesses >= 1
        return "O"
      else
        return " "
      end
    when "body"
      if @@incorrectGuesses >= 2
        return "|"
      else
        return " "
      end
    when "leftArm"
      if @@incorrectGuesses >= 3
        return "\\"
      else
        return " "
      end
    when "rightArm"
      if @@incorrectGuesses >= 4
        return "/"
      else
        return " "
      end
    when "leftLeg"
      if @@incorrectGuesses >= 5
        return "/"
      else
        return " "
      end
    when "rightLeg"
      if @@incorrectGuesses >= 6
        return "\\"
      else
        return " "
      end
    end
  end

  def chooseRandomWord()
    file = File.open("dictionary.txt", "r")
    num = rand(10000)
    dictionary = file.read.split(" ")
    word = dictionary[num].to_s

    while word.length() > 12 or word.length() < 5
      num = rand(10000)
      word = dictionary[num].to_s
    end
    
    @@guessingWord = word

    for i in 0..(word.length() - 1)
      @@hiddenWord = @@hiddenWord +"_ "
    end

    @@hiddenWord.rstrip()
  end

  def showIntro()
    print "\nWelcome to Hangman! \n \n"
    print "How To Play: \n"
    print " • Guess letters to try to reveal the hidden word \n"
    print " • If the letter is in the word, it will be revealed \n"
    print " • If the letter is not in the word, another part will be added \n"
    print " • Once the entire human appears, you lose \n"
    print " • If you guess the enitre word before the human appears, you win \n \n"
    print "This game features a special saving feature! \n \n"
  end

  def showBoard()
    print "    ______  \n"
    print "   |      | \n"
    print "   |      #{showBody("head")} \n"
    print "   |     #{showBody("leftArm")}#{showBody("body")}#{showBody("rightArm")}  #{@@hiddenWord} \n"
    print "   |     #{showBody("leftLeg")} #{showBody("rightLeg")} \n"
    print " __|__         Guessed Letters: #{@@guesses} \n\n"
  end

  def getPlayerInput()
    print "Please enter a guess (Save 0, Load 1): "
    playerGuess = gets.to_s.gsub(/\s+/, "")
    playerGuess.downcase!
  
    while playerGuess.length != 1 or @@guesses.include? playerGuess or playerGuess =~ /[2-9]/
      print "Please enter a new single letter (Save 0, Load 1): "
      playerGuess = gets.to_s.gsub(/\s+/, "")
      playerGuess.downcase!
    end

    return playerGuess.to_s
  end

  def checkLetter(letter)
    if @@guessingWord.include? letter
      for i in 0..(@@guessingWord.length() -1)
        if @@guessingWord[i] == letter
          @@hiddenWord[i*2] = letter
        end
      end

      print "\nGood guess! \n \n"
    else
      print "\nNot included! \n \n"
      @@guesses.push(letter.to_s)
      @@incorrectGuesses = @@incorrectGuesses + 1
    end
  end

  def gameLoop()
    chooseRandomWord()
    showIntro()
    
    answerKey = ""
    
    while answerKey != @@guessingWord and @@incorrectGuesses < 6
      showBoard()
      input = getPlayerInput()

      if input == "0"
        saveGame()
      elsif input == "1"
        loadGame()
      else
        checkLetter(input)
      end

      answerKey = @@hiddenWord.gsub(/\s+/, "").to_s
    end

    showBoard()

    if @@incorrectGuesses < 6
      puts "Congratulations, you win! \n\n"
    else
      puts "Better luck next time! \n\n"
      puts "The word was: #{@@guessingWord} \n\n"
    end

  end

  def loadGame()
    puts "\n\e[42mGame loaded!\e[0m"
    
    inputGame = File.open("gamesave.txt", "r")
    gameSettings = inputGame.read.split("~")

    @@guessingWord = gameSettings[0].to_s
    @@hiddenWord = gameSettings[1].to_s
    @@incorrectGuesses = gameSettings[2].to_i
    @@guesses = []
    gameSettingsArray = gameSettings[3].gsub!(/\W+/, '').to_s

    for i in 0..(gameSettingsArray.length() -1)
      @@guesses.push(gameSettingsArray[i])
    end

  end

  def saveGame()
    puts "\n\e[44mGame saved!\e[0m"
    
    outputGame = File.new("gamesave.txt", "w")
    outputGame.puts("#{@@guessingWord}~#{@@hiddenWord}~#{@@incorrectGuesses}~#{@@guesses}")
    outputGame.close
  end

end

game = HangmanGame.new()