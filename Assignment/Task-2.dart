import 'dart:io';

void main()
{
  print("1.celsius to fahrenheit");
  print("2.fahrenheit to celsius");
  
  print("enter choice(1 or 2)");
  var ch =int.parse(stdin.readLineSync().toString());
  
  if(ch==1)
    {
      print("enter celsius:");
      var c=double.parse(stdin.readLineSync().toString());
      
      var f=(c*9/5)+32;
      print("$c `c=$f `f");
    }
  else if(ch==2)
    {
      print("enter fahrenheit:");
      var f=double.parse(stdin.readLineSync().toString());
      var c=(f-32)*5/9;
      print("$f `f =$c`c");
    }
  else
    {
      print("wrong choice!");
    }

}