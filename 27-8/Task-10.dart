import 'dart:io';

void main() {


  print("Enter Any Number");
  var num = int.parse(stdin.readLineSync().toString());

  var digit1=num%10;
  var digit2=num;
  while (digit2 >=10) {
    digit2 ~/ 10;

    var sum = digit2 + digit1;
    print(sum);
  }
  print( digit2);
  print(digit1);
  //print(sum);
}