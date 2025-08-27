import 'dart:io';

void main()
{
  var sum =0;

  print("Enter Any Number");
  var num = int.parse(stdin.readLineSync().toString());//1234//123

  while(num > 0)
  {
    int rem = num % 10;//4//3//2//1
    sum+=rem;//0+4//4+3//7+2//9+1=10
    num=num ~/ 10;//123//12//1//0

  }
  print("Sum of all digits are: $sum");


}