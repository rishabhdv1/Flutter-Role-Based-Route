import 'package:flutter/material.dart';
import 'package:my_app/common/dashboard_section.dart';
import 'package:my_app/common/login.dart';
import 'package:my_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class StudentsDashboard extends StatefulWidget {
  @override
  State<StudentsDashboard> createState() => _StudentsDashboardState();
}

class _StudentsDashboardState extends State<StudentsDashboard> {
  final List<Map<String, dynamic>> sections = [
    {
      'title': 'E-Learning',
      'items': [
        {'icon': Icons.book_outlined, 'text': 'HomeWork', 'route': '/homework'},
        {'icon': Icons.list_alt_outlined, 'text': 'Daily Assignment', 'route': '/daily_assignment'},
        {'icon': Icons.checklist_outlined, 'text': 'Lesson Plan', 'route': '/lesson_plan'},
        {'icon': Icons.computer_outlined, 'text': 'Online Examination', 'route': '/online_examination'},
        {'icon': Icons.download_outlined, 'text': 'Download Center', 'route': '/download_center'},
        {'icon': Icons.school_outlined, 'text': 'Online Course', 'route': '/online_courses'},
        {'icon': Icons.videocam_outlined, 'text': 'Zoom Live Classes', 'route': '/zoom'},
        {'icon': Icons.videocam_outlined, 'text': 'Gmeet Live Classes', 'route': '/gmeet'},
      ]
    },
    {
      'title': 'Academics',
      'items': [
        {'icon': Icons.schedule, 'text': 'Class Timetable', 'route': '/timetable'},
        {'icon': Icons.description_outlined, 'text': 'Syllabus Status', 'route': '/syllabus_status'},
        {'icon': Icons.check_circle_outline, 'text': 'Attendance', 'route': '/attendance_chart'},
        {'icon': Icons.assignment_outlined, 'text': 'Examinations', 'route': '/examination'},
        {'icon': Icons.timeline, 'text': 'Student Timeline', 'route': '/student_timeline'},
        {'icon': Icons.folder_outlined, 'text': 'My Documents', 'route': '/my_documents'},
        {'icon': Icons.report_outlined, 'text': 'Behaviour Records', 'route': '/behaviour_records'},
        {'icon': Icons.assignment_outlined, 'text': 'CBSE Examination', 'route': '/cbse'},
      ]
    },
    {
      'title': 'Communicate',
      'items': [
        {'icon': Icons.email_outlined, 'text': 'Notice Board', 'route': '/notice_board'},
      ]
    },
    {
      'title': 'Others',
      'items': [
        {'icon': Icons.account_balance_wallet_outlined, 'text': 'Fees', 'route': '/fee_page'},
        {'icon': Icons.event_note_outlined, 'text': 'Apply Leave', 'route': '/apply_leave'},
        {'icon': Icons.people_outline, 'text': 'Visitor Book', 'route': '/visitor_book'},
        {'icon': Icons.directions_bus_outlined, 'text': 'Transport Routes', 'route': '/transport_route'},
        {'icon': Icons.hotel_outlined, 'text': 'Hostel Rooms', 'route': '/hostel_rooms'},
        {'icon': Icons.calendar_today_outlined, 'text': 'Calendar To Do List', 'route': '/calendar_todo'},
        {'icon': Icons.local_library_outlined, 'text': 'Library', 'route': '/library'},
        {'icon': Icons.rate_review_outlined, 'text': 'Teachers Review', 'route': '/teachers_review'},
      ]
    },
  ];

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_role'); // Remove saved user role
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo2.png',
                height: 30,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Student Dashboard',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/notification');
            },
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue[50],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage('assets/avatar.jpg'),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Student 1',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Class 10 - A',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Setting'),
              onTap: () {
                Navigator.pushNamed(context, '/appSetting');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: _logout,
            ),
            const Divider(),
            const Center(
              child: Text('Version 1.0.0'),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/avatar.jpg'),
              ),
            ),
            const Text(
              'Edward Thomas',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const Text('Admission No. 18001 Class 10 (A)',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            DashboardSection(sections: sections), // Use the DashboardSection widget here
          ],
        ),
      ),
    );
  }
}
