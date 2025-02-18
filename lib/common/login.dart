import 'package:flutter/material.dart';
import 'package:my_app/main.dart';
import 'package:my_app/models/role_credentials.dart';
import 'package:my_app/models/role_credentials_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _togglePassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _selectedRole;


  void _showLanguageSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('English'),
                onTap: () {
                  _selectLanguage('English');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Spanish'),
                onTap: () {
                  _selectLanguage('Spanish');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('French'),
                onTap: () {
                  _selectLanguage('French');
                  Navigator.pop(context);
                },
              ),
              // Add more languages as needed
            ],
          ),
        );
      },
    );
  }

  void _selectLanguage(String language) {
    setState(() {
    });
  }

  Future<void> _handleLogin() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    String? role;
    
    // Searching for the role in the RoleCredentialsData
    for (var credential in RoleCredentialsData.roleCredentials) {
      if (credential.email == email && credential.password == password) {
        role = credential.role;
        break;
      }
    }

    if (role != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_role', role); // Store user role in local storage

    String route = '';

    switch (role) {
      case 'Super Admin':
        route = '/super_admin_dashboard';
        break;
      case 'Admin':
        route = '/admin_dashboard';
        break;
      case 'Teacher':
        route = '/teacher_dashboard';
        break;
      case 'Accountant':
        route = '/accountant_dashboard';
        break;
      case 'Receptionist':
        route = '/receptionist_dashboard';
        break;
      case 'Librarian':
        route = '/librarian_dashboard';
        break;
      case 'Parent':
        route = '/parent_dashboard';
        break;
      case 'Student':
        route = '/student_dashboard';
        break;
      case 'Security Guard':
        route = '/security_dashboard';
        break;
    }

      Navigator.pushReplacementNamed(context, route);
    } else {
      // Show error if credentials are invalid
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid email or password')),
      );
    }
  }

  void _fillCredentials(String? role) {
    if (role != null) {
      var selectedCredential = RoleCredentialsData.roleCredentials
          .firstWhere((r) => r.role == role, orElse: () => RoleCredentials(role: '', email: '', password: ''));

      setState(() {
        _emailController.text = selectedCredential.email;
        _passwordController.text = selectedCredential.password;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Image.asset(
              'assets/logo.png',
              width: 100,
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedRole,
              hint: Text('Select Role'),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.security),
              ),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedRole = newValue;
                  _fillCredentials(newValue);
                });
              },
              /* items: roleCredentials.keys.map<DropdownMenuItem<String>>((String role) {
                return DropdownMenuItem<String>(
                  value: role,
                  child: Text(role),
                );
              }).toList(), */
              items: RoleCredentialsData.roleCredentials
                  .map<DropdownMenuItem<String>>((RoleCredentials role) {
                return DropdownMenuItem<String>(
                  value: role.role,
                  child: Text(role.role),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                prefixIcon: Icon(Icons.person_2),
                hintText: 'Username',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: _togglePassword, // Toggle password visibility
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                prefixIcon: Icon(Icons.lock_open),
                hintText: 'Password',
                filled: true,
                fillColor: Colors.white,
                suffixIcon: IconButton(
                  icon: Icon(
                    _togglePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _togglePassword = !_togglePassword;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    print('Forget Password tapped');
                  },
                  child: Row(
                    children: [
                      Icon(Icons.key, color: Colors.white),
                      SizedBox(width: 4),
                      Text(
                        'Forget Password?',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, size: 20, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: _showLanguageSheet,
                  icon: Icon(Icons.language, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
