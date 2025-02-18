import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/common/login.dart';
import 'package:my_app/screens/accountant/dashboard.dart';
import 'package:my_app/screens/admin/dashboard.dart';
import 'package:my_app/screens/librarian/dashboard.dart';
import 'package:my_app/screens/parent/dashboard.dart';
import 'package:my_app/screens/receptionist/dashboard.dart';
import 'package:my_app/screens/securityguard/dashboard.dart';
import 'package:my_app/screens/student/dashboard.dart';
import 'package:my_app/screens/superadmin/dashboard.dart';
import 'package:my_app/screens/teacher/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userRole = prefs.getString('user_role');

  runApp(MyApp(userRole: userRole));
}

class MyApp extends StatelessWidget {
  final String? userRole;

  const MyApp({super.key, this.userRole});

  Widget _getHomeScreen() {
    if (userRole == null) return Login();

    switch (userRole) {
      case 'Super Admin':
        return SuperAdminDashboard();
      case 'Admin':
        return AdminDashboard();
      case 'Teacher':
        return TeacherDashboard();
      case 'Accountant':
        return AccountantDashboard();
      case 'Receptionist':
        return ReceptionistDashboard();
      case 'Librarian':
        return LibrarianDashboard();
      case 'Parent':
        return ParentDashboard();
      case 'Student':
        return StudentsDashboard();
      case 'Security Guard':
        return SecurityGuardDashboard();
      default:
        return Login(); // Fallback to login if role is unknown
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: _getHomeScreen(),
      routes: {
        '/accountant_dashboard': (context) => AccountantDashboard(),
        '/admin_dashboard': (context) => AdminDashboard(),
        '/librarian_dashboard': (context) => LibrarianDashboard(),
        '/parent_dashboard': (context) => ParentDashboard(),
        '/receptionist_dashboard': (context) => ReceptionistDashboard(),
        '/security_dashboard': (context) => SecurityGuardDashboard(),
        '/student_dashboard': (context) => StudentsDashboard(),
        '/super_admin_dashboard': (context) => SuperAdminDashboard(),
        '/teacher_dashboard': (context) => TeacherDashboard(),
      },
    );
  }
}
