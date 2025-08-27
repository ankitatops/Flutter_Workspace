import 'dart:io';

void main()
{
  print("Enter Number Between 1 to 10");
  var num = int.parse(stdin.readLineSync().toString());

  if(num>=5)
  {
    print("Higher");
  }
  else
  {
    print("Lower");
  }

}