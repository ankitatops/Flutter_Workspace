class Book
{
  String title;
  String author;
  int publicationYear;


  Book(this.title, this.author, this.publicationYear);


  void displayDetails()
  {
    print('--- Book Details ---');
    print('Title: $title');
    print('Author: $author');
    print('Publication Year: $publicationYear');
  }


  bool isOverTenYearsOld()
  {
    int currentYear = DateTime.now().year;
    return (currentYear - publicationYear) > 10;
  }
}

void main()
{
 
  Book myBook = Book('2000', 'history', 2023);

  myBook.displayDetails();

  if (myBook.isOverTenYearsOld())
  {
    print('This book is over 10 years old.');
  } else
  {
    print('This book is not over 10 years old.');
  }
}
