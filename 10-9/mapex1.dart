
void main()
{
  Map<String, int> countryDialingCode =
  {
    "USA": 1,
    "INDIA": 91,
    "PAKISTAN": 92
  };

  for(var data in countryDialingCode.entries)
  {
    print(data);
  }

  Map<String, String> fruits = Map();
  fruits["apple"] = "red";
  fruits["banana"] = "yellow";
  fruits["guava"]  = "green";

  print(fruits.containsKey("apple"));
  fruits.update("apple", (value) => "green");
  fruits.remove("apple");
  fruits.isEmpty;
  fruits.length;


  for (String key in fruits.keys)
  {          
    print(key);
  }

}
