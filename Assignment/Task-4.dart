import 'dart:io';
void main()
{
  const double pi=3.14;

  print("enter the redius of the circle:");
  var redius=double.parse(stdin.readLineSync().toString());

  var area =pi*redius*redius;
  var circumference=2*pi*redius;

  print("area of circle =$area");
  print("circumference of circle=$circumference");
}