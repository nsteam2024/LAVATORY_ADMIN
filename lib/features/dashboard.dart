import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
              FutureBuilder(
                future: Supabase.instance.client.from('hubs').select().count(),
                builder: (context, snapshot) {
                  int? count = snapshot.data?.count ?? 0;

                  return _buildStatCard(
                      'Laundry Hubs', '$count', Icons.store_outlined);
                },
              ),
              FutureBuilder(
                future:
                    Supabase.instance.client.from('customers').select().count(),
                builder: (context, snapshot) {
                  int? count = snapshot.data?.count ?? 0;

                  return _buildStatCard(
                      'Total Users', '$count', Icons.people_outlined);
                },
              ),
              FutureBuilder(
                future:
                    Supabase.instance.client.from('reports').select().count(),
                builder: (context, snapshot) {
                  int? count = snapshot.data?.count ?? 0;

                  return _buildStatCard(
                    'Current Reports',
                    '$count',
                    Icons.description_outlined,
                  );
                },
              ),
              FutureBuilder(
                future:
                    Supabase.instance.client.from('feedbacks').select().count(),
                builder: (context, snapshot) {
                  int? count = snapshot.data?.count ?? 0;

                  return _buildStatCard(
                      'Feedbacks', '$count', Icons.comment_outlined);
                },
              ),
            ],
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
