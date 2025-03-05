import 'package:flutter/material.dart';
import 'package:lavatory_admin/features/dashboard.dart';
import 'package:lavatory_admin/features/feedbackscreen.dart';
import 'package:lavatory_admin/features/laundry_hubs/laundryhubs.dart';
import 'package:lavatory_admin/features/login/login_screen.dart';
import 'package:lavatory_admin/features/reportscreen.dart';
import 'package:lavatory_admin/features/users_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  runApp(LaundryAdminApp());
}

class LaundryAdminApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lavatory Admin Panel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _currentTitle = "Dashboard";

  final List<String> _titles = [
    "Dashboard",
    "Laundry Hubs",
    "Users",
    "Reports",
    "Feedbacks",
  ];

  final List<Widget> _screens = [
    DashboardScreen(),
    LaundryHubsScreen(),
    UsersPage(),
    ReportsScreen(),
    FeedbacksScreen(),
  ];

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (Supabase.instance.client.auth.currentUser == null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false,
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Side navigation drawer
          NavigationDrawer(
            selectedIndex: _selectedIndex,
            onItemSelected: (index) {
              setState(() {
                _selectedIndex = index;
                _currentTitle = _titles[index];
              });
            },
          ),
          // Main content area
          Expanded(
            child: Column(
              children: [
                // App bar
                Container(
                  height: 60,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _currentTitle,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.notifications_outlined),
                            onPressed: () {
                              // Notification logic
                            },
                          ),
                          SizedBox(width: 10),
                          CircleAvatar(
                            radius: 16,
                            backgroundImage: NetworkImage(
                              'https://ui-avatars.com/api/?name=Admin&background=0D8ABC&color=fff',
                            ),
                          ),
                          SizedBox(width: 10),
                          PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'logout') {
                                // Handle logout
                              }
                            },
                            itemBuilder: (BuildContext context) {
                              return {'Profile', 'Settings', 'Logout'}.map((
                                String choice,
                              ) {
                                return PopupMenuItem<String>(
                                  value: choice.toLowerCase(),
                                  child: Text(choice),
                                );
                              }).toList();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Main content
                Expanded(child: _screens[_selectedIndex]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  NavigationDrawer({required this.selectedIndex, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      color: Colors.white,
      child: Column(
        children: [
          // Branding
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: Text(
              'Lavatory',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          Divider(height: 1),

          // Navigation items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildNavItem(0, Icons.dashboard_outlined, 'Dashboard'),
                _buildNavItem(1, Icons.store_outlined, 'Laundry Hubs'),
                _buildNavItem(2, Icons.people_outlined, 'Users'),
                // _buildNavItem(3, Icons.attach_money_outlined, 'Revenue'),
                _buildNavItem(3, Icons.warning, 'Reports'),
                _buildNavItem(4, Icons.comment_outlined, 'Feedbacks'),
              ],
            ),
          ),

          // Log out button
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Log out', style: TextStyle(fontSize: 16)),
              onTap: () {
                // Handle logout
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String title) {
    final isSelected = selectedIndex == index;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
      ),
      child: ListTile(
        leading: Icon(icon, color: isSelected ? Colors.blue : Colors.grey[600]),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.grey[800],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: () => onItemSelected(index),
      ),
    );
  }
}

class CenterScreen extends StatelessWidget {
  final String title;

  CenterScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.construction, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            '$title Screen',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'This screen is under construction',
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
