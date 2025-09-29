import 'dart:io';

ispalindrome(String Word)
{
  String reversed = Word.split('').reversed.join('');
  return Word == reversed;
}

void main() {
  print("Enter a string: ");
  var input = stdin.readLineSync()!;

  if (ispalindrome(input))
  {
    print("'$input' is a palindrome.");
  }
  else
  {
    print("'$input' is not a palindrome.");
  }
}