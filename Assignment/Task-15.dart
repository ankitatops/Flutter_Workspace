import 'dart:io';

void main()
{
  print("Enter a string:");
  String input = stdin.readLineSync().toString();

  int n = input.length;

  Map<String, int> charFrequency = {};

  for (int i = 0; i < n; i++)
  {
    String ch = input[i];
    if (charFrequency.containsKey(ch))
    {
      charFrequency[ch] = charFrequency[ch]! + 1;
    }
    else
    {
      charFrequency[ch] = 1;
    }
  }

  print("Character Frequency:");
  charFrequency.forEach((key, value)
  {
    print("'$key' : $value");
  });
}