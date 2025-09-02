import 'dart:io';

void main()
{
  print("enter Students Score");
  var score=int.parse(stdin.readLineSync().toString());

  if(score>=90 && score<=100)
    {
      print("Grade : A");
    }
  else if(score>=80 && score<=89)
  {
    print("Grade : B");
  }
  else if(score>=70 && score<=79)
  {
    print("Grade : c");
  }
  else if(score>=60 && score<=69)
  {
    print("Grade : D");
  }
  else if(score<60 && score>=0)
  {
    print("Grade : F");
  }
  else
    {
      print("invalid score");
    }
}