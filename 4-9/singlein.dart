class A
{
  a()
  {
    print("A called");
  }
}
class B extends A
{
  b()
  {
    print("B called");
  }
}
void main()
{
  var b1 = B();

  b1.a();
  b1.b();
}