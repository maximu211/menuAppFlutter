import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  final bool isCurrentUser;

  const UserPage({Key? key, required this.isCurrentUser}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _UserPageState();
  }
}

class _UserPageState extends State<UserPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Page'),
        bottom: widget.isCurrentUser
            ? TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Tab 1'),
                  Tab(text: 'Tab 2'),
                ],
              )
            : null,
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          // Content for Tab 1
          Center(child: Text('Tab 1 Content')),
          // Content for Tab 2
          Center(child: Text('Tab 2 Content')),
        ],
      ),
    );
  }
}
