import 'dart:io';

void main()
{
  print("Enter Number Between 1 to 10");
  var num = int.parse(stdin.readLineSync().toString());

  if(num!=10)
  {
    print("Already Assigned ");
  }
  else
  {
    print("Available");
  }


}