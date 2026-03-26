import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Events/EventDetails.dart';
import '../notice/notice_detail.dart';
import '../problems/all_problems.dart';
import '../visitors/visitors_screen.dart';

class UserDashboard extends StatefulWidget {
  final String userName;

  const UserDashboard({Key? key, required this.userName}) : super(key: key);

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  int selectedIndex = 0;
  List events = [];
  bool isLoading = true;
  int eventCount = 0;
  int noticeCount = 0;
  int complaintCount = 0;

  List eventColors = [
    Colors.pink.shade100,
  ];

  final List quickActions = [
    {"icon": Icons.notifications, "title": "Notices"},
    {"icon": Icons.event, "title": "Events"},
    {"icon": Icons.report_problem, "title": "Complaint"},
    {"icon": Icons.people, "title": "Visitors"},
  ];

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    try {
      var response = await http.post(
        Uri.parse("https://prakrutitech.xyz/ankita/get_events.php"),
      );

      var data = json.decode(response.body);
      if (data["status"] == "success" && data["data"] != null) {
        setState(() {
          events = data["data"];
          eventCount = events.length;
          isLoading = false;
        });
      } else {
        setState(() {
          events = [];
          eventCount = 0;
          isLoading = false;
        });
      }
      if (data["status"] == "success") {
        setState(() {
          events = data["data"];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade200],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Hello, ${widget.userName}",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        statCard("Notices", noticeCount.toString(), Colors.blue),
                        statCard("Events", eventCount.toString(), Colors.green),
                        statCard("Complaints", complaintCount.toString(), Colors.red),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  sectionTitle("Quick Access"),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: quickActions.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: quickButton(
                            quickActions[index]["icon"],
                            quickActions[index]["title"],
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 180,
                    child: isLoading
                        ? Center(child: CircularProgressIndicator())
                        : events.isEmpty
                        ? Center(
                      child: Text(
                        "No Events",
                        style: TextStyle(color: Colors.black),
                      ),
                    )
                        : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        var event = events[index];

                        Color color =
                        eventColors[index % eventColors.length];

                        return eventCard(
                          event["event_name"] ??
                              event["title"] ??
                              event["name"] ??
                              "No Title",
                          event["event_date"] ?? "",
                          color,
                          event,
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  sectionTitle("Recent Notices"),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        noticeCard("Water supply off tomorrow"),
                        noticeCard("Parking rules updated"),
                        noticeCard("Maintenance due reminder"),
                      ],
                    ),
                  ),
                  sectionTitle("Quick Info"),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: infoCard(
                            "Maintenance",
                            "₹2500 Due",
                            Colors.orange,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: infoCard("Visitors", "2 Today", Colors.teal),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notices",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget statCard(String title, String value, Color color) {
    return Container(
      width: 100,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(title, style: TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }

  Widget quickButton(IconData icon, String title) {
    return GestureDetector(
      onTap: () {
        if (title == "Notices") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => Notice()),
          );
        }

        if (title == "Complaint") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ProblemScreen()),
          );
        }
        if (title == "visitors") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => VisitorsScreen()),
          );
        }
      },
      child: Container(
        width: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.indigo),
            SizedBox(height: 5),
            Text(title, style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget eventCard(String title, String date, Color color, Map eventData) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => EventDetailsPage(event: eventData)),
        );
      },
      child: Container(
        width: 160,
        margin: EdgeInsets.only(left: 16),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(colors: [color, color.withOpacity(0.6)]),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              color: Colors.black12,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize:25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              date,
              style: TextStyle(color: Colors.white70, fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }

  Widget noticeCard(String text) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.notifications, color: Colors.indigo),
          SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget infoCard(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(title, style: TextStyle(color: color)),
          SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
