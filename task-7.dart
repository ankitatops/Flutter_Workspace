import 'dart:io';

void main() {
  print("enter sub 1 marks");
  var sub1 =int.parse( stdin.readLineSync().toString());

  print("enter sub 2 marks");
  var sub2 =int.parse( stdin.readLineSync().toString());

  print("enter sub 3 marks");
  var sub3 =int.parse( stdin.readLineSync().toString());

  print("enter sub 4 marks");
  var sub4 = int.parse( stdin.readLineSync().toString());

  print("enter sub 5 marks");
  var sub5 = int.parse( stdin.readLineSync().toString());

  var total =sub1+sub2+sub3+sub4+sub5;
  print("total is :$total");

  var per = total/5;
  print("percentage is : $per");

}