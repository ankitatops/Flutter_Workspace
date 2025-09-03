findVolume(int length, {int breadth = 22, int height = 10})
{

  print("Lenght is $length");
  print("Breadth is $breadth");
  print("Height is $height");

  print("Volume is ${length * breadth * height}");
}

void main()
{

  findVolume(10);
  print("");

  findVolume(10, breadth: 5, height: 30);
  print("");

  findVolume(10, height: 30, breadth: 5);
}