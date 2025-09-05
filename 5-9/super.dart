class Color
{
  var color= "black";
}
class Color2 extends Color
{
  var color= "white";

  display()
  {
    print(color);
    print(super.color);
  }
}
void main()
{
  var c1 = Color2();
  c1.display();
}