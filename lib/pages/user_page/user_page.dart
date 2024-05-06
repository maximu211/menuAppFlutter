import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/dialog_utils.dart';
import 'package:menuapp/http/auth/user_requests.dart';
import 'package:menuapp/utils/secure_storage.dart';

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
        children: [
          Center(
              child: ElevatedButton(
                  onPressed: () {
                    DialogUtils.showLeavePageDialog(
                        context: context,
                        title: "Log out",
                        description: "Do you realy want to log out?",
                        okFunc: () async {
                          String? accessToken = await SecureStorage()
                              .storage
                              .read(key: "AccessToken");
                          if (accessToken != null) {
                            UserRequest.logOut().then((result) {
                              if (result.success) {
                                Navigator.popAndPushNamed(
                                    context, "/logInPage");
                                SecureStorage().storage.deleteAll();
                              }
                            });
                          } else {
                            //Navigator.popAndPushNamed(context, "/logInPage");
                          }
                        },
                        cancelFunc: () {
                          Navigator.pop(context);
                        });
                  },
                  child: const Text("Log Out"))),
          const Center(child: Text('Tab 2 Content')),
        ],
      ),
    );
  }
}
