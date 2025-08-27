import 'dart:io';

void main()
{
  print("Enter First Exam Marks");
  var marks1 = int.parse(stdin.readLineSync().toString());

  print("Enter Second Exam Marks");
  var marks2 = int.parse(stdin.readLineSync().toString());

  if(marks1>=35 || marks2>=35)
  {
    print("Pass");
  }
  else
  {
    print("Fail");
  }



//      if(marks1>=35 && marks2>=35)
//   {
//       print("Pass");
//   }
}