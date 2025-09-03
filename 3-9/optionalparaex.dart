//optional parameter

getdetails(var name,var surname,[var email,var city])
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
  getdetails("a", "a", "a", "a");
  getdetails("b","b");
  getdetails("ankita", "xyz","rajkot");

}