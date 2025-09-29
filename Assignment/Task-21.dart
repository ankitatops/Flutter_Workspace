import 'dart:io';

void main()
{
  try
  {
    print("Enter the first number:");
    double num1 = double.parse(stdin.readLineSync().toString());

    print("Enter the second number:");
    double num2 = double.parse(stdin.readLineSync().toString());

    double result = num1 / num2;
    print("Result: $num1 ÷ $num2 = $result");
  }
  catch (e)
  {
    print("Error: Cannot divide by zero or invalid input!");
  }
}