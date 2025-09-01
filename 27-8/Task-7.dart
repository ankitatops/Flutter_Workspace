import 'dart:io';
void main()
{
  print("enter num");
  var num = int.parse(stdin.readLineSync().toString());

  var reverse =0;
  while(num>0)
    {
      int digit = num%10;
      reverse=reverse*10+digit;
      num~/=10;

    }
    print(reverse);
}