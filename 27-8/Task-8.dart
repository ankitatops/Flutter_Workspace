import 'dart:io';

void main() {
  var max = 0;

  print("Enter Any Number");
  var num = int.parse(stdin.readLineSync().toString());

  while (num > 0) {
    int rem = num % 10;
    if (rem > max) {
      max = rem;
    }
    num = num ~/ 10;
  }
  print("Biggest digit is: $max");
}