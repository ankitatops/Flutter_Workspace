
import 'dart:io';

void main() {
  List<int> numbers = [];

  print("Enter integers:");

  while (true)
  {
    print("Enter a number: ");
    var input = stdin.readLineSync();

    if (input == null)
    {
      continue;
    }

    if (input == '0')
    {
      break;
    }

    try
    {
      int number = int.parse(input);
      numbers.add(number);
    }
    catch (e)
    {
      print("Invalid input! Please enter an integer.");
    }
  }

  print("You entered: $numbers");
}
