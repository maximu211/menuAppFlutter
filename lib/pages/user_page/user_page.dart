import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menuapp/global_variables/color_variables.dart';
import 'package:menuapp/global_variables/font_size_variables.dart';
import 'package:menuapp/global_variables/icon_size_variables.dart';
import 'package:menuapp/http/DTOs/dtos.dart';
import 'package:menuapp/http/subscription_requests/subscription_requests.dart';
import 'package:menuapp/http/user_requests/user_requests.dart';
import 'package:menuapp/pages/authorization/log_in_page/log_in_page.dart';
import 'package:menuapp/pages/common_components/image_picker/photo_button.dart';
import 'package:menuapp/pages/common_components/toggle_icon_button.dart';
import 'package:menuapp/pages/home_page/card/card.dart';
import 'package:menuapp/pages/user_page/saved_recipe_page.dart';
import 'package:menuapp/pages/user_page/subs_list_page.dart';
import 'package:menuapp/utils/secure_storage.dart';

class UserPage extends StatefulWidget {
  const UserPage(
      {Key? key, required this.userId, this.isOpenedFromNavBar = true})
      : super(key: key);

  final bool isOpenedFromNavBar;
  final String userId;

  @override
  State<StatefulWidget> createState() {
    return _UserPageState();
  }
}

class _UserPageState extends State<UserPage> {
  late Future<UserPageDataDto> _userPageDataFuture;

  @override
  void initState() {
    super.initState();
    _userPageDataFuture = _loadUserPageData();
  }

  Future<UserPageDataDto> _loadUserPageData() async {
    return await UserRequest.getUserPageData(widget.userId);
  }

  Future<void> refreshData() async {
    setState(() {
      _userPageDataFuture = _loadUserPageData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserPageDataDto>(
      future: _userPageDataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text('Помилка завантаження даних: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          UserPageDataDto userPageData = snapshot.data!;
          return RefreshIndicator(
            onRefresh: refreshData,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: ColorVariables.primaryColor),
                  floating: true,
                  pinned: false,
                  snap: true,
                  leading: !widget.isOpenedFromNavBar
                      ? IconButton(
                          icon: const Icon(Icons.arrow_back),
                          color: ColorVariables.backgroundColor,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      : const SizedBox(),
                  automaticallyImplyLeading: false,
                  backgroundColor: ColorVariables.primaryColor,
                  shadowColor: Colors.black,
                  title: userPageData.isOwner
                      ? GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              backgroundColor: ColorVariables.primaryColor,
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      BottomModalButton(
                                        icon: Icons.person,
                                        onPressed: () {
                                          print("object");
                                        },
                                        buttonText: "Update profile",
                                      ),
                                      BottomModalButton(
                                        icon: Icons.bookmark_rounded,
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SavedRecipesPage(
                                                userId: widget.userId,
                                              ),
                                            ),
                                          );
                                        },
                                        buttonText: "Gallery",
                                      ),
                                      BottomModalButton(
                                        icon: Icons.exit_to_app,
                                        onPressed: () {
                                          UserRequest.logOut();
                                          SecureStorage().storage.deleteAll();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginPage(),
                                            ),
                                          );
                                        },
                                        buttonText: "Log out",
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                userPageData.user.userName,
                                style: TextStyle(
                                  color: ColorVariables.backgroundColor,
                                  fontSize: FontSizeVariables.h1Size,
                                ),
                              ),
                              Icon(
                                Icons.arrow_drop_down_sharp,
                                size: IconSizeVariables.bigSize,
                                color: ColorVariables.backgroundColor,
                              )
                            ],
                          ),
                        )
                      : Text(
                          userPageData.user.userName,
                          style:
                              TextStyle(color: ColorVariables.backgroundColor),
                        ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ColorVariables.primaryColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(color: Colors.black, blurRadius: 5)
                          ],
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipOval(
                                          child: userPageData.user.userImage !=
                                                  null
                                              ? Image.memory(
                                                  userPageData.user.userImage!,
                                                  fit: BoxFit.cover,
                                                  width: 75,
                                                  height: 75,
                                                )
                                              : Icon(
                                                  Icons.person,
                                                  size: 50,
                                                  color: ColorVariables
                                                      .backgroundColor,
                                                ),
                                        ),
                                        Text(
                                          userPageData.user.userName,
                                          softWrap: true,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            color:
                                                ColorVariables.backgroundColor,
                                            fontSize: FontSizeVariables.h1Size,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Posts ${userPageData.recipes.length}",
                                          style: TextStyle(
                                            color:
                                                ColorVariables.backgroundColor,
                                            fontSize: FontSizeVariables.h1Size,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SubsListPage(
                                                  userId: widget.userId,
                                                  isSubscribersPage: true,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            "Subscribers ${userPageData.subscribedUsersCount}",
                                            style: TextStyle(
                                              color: ColorVariables
                                                  .backgroundColor,
                                              fontSize:
                                                  FontSizeVariables.h1Size,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SubsListPage(
                                                  userId: widget.userId,
                                                  isSubscribersPage: false,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            "Subscribed to ${userPageData.subscribedToCount}",
                                            style: TextStyle(
                                              color: ColorVariables
                                                  .backgroundColor,
                                              fontSize:
                                                  FontSizeVariables.h1Size,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              !userPageData.isOwner
                                  ? ElevatedToggleButton(
                                      buttonToggledText: "Unsubscribe",
                                      buttonUntoggledText: "Subscribe",
                                      isButtonToggled:
                                          userPageData.isSubscribed,
                                      onTap: (newState) async {
                                        if (newState) {
                                          userPageData.isSubscribed = newState;
                                          await SubscriptionRequests
                                              .subscribeTo(
                                                  userPageData.user.userId);
                                          setState(() {
                                            userPageData.subscribedUsersCount++;
                                          });
                                        } else {
                                          await SubscriptionRequests
                                              .unsubscribeFrom(
                                                  userPageData.user.userId);
                                          setState(() {
                                            userPageData.subscribedUsersCount--;
                                          });
                                        }
                                      },
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: ListView.builder(
                          itemCount: userPageData.recipes.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final item = userPageData.recipes[index];
                            return Column(
                              children: [
                                MainPageCard(
                                  cardRecipe: item,
                                  onDeleteCallBack: () {
                                    setState(() {
                                      userPageData.recipes.remove(item);
                                    });
                                  },
                                ),
                                const SizedBox(height: 20)
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        } else {
          return const Center(child: Text('Не вдалося завантажити дані'));
        }
      },
    );
  }
}
