import 'package:flutter/material.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/http/DTOs/dtos.dart';
import 'package:menuapp/http/subscription_requests/subscription_requests.dart';

import 'package:menuapp/pages/common_components/user_card.dart';

class SubsListPage extends StatefulWidget {
  const SubsListPage(
      {Key? key, required this.isSubscribersPage, required this.userId})
      : super(key: key);

  final bool isSubscribersPage;
  final String userId;

  @override
  State<SubsListPage> createState() => _SubsListPageState();
}

class _SubsListPageState extends State<SubsListPage> {
  late Future<UserDto> usersList;

  Future<UserDto> _loadSubscribersUsers() async {
    return await SubscriptionRequests.getSubscribers(widget.userId);
  }

  Future<UserDto> _loadSubscribedUsers() async {
    return await SubscriptionRequests.getSubsribedUsers(widget.userId);
  }

  @override
  void initState() {
    super.initState();
    widget.isSubscribersPage
        ? usersList = _loadSubscribersUsers()
        : usersList = _loadSubscribedUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: ColorVariables.backgroundColor,
        ),
        backgroundColor: ColorVariables.primaryColor,
        title: Text(
          widget.isSubscribersPage ? "Subscribers" : "Subscribed to",
          style: TextStyle(color: ColorVariables.backgroundColor),
        ),
      ),
      backgroundColor: ColorVariables.backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: FutureBuilder<UserDto>(
            future: usersList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.data!.usersList.isEmpty) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorVariables.primaryColor,
                    boxShadow: const [
                      BoxShadow(color: Colors.black, blurRadius: 2)
                    ],
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    textAlign: TextAlign.center,
                    widget.isSubscribersPage
                        ? "No one has subscribed to this user yet 😢"
                        : "this user has not subscribed to anyone yet 😢",
                    style: TextStyle(
                      color: ColorVariables.backgroundColor,
                      fontSize: FontSizeVariables.h2Size,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.usersList.length,
                  itemBuilder: (context, index) {
                    final user = snapshot.data!.usersList[index];
                    return Column(
                      children: [
                        UserCard(userModel: user),
                        const SizedBox(height: 20),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
