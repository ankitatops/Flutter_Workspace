
import 'dart:io';

class Vehicle
{
  String type;
  String fuel;
  int maxSpeed;

  Vehicle(this.type, this.fuel, this.maxSpeed);

  void showDetails()
  {
    print("Type: $type");
    print("Fuel: $fuel");
    print("Max Speed: $maxSpeed km/h");
  }
}


class Car extends Vehicle
{
  Car(super.type, super.fuel, super.maxSpeed);

  void carInfo()
  {
    print("car details.");
    showDetails();
  }
}


class Bike extends Vehicle
{
  Bike(super.type, super.fuel, super.maxSpeed);

  void bikeInfo()
  {
    print("bike details.");
    showDetails();
  }
}

void main()
{

  print("Enter fuel type for Car:");
  String Fuel = stdin.readLineSync().toString();
  print("Enter max speed for Car:");
  int Speed = int.parse(stdin.readLineSync().toString());

  print("Enter fuel type for Bike:");
  String Fuel1 = stdin.readLineSync().toString();
  print("Enter max speed for Bike:");
  int Speed1 = int.parse(stdin.readLineSync().toString());

  Car myCar = Car("Car", Fuel, Speed);
  myCar.carInfo();

  Bike myBike = Bike("Bike", Fuel1, Speed1  );
  myBike.bikeInfo();
}
