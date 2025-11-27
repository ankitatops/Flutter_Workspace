import 'package:app1/main.dart';
import 'package:flutter/material.dart';
import 'update.dart';
import 'package:http/http.dart' as http;

class mymodel extends StatelessWidget {
  var list;

  mymodel({required this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.withOpacity(0.05),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          var item = list[index];

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              elevation: 5,
              shadowColor: Colors.blue.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),

              child: Padding(
                padding: const EdgeInsets.all(16.0),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.blue.shade100,
                          child: Text(
                            item["id"],
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blue[900],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item["p_name"],
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[800],
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "₹ ${item["p_price"]}",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.green.shade700,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Updatescreen(
                                  id: item["id"],
                                  pname: item["p_name"],
                                  pprice: item["p_price"],
                                  pdes: item["p_des"],
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

                    SizedBox(height: 12),

                    Text(
                      item["p_des"],
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, id) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            "Are you sure?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          content: Text("Do you want to delete this product?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
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
    var resp = await http.post(url, body: {"id": id});
    print(resp.statusCode);
  }
}
