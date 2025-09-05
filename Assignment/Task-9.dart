import 'dart:io';


 factorial()
 {
    print("enter number");
    var num = int.parse ( stdin.readLineSync().toString());

    var i = 1;
    for(i=1;i<=num;i++)
    {
      i*= i ;
    }
    print("factorial of : $i");
}
void main() {

   factorial();
}