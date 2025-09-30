
import 'dart:io';

Stream<int> numberStream(int max)
{
  List<int> numbers = [];
  for (int i = 1; i <= max; i++)
  {
    numbers.add(i);
  }
  return Stream.fromIterable(numbers);
}

void main() async
{
  await for (int n in numberStream(5))
  {
    print("Number $n");
    await Future.delayed(Duration(seconds: 1));
  }

  print("Sequence ended.");
}
