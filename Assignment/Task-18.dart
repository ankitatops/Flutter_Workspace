class BankAccount
{
  String accountNumber;
  String accountHolder;
  double balance;


  BankAccount(this.accountNumber, this.accountHolder, this.balance);


  void deposit(double amount)
  {
    if (amount <= 0)
    {
      print('Deposit amount must be greater than 0.');
      return;
    }
    balance += amount;

  }


  void withdraw(double amount)
  {
    if (amount <= 0)
    {
      print('Withdrawal amount must be greater than 0.');
      return;
    }
    if (amount > balance)
    {
      print(" Withdrawal failed.");
    } else
    {
      balance -= amount;

    }
  }


  void checkBalance()
  {
    print('Current balance: ${balance}');
  }
}

void main()
{
  BankAccount myAccount = BankAccount('123456789', 'Alice Smith', 500.0);

  print('--- Account Details ---');
  print('Account Holder: ${myAccount.accountHolder}');
  print('Account Number: ${myAccount.accountNumber}');
  myAccount.checkBalance();

  myAccount.deposit(150.0);
  myAccount.withdraw(100.0);
  myAccount.withdraw(600.0);
  myAccount.checkBalance();
}

