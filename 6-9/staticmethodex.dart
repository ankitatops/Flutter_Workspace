
class Account
{
  var id;
  var name;
  var salary;
  static var company="XYZ";

  Account(var id,var name,var salary)
  {
    this.id=id;
    this.name=name;
    this.salary=salary;
  }

  display()
  {
    print("Your id is $id");
    print("Your name is $name");
    print("Your salary is $salary");
    print("Your company is $company");

  }
  static change()
  {

    company="Abc";

  }
}
void main()
{
  var a1 = Account(101, "a", 1234);
  var a2 = Account(102, "b", 5678);

  Account.change();

  a1.display();
  a2.display();
}
