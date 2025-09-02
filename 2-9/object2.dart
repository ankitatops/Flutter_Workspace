import 'dart:io';

class Student
{
  var name;
  var email;
}
void main()
{
  var s1 = Student();

  print("Enter Your Name");
  var n = stdin.readLineSync().toString();

  print("Enter Your Email");
  var e = stdin.readLineSync().toString();


  s1.name = n;
  s1.email = e;

  print("Your Name is ${s1.name}");
  print("Your Email is ${s1.email}");

}