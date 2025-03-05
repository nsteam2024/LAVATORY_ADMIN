import 'package:flutter/material.dart';
import 'package:lavatory_admin/features/laundry_hubs/add_edit_hub_dialog.dart';

class LaundryHubsScreen extends StatefulWidget {
  @override
  _LaundryHubsScreenState createState() => _LaundryHubsScreenState();
}

class _LaundryHubsScreenState extends State<LaundryHubsScreen> {
  bool _isGridView = true;
  String _searchQuery = '';
  String _filterValue = 'All';

  final List<Map<String, dynamic>> _hubs = [
    {
      'id': 1,
      'name': 'Downtown Laundry Center',
      'address': '123 Main St, Downtown',
      'status': 'Active',
      'machines': 8,
      'rating': 4.8,
      'imageUrl':
          'https://images.unsplash.com/photo-1604335399105-a0c585fd81a1?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    },
    {
      'id': 2,
      'name': 'Westside Wash House',
      'address': '456 Elm St, Westside',
      'status': 'Active',
      'machines': 12,
      'rating': 4.5,
      'imageUrl':
          'https://images.unsplash.com/photo-1545173168-9f1947eebb7f?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    },
    {
      'id': 3,
      'name': 'North Campus Laundromat',
      'address': '789 University Ave, Northside',
      'status': 'Maintenance',
      'machines': 10,
      'rating': 4.2,
      'imageUrl':
          'https://images.unsplash.com/photo-1567113463300-102a7eb3cb26?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    },
    {
      'id': 4,
      'name': 'Eastside Express Laundry',
      'address': '321 Oak St, Eastside',
      'status': 'Active',
      'machines': 15,
      'rating': 4.7,
      'imageUrl':
          'https://images.unsplash.com/photo-1521656693074-0ef32e80a5d5?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    },
    {
      'id': 5,
      'name': 'Southpoint Laundry Services',
      'address': '555 Pine St, Southside',
      'status': 'Inactive',
      'machines': 6,
      'rating': 3.9,
      'imageUrl':
          'https://images.unsplash.com/photo-1527515545081-5db817172677?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    },
    {
      'id': 6,
      'name': 'Central Square Laundry',
      'address': '777 Center Ave, Midtown',
      'status': 'Active',
      'machines': 20,
      'rating': 4.9,
      'imageUrl':
          'https://images.unsplash.com/photo-1594631776887-b8ad5a0836d5?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    },
  ];

  List<Map<String, dynamic>> get filteredHubs {
    return _hubs.where((hub) {
      final matchesSearch =
          hub['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
              hub['address'].toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesFilter =
          _filterValue == 'All' || hub['status'] == _filterValue;

      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header section
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Laundry Hubs',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.add),
                  label: Text('Add New Hub'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AddEditHubDialog(),
                    );
                  },
                ),
              ],
            ),
          ),

          // Filter and search section
          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: TextField(
          //           decoration: InputDecoration(
          //             hintText: 'Search hubs...',
          //             prefixIcon: Icon(Icons.search),
          //             border: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(8),
          //             ),
          //             contentPadding: EdgeInsets.symmetric(vertical: 0),
          //             filled: true,
          //             fillColor: Colors.white,
          //           ),
          //           onChanged: (value) {
          //             setState(() {
          //               _searchQuery = value;
          //             });
          //           },
          //         ),
          //       ),
          //       SizedBox(width: 16),
          //       Container(
          //         padding: EdgeInsets.symmetric(horizontal: 12),
          //         decoration: BoxDecoration(
          //           color: Colors.white,
          //           borderRadius: BorderRadius.circular(8),
          //           border: Border.all(color: Colors.grey.shade300),
          //         ),
          //         child: DropdownButtonHideUnderline(
          //           child: DropdownButton<String>(
          //             value: _filterValue,
          //             items: <String>[
          //               'All',
          //               'Active',
          //               'Inactive',
          //             ].map<DropdownMenuItem<String>>((String value) {
          //               return DropdownMenuItem<String>(
          //                 value: value,
          //                 child: Text(value),
          //               );
          //             }).toList(),
          //             onChanged: (newValue) {
          //               setState(() {
          //                 _filterValue = newValue!;
          //               });
          //             },
          //             hint: Text('Status'),
          //           ),
          //         ),
          //       ),
          //       SizedBox(width: 16),
          //       Container(
          //         decoration: BoxDecoration(
          //           color: Colors.white,
          //           borderRadius: BorderRadius.circular(8),
          //           border: Border.all(color: Colors.grey.shade300),
          //         ),
          //         child: Row(
          //           children: [
          //             IconButton(
          //               icon: Icon(Icons.grid_view),
          //               color: _isGridView ? Colors.blue : Colors.grey,
          //               onPressed: () {
          //                 setState(() {
          //                   _isGridView = true;
          //                 });
          //               },
          //             ),
          //             IconButton(
          //               icon: Icon(Icons.list),
          //               color: !_isGridView ? Colors.blue : Colors.grey,
          //               onPressed: () {
          //                 setState(() {
          //                   _isGridView = false;
          //                 });
          //               },
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          // Stats summary
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                _buildStatCard('Total Hubs', '${_hubs.length}', Colors.blue),
                SizedBox(width: 16),
                _buildStatCard(
                  'Active Hubs',
                  '${_hubs.where((hub) => hub['status'] == 'Active').length}',
                  Colors.green,
                ),
                SizedBox(width: 16),
                _buildStatCard(
                  'Maintenance',
                  '${_hubs.where((hub) => hub['status'] == 'Maintenance').length}',
                  Colors.orange,
                ),
                SizedBox(width: 16),
                _buildStatCard(
                  'Inactive',
                  '${_hubs.where((hub) => hub['status'] == 'Inactive').length}',
                  Colors.red,
                ),
              ],
            ),
          ),

          // Hub list/grid
          Expanded(child: _buildGridView()),
          // Expanded(child: _isGridView ? _buildGridView() : _buildListView()),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Expanded(
      child: Container(
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
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  value,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridView() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 2 / 1.2,
        ),
        itemCount: filteredHubs.length,
        itemBuilder: (context, index) {
          final hub = filteredHubs[index];
          return _buildGridCard(hub);
        },
      ),
    );
  }

