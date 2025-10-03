import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(home: new MyApp()));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: Text("Select Option AlertDialog")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async
              {
                final Product prodName = await _asyncSimpleDialog(context);
                print("Selected Product is $prodName");
              },
              child: const Text("Show Alert", style: TextStyle(fontSize: 20.0)),
            ),
          ],
        ),
      ),
    );
  }
}

enum Product { Apple, Samsung, Oppo, Redmi }

_asyncSimpleDialog(BuildContext context) async
{
  return await showDialog<Product>(
    context: context,
    builder: (BuildContext context)
    {
      return SimpleDialog(
        title: const Text('Select Product '),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, Product.Apple);
            },
            child: const Text('Apple'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, Product.Samsung);
            },
            child: const Text('Samsung'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, Product.Oppo);
            },
            child: const Text('Oppo'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, Product.Redmi);
            },
            child: const Text('Redmi'),
          ),
        ],
      );
    },
  );
}
