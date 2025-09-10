
void main()
{

  List numbersList = [100,200,300,400,100,200];

  print(numbersList[2]);
  numbersList[2]=500;
  print(numbersList[2]);

  for(int i=0;i<numbersList.length;i++)
  {
    print(numbersList[i]);
  }

}
