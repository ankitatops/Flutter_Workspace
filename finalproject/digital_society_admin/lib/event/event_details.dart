import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'update_event.dart';

class EventDetailsPage extends StatelessWidget {

  final Map event;

  const EventDetailsPage({super.key, required this.event});

  Future deleteEvent() async {

    await http.post(
      Uri.parse("https://prakrutitech.xyz/ankita/delete_event.php"),
      body: {"id": event["id"].toString()},
    );
  }

  @override
  Widget build(BuildContext context) {

    String imageUrl =
        "https://prakrutitech.xyz/ankita/uploads/events/${event["image"]}";

    return Scaffold(

      appBar: AppBar(
        title: Text(event["title"]),

        actions: [

          /// EDIT EVENT
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {

              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UpdateEventPage(event: event),
                ),
              );

              Navigator.pop(context, true);
            },
          ),

          /// DELETE EVENT
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {

              showDialog(
                context: context,
                builder: (context) {

                  return AlertDialog(

                    title: const Text("Delete Event"),

                    content: const Text(
                        "Are you sure you want to delete this event?"),

                    actions: [

                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),

                      TextButton(
                        onPressed: () async {

                          await deleteEvent();

                          Navigator.pop(context); // close dialog
                          Navigator.pop(context, true); // go back
                        },
                        child: const Text(
                          "Delete",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),

                    ],
                  );
                },
              );
            },
          ),

        ],
      ),

      body: SingleChildScrollView(

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            /// EVENT IMAGE
            Image.network(
              imageUrl,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  /// EVENT TITLE
                  Text(
                    event["title"],
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  /// EVENT DATE
                  Text(
                    "Date : ${event["event_date"]}",
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 20),

                  /// DESCRIPTION TITLE
                  const Text(
                    "Description",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  /// EVENT DESCRIPTION
                  Text(
                    event["description"],
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}