class Model
{
  var _name;
  var _email;

  set name(value)
  {
    _name = value;
  }

  get name => _name;

  set email(value)
  {
    _email = value;
  }

  get email => _email;


}
void main()
{
  var m1 = Model();

  //set
  m1.name="abcd";
  m1.email="a@gmail.com";

  //get
  print(m1.name);
  print(m1.email);
}