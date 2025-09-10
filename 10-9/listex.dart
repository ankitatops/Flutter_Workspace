
void main()
{
  List<dynamic> l1 = [10,"a",true];

  List<dynamic> l2 = [10,"a",true];

  l1.add("200");

  l1.addAll(l2);
  l1.remove(10);
  l1.removeAt(1);
  //l1.clear();
  for(var data in l1)
  {
    print(data);
  }
  print(l1);

}
