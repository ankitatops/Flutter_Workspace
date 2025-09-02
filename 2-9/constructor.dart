import 'dart:io';

class Student
{

  //constructor
  Student()
  {
    print("Data Called");
  }
  display()
  {
    print("Display Called");
  }

}

void main()
{
  var s1 = Student();
  s1.display();

}