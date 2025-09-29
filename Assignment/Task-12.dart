import 'dart:io';

void findLargestSmallest(int a, int b, int c)
{
  int largest = a;
  int smallest = a;


  if (b > largest)
  {
    largest = b;
  }
  if (c > largest)
  {
    largest = c;
  }

  if (b < smallest)
  {
    smallest = b;
  }
  if (c < smallest)
  {
    smallest = c;
  }

  print("the Largest num is : $largest");
  print("the smallest num is : $smallest");
}

void main()
{
  print("Enter the number");
  var num1 = int.parse(stdin.readLineSync().toString());

  print("Enter the number");
  var num2 = int.parse(stdin.readLineSync().toString());

  print("Enter the number");
  var num3 = int.parse(stdin.readLineSync().toString());

  findLargestSmallest(num1, num2, num3);
}