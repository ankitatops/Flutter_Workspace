
class RBI
{
  int rate()
  {
    return 0;
  }
}
class SBI extends RBI
{
  int rate()
  {
    return 7;
  }
}
class ICICI extends RBI
{
  int rate()
  {
    return 8;
  }
}
class AXIS extends RBI
{
  int rate()
  {
    return 9;
  }
}
void main()
{
  // var s1 = SBI();
  // var i1 = ICICI();
  // var a1 = AXIS();
  //
  // print(s1.rate());
  // print(i1.rate());
  // print(a1.rate());

  var r = RBI();

  r = SBI();
  print(r.rate());//7
  r = ICICI();
  print(r.rate());//8
  r = AXIS();
  print(r.rate());//9


}
