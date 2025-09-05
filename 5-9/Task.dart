class Emp
{


  Emp(var n,var s)
  {
   
    print("name is $n");
    print("salary is $s");
  }

}
class Manager extends Emp
{
  Manager(super.n, super.s);
}
void main()
{

  Manager m1 = Manager("a","1");
  Manager m2 = Manager("a","1");

}