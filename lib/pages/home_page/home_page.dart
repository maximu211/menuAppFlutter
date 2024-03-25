
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/pages/home_page/card/card.dart';
import 'package:menuapp/models/models.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late BinaryFileReader binaryFileReader;
  late Uint8List binaryData;
  late Future<List<CardReceiptModel>> cardReceiptsFuture;

  @override
  void initState() {
    super.initState();
    cardReceiptsFuture = loadData();
  }

  Future<List<CardReceiptModel>> loadData() async {
    var data = await rootBundle.load('assets/images/dish_images/1.jpg');
    setState(() => binaryData = data.buffer.asUint8List());
    return [
      CardReceiptModel(
        user: UserModel(
          userName: "John_Lennon",
          userPhoto: binaryData,
        ),
        cookDifficulty: CookingDifficulty.medium,
        cookTime: CookingTime.hour1,
        cookType: "Drink",
        dishName: 'Cocktail "Cool guy"',
        dishPhoto: binaryData,
        isDishSaved: true,
        savedCount: 140,
        isDishLiked: false,
        receiptId: '21',
        userId: '12',
      ),
      CardReceiptModel(
        user: UserModel(
          userName: "John_Lennon",
          userPhoto: binaryData,
        ),
        cookDifficulty: CookingDifficulty.medium,
        cookTime: CookingTime.hour1,
        cookType: "Drink",
        dishName: 'Cocktail "Cool guy"',
        dishPhoto: binaryData,
        isDishSaved: true,
        savedCount: 140,
        isDishLiked: false,
        receiptId: '21',
        userId: '12',
      ),
      CardReceiptModel(
        user: UserModel(
          userName: "John_Lennon",
          userPhoto: binaryData,
        ),
        cookDifficulty: CookingDifficulty.medium,
        cookTime: CookingTime.hour1,
        cookType: "Drink",
        dishName: 'Cocktail "Cool guy"',
        dishPhoto: binaryData,
        isDishSaved: true,
        savedCount: 140,
        isDishLiked: false,
        receiptId: '21',
        userId: '12',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: ColorVariables.primaryColor),
          floating: true,
          pinned: false,
          snap: true,
          automaticallyImplyLeading: false,
          backgroundColor: ColorVariables.primaryColor,
          shadowColor: Colors.black,
          leading: Image.asset(
            "assets/images/logo.png",
            color: ColorVariables.backgroundColor,
          ),
          title: Text(
            'Cool App Name',
            style: TextStyle(
              color: ColorVariables.backgroundColor,
              fontSize: FontSizeVariables.h1Size,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: FutureBuilder<List<CardReceiptModel>>(
              future: cardReceiptsFuture,
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
                      final cardReceipt = snapshot.data![index];
                      return Column(
                        children: [
                          MainPageCard(cardReceipt: cardReceipt),
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
      ],
    );
  }
}
