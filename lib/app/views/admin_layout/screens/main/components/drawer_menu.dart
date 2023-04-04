import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:iismee/api/auth.dart';
import 'package:iismee/api/user.dart';
import 'package:iismee/app/routes/app_pages.dart';
import 'package:iismee/app/views/admin_layout/constants.dart';
import 'package:iismee/app/views/admin_layout/controllers/MenuController.dart'
    as navMenu;
import 'package:iismee/app/views/admin_layout/responsive.dart';
import 'package:iismee/app/views/admin_layout/screens/main/components/side_menu.dart';
import 'package:iismee/app/views/components/colors.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  List<DrawerListTile> drawerItems = [];

  List<Widget> header = [
    Logo(),
    // Text('IISMEE', style: TextStyle(color: Colors.white, fontSize: 24)),
  ];

  placePages() {
    List<GetPage> pages = context.read<navMenu.MenuController>().pages;
    List<DrawerListTile> listItem = [];
    print(pages.length);
    for (int i = 0; i < pages.length; i++) {
      listItem.add(DrawerListTile(
        title: !pages[i].name.contains('-')
            ? pages[i].name.substring(1).capitalizeFirst.toString()
            : "${pages[i].name.substring(1).split('-')[0].capitalizeFirst} ${pages[i].name.substring(1).split('-')[1].capitalizeFirst}",
        svgSrc: "assets/icons/${pages[i].title}.svg",
        press: () {
          // Get.to(pages[i].page);
          Get.toNamed(pages[i].name);
          print('Go to ${pages[i].name} page');
          context.read<navMenu.MenuController>().selectedDrawerItem = i;
          setState(() {});
        },
        isSelected: false,
      ));
    }

    setState(() {
      drawerItems = listItem;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    placePages();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.05,
      ),
      ...header,
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.15,
      ),
      Expanded(
        child: ListView.builder(
            itemCount: drawerItems.length,
            itemBuilder: (context, index) {
              final item = drawerItems[index];
              return DrawerListTile(
                  title: item.title,
                  svgSrc: item.svgSrc,
                  press: item.press,
                  isSelected: context
                          .read<navMenu.MenuController>()
                          .selectedDrawerItem ==
                      index);
            }),
      ),
    ]);
  }
}

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width *
            (Responsive.isDesktop(context) ? 0.15 : 0.4),
        height: MediaQuery.of(context).size.height *
            (Responsive.isDesktop(context) ? 0.25 : 0.3),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: primaryBackgroundColor,
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              'assets/logo-unesa.png',
              width: 100,
              height: 100,
            ),
            Text('IISMEE',
                style:
                    TextStyle(color: Colors.blueGrey.shade600, fontSize: 24)),
          ],
        ));
  }
}

class DrawerListTile extends StatelessWidget {
  DrawerListTile(
      {Key? key,
      // For selecting those three line once press "Command+D"
      required this.title,
      required this.svgSrc,
      required this.press,
      required this.isSelected})
      : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        color: isSelected ? Color.fromARGB(252, 242, 242, 255) : Colors.blue,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
      ),
      child: ListTile(
        selectedColor: Color.fromARGB(252, 242, 242, 255),
        minVerticalPadding: MediaQuery.of(context).size.height * 0.01,
        tileColor:
            isSelected ? Color.fromARGB(252, 242, 242, 255) : Colors.blue,
        onTap: press,
        horizontalTitleGap: 0.0,
        leading: SvgPicture.asset(
          svgSrc,
          color: isSelected
              ? Colors.blueGrey.shade600
              : Color.fromARGB(252, 242, 242, 255),
          height: 16,
        ),
        title: Text(
          title,
          style: TextStyle(
              color: isSelected
                  ? Colors.blueGrey.shade600
                  : Color.fromARGB(252, 242, 242, 255)),
        ),
      ),
    );
  }
}

class ProfileCard extends StatefulWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUserData();
  }

  void setUserData() async {
    Map<String, dynamic> data = UserApi.storage.read('userData');
    setState(() {
      userData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      margin: EdgeInsets.only(left: 15),
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: primaryBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: primaryBackgroundColor),
      ),
      child: userData == null
          ? Center(child: CircularProgressIndicator())
          : Row(
              children: [
                Image.asset(
                  "assets/images/profile_pic.png",
                  height: 38,
                ),
                if (!Responsive.isMobile(context))
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding / 2),
                    child: Text(
                      userData!['name'],
                      style: TextStyle(color: Colors.blueGrey.shade800),
                    ),
                  ),
                IconButton(
                  onPressed: () {
                    Authenticator.signOut();
                  },
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.blueGrey.shade800,
                  ),
                ),
              ],
            ),
    );
  }
}