  // Widget _buildListView() {
  //   return ListView.builder(
  //     padding: EdgeInsets.all(16),
  //     itemCount: filteredHubs.length,
  //     itemBuilder: (context, index) {
  //       final hub = filteredHubs[index];
  //       return _buildListCard(hub);
  //     },
  //   );
  // }

  Widget _buildGridCard(Map<String, dynamic> hub) {
    return Container(
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
          // Image section
          Container(
            height: 120,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Image.network(
                hub['imageUrl'],
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(
                      Icons.local_laundry_service,
                      size: 50,
                      color: Colors.grey[400],
                    ),
                  );
                },
              ),
            ),
          ),

          // Status tag
          // Container(
          //   margin: EdgeInsets.only(left: 16, top: 16),
          //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          //   decoration: BoxDecoration(
          //     color: hub['status'] == 'Active'
          //         ? Colors.green
          //         : hub['status'] == 'Maintenance'
          //             ? Colors.orange
          //             : Colors.red,
          //     borderRadius: BorderRadius.circular(4),
          //   ),
          //   child: Text(
          //     hub['status'],
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontSize: 12,
          //       fontWeight: FontWeight.w500,
          //     ),
          //   ),
          // ),

          // Content
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hub['name'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  hub['address'],
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.local_laundry_service,
                      size: 16,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '${hub['machines']} Machines',
                      style: TextStyle(fontSize: 12),
                    ),
                    Spacer(),
                    Icon(Icons.star, size: 16, color: Colors.amber),
                    SizedBox(width: 4),
                    Text('${hub['rating']}', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),

          Spacer(),

          // Actions
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    // View details
                  },
                  child: Text('Details'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    side: BorderSide(color: Colors.blue),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                    minimumSize: Size(0, 30),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {
                    _showHubOptions(context, hub);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListCard(Map<String, dynamic> hub) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
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
      child: Row(
        children: [
          // Image
          Container(
            width: 120,
            height: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              child: Image.network(
                hub['imageUrl'],
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(
                      Icons.local_laundry_service,
                      size: 50,
                      color: Colors.grey[400],
                    ),
                  );
                },
              ),
            ),
          ),

          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        hub['name'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: hub['status'] == 'Active'
                              ? Colors.green
                              : hub['status'] == 'Maintenance'
                                  ? Colors.orange
                                  : Colors.red,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          hub['status'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    hub['address'],
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.local_laundry_service,
                        size: 16,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '${hub['machines']} Machines',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(width: 16),
                      Icon(Icons.star, size: 16, color: Colors.amber),
                      SizedBox(width: 4),
                      Text('${hub['rating']}', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Actions
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                OutlinedButton(
                  onPressed: () {
                    // View details
                  },
                  child: Text('Details'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    side: BorderSide(color: Colors.blue),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
                SizedBox(height: 8),
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {
                    _showHubOptions(context, hub);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showHubOptions(BuildContext context, Map<String, dynamic> hub) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('Manage ${hub['name']}'),
        children: [
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              // Edit hub logic
            },
            child: Row(
              children: [
                Icon(Icons.edit, color: Colors.blue),
                SizedBox(width: 8),
                Text('Edit Details'),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              // View machines logic
            },
            child: Row(
              children: [
                Icon(Icons.local_laundry_service, color: Colors.green),
                SizedBox(width: 8),
                Text('View Machines'),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              // Change status logic
            },
            child: Row(
              children: [
                Icon(Icons.sync_alt, color: Colors.orange),
                SizedBox(width: 8),
                Text('Change Status'),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              // Delete hub logic
            },
            child: Row(
              children: [
                Icon(Icons.delete, color: Colors.red),
                SizedBox(width: 8),
                Text('Delete Hub'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
