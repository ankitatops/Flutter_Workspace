abstract class A
{
  a();
}
abstract class B
{
  b();
}
class C implements A,B
{
  c()
  {
    print("C called");
  }
  @override
  a()
  {
    print("A called");
  }

  @override
  b()
  {
    print("B called");
  }

}
void main() {
  var c1 = C();
  c1.a();
  c1.b();
  c1.c();
}
