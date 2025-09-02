import 'dart:io';

class Student
{
  var email = "tops@gmail.com";
  var pass = "123456";

  var e="";
  var p="";

  display()
  {
    if(email==e)
    {
      print("Login Success");
    }
    else
    {
      print("Login Fail");
    }
  }
}

void main()
{

  print("Enter Your Email Id: ");
  var e = stdin.readLineSync().toString();

  print("Enter Your Password: ");
  var p = stdin.readLineSync().toString();

  var s1 = Student();
  s1.e=e;
  s1.p=p;

  s1.display();
}