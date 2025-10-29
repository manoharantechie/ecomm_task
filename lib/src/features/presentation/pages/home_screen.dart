import 'package:e_comm/src/core/utills/const_value.dart';
import 'package:e_comm/src/core/theme/custom_theme.dart';
import 'package:e_comm/src/features/presentation/pages/dash_screen.dart';
import 'package:e_comm/src/features/presentation/profile/profile_screen.dart';
import 'package:e_comm/src/features/presentation/widgets/bottom_bar/bar_with_indicator_theme_data.dart';
import 'package:e_comm/src/features/presentation/widgets/bottom_bar/bottom_bar_with_indicator.dart';
import 'package:e_comm/src/features/presentation/widgets/carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int curIndex = 0;

  bool isAuth = false;
  final PageStorageBucket bucket = PageStorageBucket();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget screen = Container();

  @override
  Widget build(BuildContext context) {
    List<Widget> bottomPage = [DashScreen(), ProfileScreen()];
    screen = bottomPage[curIndex];

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: CustomTheme.of(context).primaryColorDark,

        appBar: AppBar(
          backgroundColor: CustomTheme.of(context).primaryColorDark,
          elevation: 0,
          leading: Image.asset('assets/icons/logo.png'),
          actions: [
            IconButton(
              icon: Icon(Icons.chat_bubble_outline),
              color: Colors.black,
              onPressed: () {
                // Handle chat icon tap
              },
            ),
            IconButton(
              icon: Icon(Icons.notifications_none),
              color: Colors.black,
              onPressed: () {
                // Handle notification icon tap
              },
            ),
          ],
        ),

        body: PageStorage(bucket: bucket, child: screen),

        bottomNavigationBar: Container(
          color: CustomTheme.of(context).primaryColorDark,

          child: BottomBarWithIndicator(
            selectedIndex: curIndex,

            onIndexChanged: (index) {
              setState(() {
                curIndex = index;
                // onSelectItem(index);
              });
            },
            themeData: BarWithIndicatorThemeData(
              backgroundColor: CustomTheme.of(context).primaryColorDark,
              activeColor: Colors.red,
              inactiveColor: const Color(0xFFB1B8C2),
              floating: false,
            ),
            items: const <BottomBarWithIndicatorItem>[
              BottomBarWithIndicatorItem(
                icon: "assets/icons/home.svg",
                label: 'Home',
                activeIcon: "assets/icons/home.svg",
              ),
              BottomBarWithIndicatorItem(
                icon: "assets/icons/account.svg",
                label: 'Profile',
                activeIcon: "assets/icons/account.svg",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
