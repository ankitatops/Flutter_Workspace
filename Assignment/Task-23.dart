import 'dart:io';

void main()
{
  print("Calculator");

  double num1;
  while (true)
  {
    try
    {
      print("Enter first number: ");
      num1 = double.parse(stdin.readLineSync()!);
      break;
    }
    catch (e)
    {
      print("Invalid input! Please enter a valid number.");
    }
  }

  double num2;
  while (true)
  {
    try
    {
      print("Enter second number: ");
      num2 = double.parse(stdin.readLineSync()!);
      break;
    }
    catch (e)
    {
      print("Invalid input! Please enter a valid number.");
    }
  }

  print("Choose operation (add, subtract, multiply, divide): ");
  var choice = stdin.readLineSync().toString();

  switch (choice)
  {
    case "add":
      print("Result: ${num1 + num2}");
      break;
    case "subtract":
      print("Result: ${num1 - num2}");
      break;
    case "multiply":
      print("Result: ${num1 * num2}");
      break;
    case "divide":
      if (num2 == 0)
      {
        print("Error: Division by zero not allowed!");
      }
      else
      {
        print("Result: ${num1 / num2}");
      }
      break;
    default:
      print("Invalid operator!");
  }
}