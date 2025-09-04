class Bank
{
  bank()
  {
    print("banking");
  }
}
class Current extends Bank
{
  current()
  {
    print("current");
  }

}
class Save extends Bank
{
  save()
  {
    print("saving");
  }
}
void main()
{

  Current c = Current();
  Save s = Save();

  c.current();
  s.save();
  c.bank();
}