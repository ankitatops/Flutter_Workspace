import 'package:app1/main.dart';
import 'package:flutter/material.dart';
import 'update.dart';
import 'package:http/http.dart' as http;
class mymodel extends StatelessWidget {
  var list;

  mymodel({required this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        var item = list[index];

        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(15),
              leading: CircleAvatar(
                radius: 28,
                backgroundColor: Colors.blue.shade200,
                child: Text(
                  item["id"],
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              title: Text(
                item["p_name"],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 6),
                  Text(
                    "Price: ₹${item["p_price"]}",
                    style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(item["p_des"], style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                ],
              ),
              trailing: Wrap(
                spacing: 6,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateScreen(
                            id: item["id"],
                            name: item["p_name"],
                            price: item["p_price"],
                            description: item["p_des"],
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.edit, color: Colors.blue),
                  ),
                  IconButton(
                    onPressed: () {
                      _confirmDelete(context, item["id"]);
                    },
                    icon: Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, id) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text("Are you sure?"),
          content: Text("Do you want to delete this product?"),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: Text("Cancel")),
            TextButton(
              onPressed: () {
                deletedata(id);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => ViewScreen()),
                );
              },
              child: Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void deletedata(id) async {
    var url = Uri.parse("https://prakrutitech.xyz/ankita/delete.php");
    var resp = await http.post(url,body:
    {
      "id":id,

    });
    print(resp.statusCode);
  }
}
