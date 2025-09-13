import 'dart:io';

validate(int age)
{
  if(age>18)
  {
    print("Eligible to vote");
  }
  else
  {
    throw Exception("Age is not valid");

  }
}

void main()
{

  validate(45);


}