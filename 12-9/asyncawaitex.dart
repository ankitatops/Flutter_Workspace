
Future delayprint(int seconds, String msg)
{
  final duration = Duration(seconds: seconds);
  return Future.delayed (duration).then((value) => msg);
}
void main()async
{
  print("Life");
  await delayprint(2, "Is").then((status)
  {
    print(status);
  });
  print("Good");
}
