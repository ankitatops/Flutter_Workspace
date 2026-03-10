import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Notice/notice_screen.dart';
import '../Problem/problem_screen.dart';
import '../Staff/staff_screen.dart';
import '../adminlogin/adminlogin.dart';
import '../event/event_screen.dart';
import '../maintenance/maintenance_screen.dart';
import '../screen/Feedback_Screen.dart';
import '../screen/Settings_Screen.dart';
import '../visitors/visitors_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List users = [];
  bool isLoading = true;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  Future<void> loadUsers() async {
    try {
      var response = await http.get(
        Uri.parse("https://prakrutitech.xyz/ankita/get_all_users.php"),
      );

      var data = jsonDecode(response.body);

      if (data["status"] == "success") {
        setState(() {
          users = data["data"];
          isLoading = false;
        });
      } else {
        setState(() {
          users = [];
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteUser(String id) async {
    await http.post(
      Uri.parse("https://prakrutitech.xyz/ankita/delete_user.php"),
      body: {"id": id},
    );

    loadUsers();
  }

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  Widget dashboardCard(
    String title,
    IconData icon,
    Color color,
    Widget screen,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Container(
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: Colors.white),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dashboardUI() {
    return Container(
      decoration: BoxDecoration(color: Colors.grey.shade200),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Builder(
                    builder: (context) => IconButton(
                      icon: Icon(Icons.menu, color: Colors.black),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),
                  Text(
                    "Admin Dashboard",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, color: Colors.blue),
                  ),
                ],
              ),

              SizedBox(height: 30),

              Text(
                "Quick Actions",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 15),

              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                  dashboardCard(
                    "Maintenance",
                    Icons.build,
                    Colors.orange,
                    MaintenanceScreen(),
                  ),
                  dashboardCard(
                    "Events",
                    Icons.event,
                    Colors.purple,
                    EventsPage(),
                  ),
                  dashboardCard("Notice", Icons.campaign, Colors.red, Notice()),
                  dashboardCard("Staff", Icons.people, Colors.green, staff()),
                ],
              ),

              SizedBox(height: 30),

              Text(
                "All Users",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 15),

              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : users.isEmpty
                  ? Text("No Users Found")
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        var user = users[index];

                        return Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Text(
                                (user["name"] ?? "U")[0],
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(user["name"] ?? ""),
                            subtitle: Text(user["email"] ?? ""),
                            trailing: IconButton(
                              icon: Icon(Icons.more_vert),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            user["name"] ?? "",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text("Phone : ${user["phone"]}"),
                                          Text("Flat No : ${user["flat_no"]}"),
                                          SizedBox(height: 20),
                                          ElevatedButton.icon(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              deleteUser(user["id"].toString());
                                            },
                                            icon: Icon(Icons.delete),
                                            label: Text("Delete"),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyContent;

    if (_selectedIndex == 0) {
      bodyContent = dashboardUI();
    } else if (_selectedIndex == 1) {
      bodyContent = VisitorsScreen();
    } else if (_selectedIndex == 2) {
      bodyContent = FeedbackScreen();
    } else {
      bodyContent = SettingsScreen();
    }

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 40),
              color: Colors.blue,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 35, color: Colors.blue),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Admin Panel",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text("Dashboard"),
              onTap: () {
                Navigator.pop(context);
                setState(() => _selectedIndex = 0);
              },
            ),
            ListTile(
              leading: Icon(Icons.report_problem_outlined),
              title: Text("Problems"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProblemScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout"),
              onTap: () async {
                SharedPreferences preference =
                    await SharedPreferences.getInstance();
                await preference.setBool("admin", false);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => AdminLoginApp()),
                );
              },
            ),
          ],
        ),
      ),

      body: bodyContent,

      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
          BottomNavigationBarItem(
            icon: Icon(Icons.co_present),
            label: "Visitors",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feedback),
            label: "Feedback",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
