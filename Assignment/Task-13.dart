import 'dart:io';

List sortAscending(List<int> list)
{
  for (int i = 0; i < list.length - 1; i++)
  {
    for (int j = 0; j < list.length - i - 1; j++)
    {
      if (list[j] > list[j + 1])
      {
        int temp = list[j];
        list[j] = list[j + 1];
        list[j + 1] = temp;
      }
    }
  }
  return list;
}

List<int> sortDescending(List<int> list)
{
  for (int i = 0; i < list.length - 1; i++)
  {
    for (int j = 0; j < list.length - i - 1; j++)
    {
      if (list[j] < list[j + 1])
      {
        int temp = list[j];
        list[j] = list[j + 1];
        list[j + 1] = temp;
      }
    }
  }
  return list;
}

void main()
{
  stdout.write("Enter numbers separated by space: ");
  String? input = stdin.readLineSync();

  List<int> numbers = input!
      .split(' ')
      .map((e) => int.parse(e))
      .toList();

  // Create copies so original list isn't modified twice
  List<int> ascList = List.from(numbers);
  List<int> descList = List.from(numbers);

  print("\nOriginal List: $numbers");
  print("Sorted Ascending: ${sortAscending(ascList)}");
  print("Sorted Descending: ${sortDescending(descList)}");
}
