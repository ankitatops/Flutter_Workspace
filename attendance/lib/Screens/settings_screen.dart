import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../services/api_service.dart';
import 'login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Map<String, dynamic>? profileData;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final data = await ApiService.getProfile();
      setState(() => profileData = data);
    } catch (_) {}
  }

  bool attendanceAlert=true;
  bool scanReminder=false;
  bool faceConsent=true;

  static const bg=Color(0xFF0B1408);
  static const card=Color(0xFF111D0D);
  static const green=Color(0xFF8CC63F);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: bg,

      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Settings",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(18.w),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            /// PROFILE CARD
            Container(
              padding: EdgeInsets.all(18.w),
              decoration: BoxDecoration(
                color: card,
                borderRadius:
                BorderRadius.circular(22.r),
              ),
              child: Row(
                children: [

                  Container(
                    height:60.w,
                    width:60.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: green,
                        width:2.w,
                      ),
                      color: Colors.black26,
                    ),
                    child: Icon(
                      Icons.person,
                      color: Colors.white38,
                      size:30.sp,
                    ),
                  ),

                  SizedBox(width:15.w),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        Text(
                          profileData?['full_name'] ?? "User",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:20.sp,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        SizedBox(height:6.h),

                        Text(
                          profileData?['email'] ?? "ID: ----",
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize:13.sp,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding:
                    EdgeInsets.symmetric(
                      horizontal:16.w,
                      vertical:8.h,
                    ),
                    decoration: BoxDecoration(
                      color: green.withOpacity(.18),
                      borderRadius:
                      BorderRadius.circular(30.r),
                    ),
                    child: const Text(
                      "Verified",
                      style: TextStyle(
                        color: green,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),

            SizedBox(height:30.h),

            /// NOTIFICATIONS
            Text(
              "NOTIFICATIONS",
              style: TextStyle(
                color: green,
                letterSpacing:2.w,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height:14.h),

            sectionCard(
              children: [

                switchTile(
                  Icons.calendar_month,
                  "Attendance Alerts",
                  "Notify when attendance is logged",
                  attendanceAlert,
                      (v){
                    setState(() {
                      attendanceAlert=v;
                    });
                  },
                ),

                divider(),

                switchTile(
                  Icons.camera_alt_outlined,
                  "Scan Reminders",
                  "Periodic reminders to scan device",
                  scanReminder,
                      (v){
                    setState(() {
                      scanReminder=v;
                    });
                  },
                ),

              ],
            ),

            SizedBox(height:28.h),

            /// PRIVACY
            Text(
              "PRIVACY & SECURITY",
              style: TextStyle(
                color: green,
                letterSpacing:2.w,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height:14.h),

            sectionCard(
              children: [

                switchTile(
                  Icons.visibility_outlined,
                  "Face Data Consent",
                  "Use biometric data verification",
                  faceConsent,
                      (v){
                    setState(() {
                      faceConsent=v;
                    });
                  },
                ),

                divider(),

                arrowTile(
                  Icons.storage,
                  "Data Retention",
                  "View how your data is stored",
                ),

                divider(),

                arrowTile(
                  Icons.privacy_tip_outlined,
                  "Privacy Policy",
                  "",
                ),

                SizedBox(height:15.h),

                Container(
                  padding:
                  EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius:
                    BorderRadius.circular(14.r),
                  ),
                  child: Row(
                    children: [

                      const Icon(
                        Icons.info_outline,
                        color: Colors.white54,
                      ),

                      SizedBox(width:10.w),

                      Expanded(
                        child: Text(
                          "We retain biometric hash data for up to 90 days following your last login.",
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize:12.sp,
                          ),
                        ),
                      )
                    ],
                  ),
                )

              ],
            ),

            SizedBox(height:28.h),

            /// ACCOUNT
            Text(
              "ACCOUNT MANAGEMENT",
              style: TextStyle(
                color: green,
                letterSpacing:2.w,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height:14.h),

            sectionCard(
              children: [

                arrowTile(
                  Icons.lock_outline,
                  "Change Password",
                  "Update security credentials",
                ),

                divider(),

                arrowTile(
                  Icons.phone_android,
                  "Manage Devices",
                  "View 2 active sessions",
                ),

              ],
            ),

            SizedBox(height:35.h),

            /// SIGN OUT
            GestureDetector(
              onTap: () async {
                try {
                  await ApiService.logout();
                  if (!mounted) return;
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString().replaceAll('Exception: ', ''))));
                }
              },
              child: Container(
                height:58.h,
                width:double.infinity,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius:
                  BorderRadius.circular(18.r),
                ),
                child: Center(
                  child: Text(
                    "Sign Out of Account",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize:17.sp,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height:25.h),

            const Center(
              child: Text(
                "Version 2.4.0 (Build 992)",
                style: TextStyle(
                  color: Colors.white30,
                ),
              ),
            ),

            SizedBox(height:25.h),
          ],
        ),
      ),
    );
  }

  Widget sectionCard({
    required List<Widget> children,
  }){
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: card,
        borderRadius:
        BorderRadius.circular(22.r),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget divider(){
    return Divider(
      color: Colors.white12,
      height:25.h,
    );
  }

  Widget iconBox(IconData icon){
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: green.withOpacity(.15),
        borderRadius:
        BorderRadius.circular(14.r),
      ),
      child: Icon(
        icon,
        color: green,
      ),
    );
  }

  Widget switchTile(
      IconData icon,
      String title,
      String sub,
      bool value,
      Function(bool) onChanged){
    return Row(
      children: [

        iconBox(icon),

        SizedBox(width:14.w),

        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize:16.sp,
                    fontWeight:
                    FontWeight.w600),
              ),
              Text(
                sub,
                style: TextStyle(
                    color: Colors.white54,
                    fontSize:12.sp),
              )
            ],
          ),
        ),

        Switch(
          value:value,
          activeColor: green,
          onChanged:onChanged,
        )
      ],
    );
  }

  Widget arrowTile(
      IconData icon,
      String title,
      String sub){
    return Row(
      children: [

        iconBox(icon),

        SizedBox(width:14.w),

        Expanded(
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize:16.sp,
                    fontWeight:
                    FontWeight.w600),
              ),
              if(sub.isNotEmpty)
                Text(
                  sub,
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize:12.sp,
                  ),
                ),
            ],
          ),
        ),

        const Icon(
          Icons.chevron_right,
          color: Colors.white54,
        )
      ],
    );
  }
}
