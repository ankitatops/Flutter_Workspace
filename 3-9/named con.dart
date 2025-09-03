class Student
{

  //parameterrized con
  Student(var name,var surname,var email,var city)
  {
    print("$name");
    print("$surname");
    print("$email");
    print("$city");
  }
  //named con
  Student.a(var name,var surname,var email)
  {
    print("$name");
    print("$surname");
    print("$email");

  }
  Student.b(var name,var surname,var email)
  {
    print("$name");
    print("$surname");
    print("$email");

  }

}
void main()
{
  var s1 = Student("ankita", "xyz", "a@gmail.com", "rajkot");
  var s2 = Student.a("Jiya", "xyz", "J@gmail.com");
  var s3 = Student.b("meera", "xyz", "m@gmail.com");
}