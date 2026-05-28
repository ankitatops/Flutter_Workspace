import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // ─── BASE URL ─────────────────────────────────────────────────────────────
  // Development mate: 'http://10.0.2.2:8000'  (Android emulator)
  // Real device mate:  'http://192.168.x.x:8000'  (same WiFi)
  // Production mate:   'https://yourserver.com'
  static const String baseUrl = 'http://194.36.85.234';

  // ─── TOKEN KEYS ───────────────────────────────────────────────────────────
  static const String _accessKey = 'access_token';
  static const String _refreshKey = 'refresh_token';

  // ─────────────────────────────────────────────────────────────────────────
  //  TOKEN HELPERS
  // ─────────────────────────────────────────────────────────────────────────

  /// Access token SharedPreferences ma thi lavvo
  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessKey);
  }

  /// Tokens save karo (login pachhi call karo)
  static Future<void> saveTokens(String access, String refresh) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessKey, access);
    await prefs.setString(_refreshKey, refresh);
  }

  /// Tokens delete karo (logout pachhi)
  static Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessKey);
    await prefs.remove(_refreshKey);
  }

  /// Standard headers — darak authenticated request mate
  static Future<Map<String, String>> _authHeaders() async {
    final token = await getAccessToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // ─────────────────────────────────────────────────────────────────────────
  //  TOKEN REFRESH
  // ─────────────────────────────────────────────────────────────────────────

  /// 401 aave to refresh token thi navo access token lo
  /// Return: true = success, false = refresh pan expire thayo (re-login joie)
  static Future<bool> refreshAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refresh = prefs.getString(_refreshKey);
    if (refresh == null) return false;

    final res = await http.post(
      Uri.parse('$baseUrl/api/mobile/auth/refresh/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refresh': refresh}),
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      await prefs.setString(_accessKey, data['access']);
      return true;
    }
    return false;
  }

  // ─────────────────────────────────────────────────────────────────────────
  //  1. AUTH
  // ─────────────────────────────────────────────────────────────────────────

  /// Login — access + refresh token male
  /// Return: {'access': '...', 'refresh': '...'} or throws exception
  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    final res = await http.post(
      Uri.parse('$baseUrl/api/mobile/auth/login/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    final data = jsonDecode(res.body);

    if (res.statusCode == 200) {
      // Token automatically save karo
      await saveTokens(data['access'], data['refresh']);
      return data;
    }

    // Error — message throw karo
    throw Exception(
      data['detail'] ?? data['non_field_errors']?[0] ?? 'Login failed',
    );
  }

  /// Logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final refresh = prefs.getString(_refreshKey);
    final headers = await _authHeaders();

    await http.post(
      Uri.parse('$baseUrl/api/mobile/auth/logout/'),
      headers: headers,
      body: jsonEncode({'refresh': refresh ?? ''}),
    );

    await clearTokens();
  }

  // ─────────────────────────────────────────────────────────────────────────
  //  2. PROFILE
  // ─────────────────────────────────────────────────────────────────────────

  /// Profile data lavo
  static Future<Map<String, dynamic>> getProfile() async {
    return await _getRequest('/api/mobile/profile/');
  }

  /// Profile update karo
  static Future<Map<String, dynamic>> updateProfile({
    String? fullName,
    String? phone,
  }) async {
    final body = <String, dynamic>{};
    if (fullName != null) body['full_name'] = fullName;
    if (phone != null) body['phone'] = phone;

    return await _patchRequest('/api/mobile/profile/', body);
  }

  /// FCM Token save karo (push notifications mate)
  static Future<void> saveFcmToken(String fcmToken) async {
    await _postRequest('/api/mobile/profile/fcm-token/', {
      'fcm_token': fcmToken,
    });
  }

  // ─────────────────────────────────────────────────────────────────────────
  //  3. CALENDAR
  // ─────────────────────────────────────────────────────────────────────────

  static Future<Map<String, dynamic>> getCalendar(int month, int year) async {
    return await _getRequest('/api/mobile/calendar/?month=$month&year=$year');
  }

  // ─────────────────────────────────────────────────────────────────────────
  //  4. ATTENDANCE
  // ─────────────────────────────────────────────────────────────────────────

  static Future<Map<String, dynamic>> getAttendanceHistory(
    int month,
    int year,
  ) async {
    return await _getRequest(
      '/api/mobile/attendance/history/?month=$month&year=$year',
    );
  }

  static Future<Map<String, dynamic>> getAttendanceReport(
    int month,
    int year,
  ) async {
    return await _getRequest(
      '/api/mobile/attendance/report/?month=$month&year=$year',
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  //  5. ANALYTICS
  // ─────────────────────────────────────────────────────────────────────────

  static Future<Map<String, dynamic>> getAnalytics({int months = 5}) async {
    return await _getRequest('/api/mobile/analytics/?months=$months');
  }

  // ─────────────────────────────────────────────────────────────────────────
  //  6. EXPORT
  // ─────────────────────────────────────────────────────────────────────────

  /// CSV file bytes return kare — file save karvani app ma
  static Future<http.Response> exportCsv(int month, int year) async {
    final headers = await _authHeaders();
    return await http.get(
      Uri.parse('$baseUrl/api/mobile/export/csv/?month=$month&year=$year'),
      headers: headers,
    );
  }

  static Future<http.Response> exportPdf(int month, int year) async {
    final headers = await _authHeaders();
    return await http.get(
      Uri.parse('$baseUrl/api/mobile/export/pdf/?month=$month&year=$year'),
      headers: headers,
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  //  7. NOTIFICATIONS
  // ─────────────────────────────────────────────────────────────────────────

  /// filter: 'all' | 'unread' | 'attendance' | 'system'
  static Future<Map<String, dynamic>> getNotifications({
    String filter = 'all',
  }) async {
    return await _getRequest('/api/mobile/notifications/?filter=$filter');
  }

  static Future<Map<String, dynamic>> getUnreadCount() async {
    return await _getRequest('/api/mobile/notifications/unread-count/');
  }

  static Future<void> markAllRead() async {
    await _postRequest('/api/mobile/notifications/mark-read/', {});
  }

  static Future<void> markSpecificRead(List<String> notificationIds) async {
    await _postRequest('/api/mobile/notifications/mark-read/', {
      'notification_ids': notificationIds,
    });
  }

  // ─────────────────────────────────────────────────────────────────────────
  //  8. LEAVE REQUESTS (Educational orgs only)
  // ─────────────────────────────────────────────────────────────────────────

  static Future<Map<String, dynamic>> getLeaveRequests() async {
    return await _getRequest('/api/mobile/leave-requests/');
  }

  static Future<Map<String, dynamic>> submitLeaveRequest({
    required String reason,
    required String description,
    required String startDate,
    required String endDate,
    File? certificateFile,
  }) async {
    final token = await getAccessToken();
    final headers = {
      if (token != null) 'Authorization': 'Bearer $token',
    };

    // File hoy to multipart request, nahi to normal JSON
    if (certificateFile != null) {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/api/mobile/leave-requests/'),
      );
      request.headers.addAll(headers);
      request.fields['reason'] = reason;
      request.fields['description'] = description;
      request.fields['start_date'] = startDate;
      request.fields['end_date'] = endDate;
      request.files.add(
        await http.MultipartFile.fromPath('certificate', certificateFile.path),
      );
      final streamed = await request.send();
      final res = await http.Response.fromStream(streamed);
      return _parseResponse(res);
    } else {
      return await _postRequest('/api/mobile/leave-requests/', {
        'reason': reason,
        'description': description,
        'start_date': startDate,
        'end_date': endDate,
      });
    }
  }

  static Future<Map<String, dynamic>> getLeaveDetail(String leaveId) async {
    return await _getRequest('/api/mobile/leave-requests/$leaveId/');
  }

  static Future<void> withdrawLeaveRequest(String leaveId) async {
    final headers = await _authHeaders();
    final res = await http.delete(
      Uri.parse('$baseUrl/api/mobile/leave-requests/$leaveId/'),
      headers: headers,
    );
    _handleStatus(res);
  }

  // ─────────────────────────────────────────────────────────────────────────
  //  PRIVATE HELPERS
  // ─────────────────────────────────────────────────────────────────────────

  static Future<Map<String, dynamic>> _getRequest(String path) async {
    final headers = await _authHeaders();
    final res = await http.get(Uri.parse('$baseUrl$path'), headers: headers);
    return _parseResponse(res);
  }

  static Future<Map<String, dynamic>> _postRequest(
    String path,
    Map<String, dynamic> body,
  ) async {
    final headers = await _authHeaders();
    final res = await http.post(
      Uri.parse('$baseUrl$path'),
      headers: headers,
      body: jsonEncode(body),
    );
    return _parseResponse(res);
  }

  static Future<Map<String, dynamic>> _patchRequest(
    String path,
    Map<String, dynamic> body,
  ) async {
    final headers = await _authHeaders();
    final res = await http.patch(
      Uri.parse('$baseUrl$path'),
      headers: headers,
      body: jsonEncode(body),
    );
    return _parseResponse(res);
  }

  /// Response parse karo + error handle karo
  static Map<String, dynamic> _parseResponse(http.Response res) {
    _handleStatus(res);
    if (res.body.isEmpty) return {};
    return jsonDecode(res.body) as Map<String, dynamic>;
  }

  static void _handleStatus(http.Response res) {
    if (res.statusCode >= 200 && res.statusCode < 300) return;

    Map<String, dynamic> body = {};
    try {
      body = jsonDecode(res.body);
    } catch (_) {}

    switch (res.statusCode) {
      case 400:
        throw Exception(
          body['detail'] ?? body.values.first?.toString() ?? 'Validation error',
        );
      case 401:
        throw Exception('Token expire thayo — please re-login karo');
      case 403:
        throw Exception(body['detail'] ?? 'Permission denied (403). Backend returned no detail.');
      case 404:
        throw Exception('Data found nathi');
      default:
        throw Exception('Server error: ${res.statusCode}');
    }
  }
}
