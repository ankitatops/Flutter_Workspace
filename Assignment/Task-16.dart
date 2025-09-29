
import 'dart:io';

void main()
{
  Map<String, String> addressBook = {};
  int choice;

  do
  {

    print("1. Add a contact");
    print("2. Update a contact");
    print("3. Remove a contact");
    print("4. View all contacts");
    print("5. Exit");

    print("Enter your choice (1-5): ");
    choice = int.parse(stdin.readLineSync().toString());

    switch (choice)
    {
      case 1:
        print("Enter name: ");
        String name = stdin.readLineSync().toString();
        print("Enter phone number: ");
        String phone = stdin.readLineSync().toString();
        addressBook[name] = phone;
        print("Contact added successfully!");
        break;

      case 2:
        print("Enter name to update: ");
        String name = stdin.readLineSync().toString();
        if (addressBook.containsKey(name))
        {
          print("Enter new phone number: ");
          String phone = stdin.readLineSync().toString();
          addressBook[name] = phone;
          print("Contact updated successfully!");
        }
        else
        {
          print("Contact not found.");
        }
        break;

      case 3:
        print("Enter name to remove: ");
        String name = stdin.readLineSync().toString();
        if (addressBook.containsKey(name))
        {
          addressBook.remove(name);
          print("Contact removed successfully!");
        }
        else
        {
          print("Contact not found.");
        }
        break;

      case 4:
        if (addressBook.isEmpty)
        {
          print("Address book is empty.");
        }
        else
        {
          print("All Contacts:");
          addressBook.forEach((name, phone)
          {
            print("$name : $phone");
          });
        }
        break;

      case 5:
        print("Exiting program. Goodbye!");
        break;

      default:
        print("Invalid choice! Please enter 1-5.");
    }
  }
  while (choice != 5);
}
