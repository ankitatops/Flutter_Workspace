import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Custom Styled List with Add',
    home: CustomListScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class CustomListScreen extends StatefulWidget {
  @override
  _CustomListScreenState createState() => _CustomListScreenState();
}

class _CustomListScreenState extends State<CustomListScreen> {
  List<String> items = [
    "Apples",
    "Bananas",
    "Oranges",
    "Grapes",
    "Mangoes",
  ];

  final TextEditingController _controller = TextEditingController();

  void _addItem() {
    final newItem = _controller.text.trim();
    if (newItem.isNotEmpty) {
      setState(() {
        items.add(newItem);
        _controller.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item added')),
      );
    }
  }

  void _deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Item deleted')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Styled List with Add'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Enter new item',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _addItem(),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addItem,
                  child: Text('Add'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
                    elevation: 3,
                    child: ListTile(
                      leading: Icon(
                        Icons.shopping_cart,
                        color: Colors.blue,
                        size: 32,
                      ),
                      title: Text(
                        items[index],
                        style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteItem(index),
                        tooltip: 'Delete item',
                      ),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Tapped on ${items[index]}')),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
