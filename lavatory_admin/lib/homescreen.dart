import 'package:flutter/material.dart';
import 'package:lavatory_admin/laundryhubs.dart';
import 'package:lavatory_admin/reportscreen.dart';
import 'package:lavatory_admin/users_screen.dart';

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
    "Revenue",
    "Reports",
    "Feedbacks",
  ];

  final List<Widget> _screens = [
    DashboardScreen(),
    LaundryHubsScreen(),
    UsersPage(),
    CenterScreen(title: "Reports"),
    ReportsScreen(),
    CenterScreen(title: "Feedbacks"),
  ];

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
                _buildNavItem(3, Icons.attach_money_outlined, 'Revenue'),
                _buildNavItem(4, Icons.insert_chart_outlined, 'Reports'),
                _buildNavItem(5, Icons.comment_outlined, 'Feedbacks'),
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

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats cards
          GridView.count(
            crossAxisCount: 4,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              _buildStatCard('Laundry Hubs', '40', Icons.store_outlined),
              _buildStatCard('Total Users', '4000', Icons.people_outlined),
              _buildStatCard(
                'Current Reports',
                '10',
                Icons.description_outlined,
              ),
              _buildStatCard('Feedbacks', '270', Icons.comment_outlined),
            ],
          ),

          SizedBox(height: 24),

          // Charts row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Revenue chart
              Expanded(
                flex: 3,
                child: Container(
                  height: 300,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Revenue',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Expanded(
                        child: Image.network(
                          'https://cdn.pixabay.com/photo/2023/01/04/03/24/bar-chart-7694897_1280.jpg',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(width: 16),

              // Updates chart
              Expanded(
                flex: 2,
                child: Container(
                  height: 300,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Updates',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Expanded(
                        child: Image.network(
                          'https://cdn.pixabay.com/photo/2018/01/12/16/15/graph-3078545_1280.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      Row(
                        children: [
                          _buildLegendItem('Pending', Colors.indigo),
                          SizedBox(width: 16),
                          _buildLegendItem('Process', Colors.yellow),
                          SizedBox(width: 16),
                          _buildLegendItem('Finished', Colors.red),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 24),

          // Recent activities
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recent Activities',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://ui-avatars.com/api/?name=User${index + 1}&background=0D8ABC&color=fff',
                        ),
                      ),
                      title: Text('User ${index + 1} completed laundry'),
                      subtitle: Text('2 hours ago'),
                      trailing: Icon(Icons.more_vert),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: Colors.blue),
              Text(
                title,
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
          ),
          Spacer(),
          Text(
            value,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          TextButton(
            onPressed: () {},
            child: Text('Manage'),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              alignment: Alignment.centerLeft,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
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
