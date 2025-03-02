import 'package:flutter/material.dart';

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
