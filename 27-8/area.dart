import 'dart:io';

void main() {

  print("enter choice");
  var ch = int.parse(stdin.readLineSync().toString());

  if (ch == 1) {
    var a = 10;
    var b = 20;
    var area = 0.5 * a * b;
  }
  else if(ch==2)
    {
      var a = 10;
      var b = 20;
      var area=a*b;
    }
  else if(ch==3)
    {
      var Redius=10;
      var pi=3.14;
      var area =pi*Redius*Redius;
    }
  else
    {
      print("invalid choice!");
    }
}

