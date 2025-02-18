import 'package:flutter/material.dart';
import 'package:my_app/common/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentsDashboard extends StatefulWidget {
  const StudentsDashboard({super.key});

  @override
  State<StudentsDashboard> createState() => _StudentsDashboardState();
}

class _StudentsDashboardState extends State<StudentsDashboard> {
  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_role'); // Remove saved user role
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students Dashboard'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Welcome to the Students Dashboard!'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _logout,
              child: const Text('View Students'),
            ),
          ],
        ),
      ),
    );
  }
}