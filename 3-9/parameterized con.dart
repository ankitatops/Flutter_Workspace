class Student
{
  var n;
  var e;

  //parameterized constructor
  Student(var name,var email)
  {
    n = name;
    e = email;
  }

  display()
  {
    print("$n and $e");
  }

}
void main()
{
  var s1 = Student("ankita", "a@gmail.com");
  var s2 = Student("meera", "m@gmail.com");

  s1.display();
  s2.display();

}