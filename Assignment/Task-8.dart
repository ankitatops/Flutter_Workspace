import 'dart:io';

void main() {
  print("enter num 1");
  var num1=int.parse(stdin.readLineSync().toString());

  print("enter num 2");
  var num2=int.parse(stdin.readLineSync().toString());

  print("enter choice");
  var ch=int.parse(stdin.readLineSync().toString());

  switch (ch) {
    case 1:
      var ans=num1+num2;
      print("add is:$ans");
      break;

    case 2:
      var ans=num1-num2;
      print("sub is:$ans");
      break;

    case 3:
      var ans=num1*num2;
      print("mul is:$ans");
      break;

    case 4:
      var ans=num1/num2;
      print("div is:$ans");
      break;


    default:
      print("Your Number is not valid");
      break;
  }
}