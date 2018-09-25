# Ruby Battleship

Command-line battlehsip.

Guess where your opponent's ships are on a 10x10 grid.

The ships are 1x3 and randomly distributed.

If you guess a coordinate correctly, you sink the ship!

If you guess incorrectly, you have to guess again. Your guesses are tracked on the board.

## TODO

- [ ] Figure out how to represent the battlefield with 1x3 ships
  - Data structure should be separate from representation

Architecture of the game:
* Display
* Command-line interface
* Game loop
  - Show display
  - Wait for command-line input
  - Check win conditions

* Battlefield
  - Keeps track of where ships are
  - Responds to whether a given cell has a ship on it

* IntelBoard
  - Keeps track of what has been guessed for a player
  - Any sunk ships are clearly identified on here



