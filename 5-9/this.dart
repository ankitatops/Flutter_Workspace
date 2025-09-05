class Emp
{
  var n;
  var s;

  Emp(var n, var s)
  {
    this.n = n;
    this.s = s;
  }
  display()
  {
    print("your name is :$n");
    print("your salary is:$s");
  }
}
void main()
{
  var e1=Emp("a", "20000");
  e1.display();
}