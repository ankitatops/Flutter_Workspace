
void main()
{
  List<int> numbers = [2, 4, 6, 8];

  List<int> squares = [];
  List<int> cubes = [];
  List<double> halves = [];

  for (int n in numbers) {
    squares.add(n * n);
    cubes.add(n * n * n);
    halves.add(n / 2);
  }

  print("Numbers: $numbers");
  print("Squares: $squares");
  print("Cubes: $cubes");
  print("Halves: $halves");
}
