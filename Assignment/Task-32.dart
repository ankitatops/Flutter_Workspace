
import 'dart:io';

void main()
{
  var numberToGuess = 50;
  var guess = 0;

  print("Guess a number between 1 and 100:");

  while (guess != numberToGuess)
  {
    stdout.write("Enter your guess: ");
    var input = stdin.readLineSync().toString();

    var number = int.tryParse(input);
    if (number == null)
    {
      print("Please enter a number!");
      continue;
    }

    guess = number;

    if (guess < numberToGuess) print("Too high!");
    else if (guess > numberToGuess) print("Too low!");
    else print("Correct!");
  }
}
