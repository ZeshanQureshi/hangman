# Hangman

Welcome to Hangman!

## Running the Repl

Simply hit run! The console will run "ruby lib/hangman.rb"

## How it Works

The file "google-10000-english-no-swears.txt" contains 10 000 words. The program will choose a random word from the file between 5 and 12 characters long.

Each turn, the player will try to guess the word by guessing letters. If the letter is correct, it will appear in the letter board. If the letter is incorrect, it will appear in the guesses letters board and the player will increment the incorrect guess counter (indicated to the player by the hangman). 

Number of incorrect guesses key:
 • 1+: Head appears
 • 2+: Body appears
 • 3+: Left arm appears
 • 4+: Right arm appears
 • 5+: Left leg appears
 • 6+: Right leg appears

If the player is able to guess the word before 6 incorrect guesses, they win. After 6 incorrect guesses, the game is over and the player loses.

The saving feature allows players to save and revist an old game. A game must first be save for a player to load the game. During the guessing period, a player can press 0 to save the curret state of the game. The player can also choose to enter 1 to load the saved game.

## Contact

If you run into any errors, feel free to email me at z22qures@gmail.com