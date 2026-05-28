import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../services/api_service.dart';

class AttendanceReportScreen extends StatefulWidget {
  const AttendanceReportScreen({super.key});

  @override
  State<AttendanceReportScreen> createState() => _AttendanceReportScreenState();
}

class _AttendanceReportScreenState extends State<AttendanceReportScreen> {
  static const Color primaryGreen = Color(0xFF8CC63F);
  static const Color bgGreen = Color(0xFF0B1408);

  Map<String, dynamic>? reportData;
  bool isLoading = true;
  String? errorMsg;
  final now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadReport();
  }

  Future<void> _loadReport() async {
    setState(() { isLoading = true; errorMsg = null; });
    try {
      final data = await ApiService.getAttendanceReport(now.month, now.year);
      setState(() {
        reportData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMsg = e.toString().replaceAll('Exception: ', '');
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentMonth = DateFormat("MMM yyyy").format(now);
    final today = now.day;

    final stats = reportData?['stats'] ?? {};
    final attRate = stats['attendance_rate'] ?? "--";
    final avgCheckIn = stats['avg_check_in'] ?? "--";
    final daysAbsent = stats['days_absent'] ?? "--";
    final leaveDays = stats['leave_days'] ?? "--";
    final days = reportData?['days'] ?? [];

    return Scaffold(
      backgroundColor: bgGreen,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// TOP BAR
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    "Attendance Report",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                ],
              ),

              SizedBox(height: 20.h),

              if (isLoading)
                const Center(child: CircularProgressIndicator(color: primaryGreen))
              else if (errorMsg != null)
                Center(
                    child: Column(
                        children: [
                          Text(errorMsg!, style: const TextStyle(color: Colors.redAccent)),
                          TextButton(onPressed: _loadReport, child: const Text("Retry")),
                        ]
                    )
                )
              else ...[
                  /// CALENDAR
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.05),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Column(
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Personal Calendar",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              currentMonth,
                              style: const TextStyle(color: Colors.white54),
                            ),
                          ],
                        ),

                        SizedBox(height: 20.h),

                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
                          itemCount: DateTime(now.year, now.month + 1, 0).day,
                          itemBuilder: (context, index) {

                            int day = index + 1;

                            String status = 'none';
                            if (days is List) {
                              for(var d in days) {
                                if (d['day'] == day || (d['date'] != null && d['date'].toString().endsWith('-${day.toString().padLeft(2, '0')}'))) {
                                  status = d['status'] ?? 'none';
                                  break;
                                }
                              }
                            }

                            Color bgCol = Colors.transparent;
                            Color txtCol = Colors.white;
                            if (status == 'present') {
                              bgCol = Colors.green.withOpacity(0.3);
                              txtCol = Colors.green;
                            } else if (status == 'absent') {
                              bgCol = Colors.red.withOpacity(0.3);
                              txtCol = Colors.red;
                            } else if (status == 'leave') {
                              bgCol = Colors.orange.withOpacity(0.3);
                              txtCol = Colors.orange;
                            } else {
                              if (day == today && days.isEmpty) { // preserve old UI if data empty
                                bgCol = primaryGreen.withOpacity(.30);
                                txtCol = primaryGreen;
                              }
                            }

                            return Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: bgCol,
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(8.w),
                                child: Text(
                                  "$day",
                                  style: TextStyle(
                                    color: txtCol,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        SizedBox(height: 10.h),

                        const Text(
                          "Present • Absent • Leave",
                          style: TextStyle(color: Colors.white54),
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  /// STATS
                  Row(
                    children: [
                      Expanded(child: statCard(attRate.toString(), "Attendance Rate")),
                      SizedBox(width: 10.w),
                      Expanded(child: statCard(avgCheckIn.toString(), "Avg Check-In")),
                    ],
                  ),

                  SizedBox(height: 10.h),

                  Row(
                    children: [
                      Expanded(child: statCard(daysAbsent.toString(), "Days Absent")),
                      SizedBox(width: 10.w),
                      Expanded(child: statCard(leaveDays.toString(), "Leave Days")),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  /// GRAPH
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.05),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Text("Performance Trends", style: TextStyle(color: Colors.white)),

                        SizedBox(height: 20.h),

                        SizedBox(
                          height: 150.h,
                          child: CustomPaint(
                            painter: GraphPainter(),
                            child: Container(),
                          ),
                        ),

                        SizedBox(height: 10.h),

                        const Text("No Data Available", style: TextStyle(color: Colors.grey))
                      ],
                    ),
                  ),
                ],
            ],
          ),
        ),
      ),
    );
  }

  Widget statCard(String value, String label) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.05),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.h),
          Text(label, style: const TextStyle(color: Colors.white54)),
        ],
      ),
    );
  }
}

/// GRAPH PAINTER
class GraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.greenAccent
      ..strokeWidth = 3.w
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * .7);
    path.lineTo(size.width * .2, size.height * .6);
    path.lineTo(size.width * .4, size.height * .65);
    path.lineTo(size.width * .6, size.height * .5);
    path.lineTo(size.width * .8, size.height * .55);
    path.lineTo(size.width, size.height * .5);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}