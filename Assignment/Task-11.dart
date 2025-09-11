import 'dart:io';
Fibonacci ()
{
  print("enter a number");
  var num = int.parse(stdin.readByteSync().toString());

  var a=0;
  var b=1;

  while (a <= num)
  {
    print("$a ");
    int next = a + b;
    a = b;
    b = next;
  }
}
void main()
{
  Fibonacci();
}