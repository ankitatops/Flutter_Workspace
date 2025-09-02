import 'dart:io';

void main()
{
  print("enter number");
  var num=int.parse(stdin.readLineSync().toString());

  var count=0;

  for(int i=1; i<=num; i++)
    {
      if(num%i==0)
        {
          count++;
        }

    }
  if(count==2)
    {
      print("$num is prime");
    }
  else
    {
      print("$num is not prime");
    }
}