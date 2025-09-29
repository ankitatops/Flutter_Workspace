import 'dart:io';

void main()
{
  List<String> words = [];

  print("Enter number of words");
  int n = int.parse(stdin.readLineSync().toString());

  print("Enter $n words :");
  for (int i = 0; i < n; i++)
  {
    stdout.write("Word ${i + 1}: ");
    String word = stdin.readLineSync().toString().trim();
    words.add(word);
  }

  print(" entered: $words");

  Set<String> uniqueSet = {};
  for (int i = 0; i < n; i++)
  {
    uniqueSet.add(words[i]);
  }

  List<String> uniqueWords = uniqueSet.toList();

  for (int i = 0; i < uniqueWords.length; i++)
  {
    for (int j = i + 1; j < uniqueWords.length; j++)
    {
      if (uniqueWords[i].compareTo(uniqueWords[j]) > 0)
      {
        String temp = uniqueWords[i];
        uniqueWords[i] = uniqueWords[j];
        uniqueWords[j] = temp;
      }
    }
  }

  print("Unique words in alphabetical order:");
  for (String word in uniqueWords)
  {
    print(" $word");
  }
}