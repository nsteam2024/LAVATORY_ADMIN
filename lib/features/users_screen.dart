import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String joinDate;
  final int bookingsCount;
  final bool isActive;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.joinDate,
    required this.bookingsCount,
    required this.isActive,
  });
}

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final List<UserModel> _users = [];

  String _searchQuery = "";
  String _filterOption = "All";

  List<UserModel> get filteredUsers {
    return _users.where((user) {
      // Apply search filter
      final matchesSearch =
          user.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              user.email.toLowerCase().contains(_searchQuery.toLowerCase());

      // Apply status filter
      bool matchesFilter = true;
      if (_filterOption == "Active") {
        matchesFilter = user.isActive;
      } else if (_filterOption == "Inactive") {
        matchesFilter = !user.isActive;
      }

      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  void initState() {
    Supabase.instance.client
        .from('customers')
        .select('*, laundry_orders(*)')
        .then((response) {
      final data = response;
      final users = data.map((user) {
        return UserModel(
          id: user['id'].toString(),
          name: user['name'].toString(),
          email: user['email'].toString(),
          phone: user['phone'].toString(),
          joinDate: user['created_at'].toString(),
          bookingsCount: user['laundry_orders']?.length ?? 0,
          isActive: user['is_active'] as bool,
        );
      }).toList();

      setState(() {
        _users.clear();
        _users.addAll(users);
      });
    }).onError((e, s) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error fetching users: ${e!.toString()}")));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // _buildHeader(),
          _buildSearchAndFilters(),
          Expanded(
            child: _buildUsersList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddUserDialog();
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }

  // Widget _buildHeader() {
  //   return Container(
  //     padding: const EdgeInsets.all(16),
  //     color: Colors.white,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         const Text(
  //           "Users",
  //           style: TextStyle(
  //             fontSize: 24,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         Row(
  //           children: [
  //             _buildStatCard("Total Users", "4000", Colors.blue[50]!),
  //             const SizedBox(width: 16),
  //             _buildStatCard("Active Today", "270", Colors.green[50]!),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildStatCard(String title, String value, Color bgColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Search users by name or email",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _filterOption,
                  isExpanded: true,
                  hint: const Text("Filter"),
                  items: const [
                    DropdownMenuItem(value: "All", child: Text("All Users")),
                    DropdownMenuItem(value: "Active", child: Text("Active")),
                    DropdownMenuItem(
                        value: "Inactive", child: Text("Inactive")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _filterOption = value!;
                    });
                  },
                ),
              ),
            ),
          ),
          // const SizedBox(width: 16),
          // ElevatedButton.icon(
          //   onPressed: () {
          //     _showExportDialog();
          //   },
          //   icon: const Icon(Icons.download),
          //   label: const Text("Export"),
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Colors.blue,
          //     foregroundColor: Colors.white,
          //     padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildUsersList() {
    return Container(
      color: Colors.grey[100],
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Row(
                children: const [
                  Expanded(
                      flex: 1,
                      child: Text("ID",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      flex: 2,
                      child: Text("Name",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      flex: 2,
                      child: Text("Email",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      flex: 2,
                      child: Text("Phone",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      flex: 1,
                      child: Text("Joined",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      flex: 1,
                      child: Text("Bookings",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      flex: 1,
                      child: Text("Status",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      flex: 1,
                      child: Text("Actions",
                          style: TextStyle(fontWeight: FontWeight.bold))),
                ],
              ),
            ),
            const Divider(height: 1, thickness: 1),
            Expanded(
              child: ListView.separated(
                itemCount: filteredUsers.length,
                separatorBuilder: (context, index) =>
                    const Divider(height: 1, thickness: 1),
                itemBuilder: (context, index) {
                  final user = filteredUsers[index];
                  return Container(
                    color: index % 2 == 0 ? Colors.white : Colors.grey[50],
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(flex: 1, child: Text(user.id)),
                        Expanded(flex: 2, child: Text(user.name)),
                        Expanded(flex: 2, child: Text(user.email)),
                        Expanded(flex: 2, child: Text(user.phone)),
                        Expanded(flex: 1, child: Text(user.joinDate)),
                        Expanded(
                            flex: 1,
                            child: Text(user.bookingsCount.toString())),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: user.isActive
                                  ? Colors.green[50]
                                  : Colors.red[50],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              user.isActive ? "Active" : "Inactive",
                              style: TextStyle(
                                color: user.isActive
                                    ? Colors.green[800]
                                    : Colors.red[800],
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, size: 18),
                                color: Colors.blue,
                                onPressed: () {
                                  _showEditUserDialog(user);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, size: 18),
                                color: Colors.red,
                                onPressed: () {
                                  _showDeleteConfirmation(user);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      "Showing ${filteredUsers.length} of ${_users.length} users"),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, size: 18),
                        onPressed: () {},
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          "1",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios, size: 18),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddUserDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add New User"),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: "Phone",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Would add user to list here in a real implementation
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("User added successfully!")));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            child: const Text("Add User"),
          ),
        ],
      ),
    );
  }

  void _showEditUserDialog(UserModel user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit User"),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: user.name),
                decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: TextEditingController(text: user.email),
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: TextEditingController(text: user.phone),
                decoration: InputDecoration(
                  labelText: "Phone",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text("Status: "),
                  const SizedBox(width: 8),
                  Switch(
                    value: user.isActive,
                    onChanged: (value) {},
                    activeColor: Colors.blue,
                  ),
                  Text(user.isActive ? "Active" : "Inactive"),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("User updated successfully!")));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            child: const Text("Save Changes"),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(UserModel user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete User"),
        content: Text("Are you sure you want to delete ${user.name}?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("User deleted successfully!")));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  void _showExportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Export Users"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Select export format:"),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Exporting users as CSV...")));
                    },
                    icon: const Icon(Icons.description),
                    label: const Text("CSV"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Exporting users as PDF...")));
                    },
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text("PDF"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Exporting users as Excel...")));
                    },
                    icon: const Icon(Icons.table_chart),
                    label: const Text("Excel"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Add this to main.dart or your app's router
class LavatoryApp extends StatelessWidget {
  const LavatoryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lavatory',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.blue[700]),
        ),
      ),
      home: const LavatoryScaffold(),
    );
  }
}

class LavatoryScaffold extends StatefulWidget {
  const LavatoryScaffold({Key? key}) : super(key: key);

  @override
  State<LavatoryScaffold> createState() => _LavatoryScaffoldState();
}

class _LavatoryScaffoldState extends State<LavatoryScaffold> {
  int _selectedIndex = 2; // Users page

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.local_laundry_service, color: Colors.blue[600]),
            const SizedBox(width: 8),
            Text(
              "Lavatory",
              style: TextStyle(
                color: Colors.blue[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          const CircleAvatar(
            backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
            radius: 16,
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard),
                label: Text("Dashboard"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.store),
                label: Text("Laundry Hubs"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.people),
                label: Text("Users"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.attach_money),
                label: Text("Revenue"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.bar_chart),
                label: Text("Reports"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.feedback),
                label: Text("Feedbacks"),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // This is where the selected page content goes
          Expanded(
            child: _selectedIndex == 2
                ? const UsersPage()
                : Center(child: Text("Selected page: $_selectedIndex")),
          ),
        ],
      ),
    );
  }
}
