import 'dart:io';

void main()
{
  try {

    File file = File('bin/practical/hello.txt');

    String contents = file.readAsStringSync();
    print("File found");
    print(contents);
  }
  catch (e)
  {
    print("Error: File not found!");
  }
}