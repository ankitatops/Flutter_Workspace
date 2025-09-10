
void main()
{

  Set numbersset = Set();

  numbersset.add(10);
  numbersset.add(20);
  numbersset.add(30);
  numbersset.add(40);
  numbersset.add(10);
  numbersset.add(50);

  print(numbersset);

  for(var data in numbersset)
  {
    print(data);
  }

}
