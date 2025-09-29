import 'dart:io';

Future fetchUser(int id, List<String> users)
{
  return Future.delayed(Duration(seconds: 1)).then((_)
  {
    users.add("User $id");
    print("User $id loaded");
  });
}

void main() async
{
  List<String> users = [];

  print("Fetching users...");

  await fetchUser(1, users);
  await fetchUser(2, users);
  await fetchUser(3, users);
  await fetchUser(4, users);
  await fetchUser(5, users);

  print("All users loaded:");
  print(users);
}