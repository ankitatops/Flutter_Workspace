
void main()
{
  List<int> list1 = [1, 2, 3];
  List<int> list2 = [2, 4, 9];
  List<int> list3 = [1, 3, 7];

  List<int> combinedList = [];
  combinedList.addAll(list1);
  combinedList.addAll(list2);
  combinedList.addAll(list3);

  print("Combined List: $combinedList");
  combinedList = combinedList.toSet().toList();
  combinedList.sort();
  print("Sorted List: $combinedList");
}

