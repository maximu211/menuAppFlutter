import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/models/models.dart';
import 'package:menuapp/pages/common_components/user_card.dart';

class SubsListPage extends StatefulWidget {
  const SubsListPage({super.key, required this.isSubscribersPage});

  final bool isSubscribersPage;

  @override
  State<SubsListPage> createState() => _SubsListPageState();
}

class _SubsListPageState extends State<SubsListPage> {
  late BinaryFileReader binaryFileReader;
  late Uint8List binaryData;
  late Future<List<UserModel>> usersList;

  @override
  void initState() {
    super.initState();
    widget.isSubscribersPage == true
        ? usersList = loadData1()
        : usersList = loadData2();
  }

  Future<List<UserModel>> loadData1() async {
    var data = await rootBundle.load('assets/images/recipe_images/1.jpg');
    setState(() => binaryData = data.buffer.asUint8List());
    return [
      UserModel(userName: "2", userImage: binaryData, userId: "userId"),
    ];
  }

  Future<List<UserModel>> loadData2() async {
    var data = await rootBundle.load('assets/images/recipe_images/1.jpg');
    setState(() => binaryData = data.buffer.asUint8List());
    return [
      UserModel(userName: "1", userImage: binaryData, userId: "userId"),
    ];
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
          widget.isSubscribersPage == true ? "Subscribers" : "Subscribed to",
          style: TextStyle(color: ColorVariables.backgroundColor),
        ),
      ),
      backgroundColor: ColorVariables.backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: FutureBuilder<List<UserModel>>(
            future: usersList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final user = snapshot.data![index];
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
