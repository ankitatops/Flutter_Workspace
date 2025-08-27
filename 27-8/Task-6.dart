import 'dart:io';
void main() {
  int i;
  print("Enter Any Number");
  var num = int.parse(stdin.readLineSync().toString());

  for (i = 1; i <= 10; i++) {
    var ans = num * i;
    print("$num * $i = $ans");
  }
}