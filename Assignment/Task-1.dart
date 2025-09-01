import 'dart:io';

void main()
{
  print("enter name");
  var name=stdin.readLineSync().toString();
  
  print("enter age");
  var age=int.parse(stdin.readLineSync().toString());

  var year=100-age;

  print("welcome :$name! you have:$year years left until you turn 100");

}