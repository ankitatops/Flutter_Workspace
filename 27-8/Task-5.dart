import 'dart:io';

void main()
{
  print("enter a number");
  var num = int.parse(stdin.readByteSync().toString());

  var a=0;
  var b=1;

 for(int i=0; a<=num;i++)
   {
     print(a);
     int ans=a+b;
     a=b;
     b=ans;
   }

}
