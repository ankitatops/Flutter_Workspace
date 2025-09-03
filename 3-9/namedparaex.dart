getdetails(var name,var surname,{var email,var city})
{

  if(name!=null)
  {
    print("$name");
  }
  if(surname!=null)
  {
    print("$surname");
  }
  if(email!=null)
  {
    print("$email");
  }
  if(city!=null)
  {
    print("$city");
  }
}

void main()
{
  //named parameter
  getdetails("a", "a",city: "rajkot",email:"a@gmail.com");
  getdetails("b","b");
  getdetails("ankita", "xyz",city: "rajkot");

}