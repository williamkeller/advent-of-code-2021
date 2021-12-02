# 2021 Advent of Code

To run a particular puzzle, use the runner tool.

`ruby runner.rb` will run puzzles, based on the arguments below.

Arguments are:
  `-d n` where n is 1 to 25, defaults to today (only correct in central time)
  `-p n` where p is 1 or 2, for the puzzle of the day, defaults to 1
  `-t` if set, use the test data instead of real data, no default

This is (usually) called from vim bindings, rather than the command line.

For this to work, it requires some conventions-over-configurations.

Puzzles are grouped in one day per file, named "dayNN.rb", where NN is the day
of the calendar (prepended with 0 if necessary).

Puzzle data goes in the `data` folder, and is named "dayNN.txt" or
dayNN_test.txt", depending on whether the data is real data or test data.

Puzzles are each contained in their own methods, called `part_one` and
`part_two`.



