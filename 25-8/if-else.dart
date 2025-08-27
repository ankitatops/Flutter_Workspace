import 'dart:io';

void main()
{
  print("Enter Marks");
  var marks = int.parse(stdin.readLineSync().toString());

  if(marks>=35)
  {
    print("Pass");
  }
  else
  {
    print("Fail");
  }


}
