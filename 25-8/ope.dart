import 'dart:io';

void main()
{
  print("Enter Your Choice Number");
  var num = int.parse(stdin.readLineSync().toString());

  var a = 5;

  print(a==num);
}

