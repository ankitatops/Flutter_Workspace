import 'dart:io';

void main()
{
  print("enter any number");
  var num = int.parse(stdin.readLineSync().toString());

  try
  {
    int num1 = num ~/ 0;
    print(num1);
  }

  catch(element)
  {
    print(element);
  }
  finally
  {
    print("executed");
  }


}