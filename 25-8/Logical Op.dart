import 'dart:io';

void main()
{
  print("Enter Number Between 1 to 10");
  var num = int.parse(stdin.readLineSync().toString());

  if(num>=1 && num<=10)
  {
    if(num>=7 && num<=10)
    {
      print("Your Number is between 7 to 10");
    }
    else
    {
      print("Your Number is less than 7");
    }

  }
  else
  {
    print("Your Number is not valid");
  }




}