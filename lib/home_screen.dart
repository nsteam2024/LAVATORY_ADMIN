import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
              width: 300,
              color: Colors.lightGreenAccent,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(children: [
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'LAVATORY',
                    style: TextStyle(fontSize: 25),
                  ),
                  SizedBox(height: 25),
                  DrawerItem(
                    isActive: _tabController.index == 0,
                    iconData: Icons.dashboard,
                    label: 'Dashbaord',
                    onTap: () {
                      _tabController.animateTo(0);
                    },
                  ),
                  DrawerItem(
                    isActive: _tabController.index == 1,
                    iconData: Icons.local_laundry_service,
                    label: 'laundry hubs',
                    onTap: () {
                      _tabController.animateTo(1);
                    },
                  ),
                  DrawerItem(
                    isActive: _tabController.index == 2,
                    iconData: Icons.people,
                    label: 'users',
                    onTap: () {
                      _tabController.animateTo(2);
                    },
                  ),
                ]),
              )),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Dashboard(),
                Container(
                  color: Colors.blue,
                ),
                Container(
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  const Dashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('DASHBOARD',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 30,
          ),
          Container(
            decoration: ShapeDecoration(
                color: Colors.amber,
                shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1),
                    borderRadius: BorderRadius.circular(16.0))),
            height: 200,
            width: 200,
            child: Column(children: [
              Icon(Icons.local_laundry_service),
            ]),
          )
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final IconData iconData;
  final String label;
  final Function() onTap;
  final bool isActive;
  const DrawerItem({
    super.key,
    required this.iconData,
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isActive ? Colors.red : Colors.blue,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(iconData),
              Text(label.toUpperCase(), style: TextStyle(color: Colors.black))
            ],
          ),
        ),
      ),
    );
  }
}
