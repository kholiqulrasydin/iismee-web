import 'package:drawerbehavior/drawerbehavior.dart' as drawerbehavior;
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iismee/app/controllers/size_controller.dart';
import 'package:iismee/app/data/constants/theme.dart';
import 'package:iismee/app/routes/app_pages.dart';

class AdminLayout extends StatefulWidget {
  const AdminLayout({super.key});

  @override
  State<AdminLayout> createState() => _AdminLayoutState();
}

class _AdminLayoutState extends State<AdminLayout> {
  drawerbehavior.Menu menu = const drawerbehavior.Menu(items: []);
  late String selectedMenuItemId;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    menu = drawerbehavior.Menu(
      items: AppPages.routes.map(
        (e) => drawerbehavior.MenuItem(
          title: e.name.substring(1).capitalizeFirst.toString(),
          id: e.name
        )
      ).toList()
    );

    selectedMenuItemId = selectedMenuItemId = menu.items[1].id;

  }

  @override
  Widget build(BuildContext context) {
    if(MediaQuery.of(context).orientation == Orientation.portrait){
      return drawerbehavior.DrawerScaffold(
      appBar: AppBar(),
      drawers: [
        drawerbehavior.SideDrawer(
          drawerWidth: 200,
          percentage: 0.8,
          menu: menu,
          direction: drawerbehavior.Direction.left,
          animation: true,
          color: Theme.of(context).primaryColor,
          selectorColor: Colors.blueGrey.shade300,
          selectedItemId: selectedMenuItemId,
          onMenuItemSelected: (itemId) {
            setState(() {
              selectedMenuItemId = itemId;
            });
            Get.toNamed(selectedMenuItemId);
          },
        )
      ],
      body: GetMaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      initialBinding: BindingsBuilder(() {

        Get.lazyPut<SizeController>(
              () => SizeController(),
        );
        // add more bindings in here

      }),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    )
    );
  }else{
    return const LandscapeAdminLayout();
  }
    }
}

class LandscapeAdminLayout extends StatefulWidget {
  const LandscapeAdminLayout({super.key});

  @override
  State<LandscapeAdminLayout> createState() => _LandscapeAdminLayoutState();
}

class _LandscapeAdminLayoutState extends State<LandscapeAdminLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: MediaQuery.of(context).size.width * 0.9,
                child: GetMaterialApp(
                  theme: lightTheme,
                  darkTheme: darkTheme,
                  themeMode: ThemeMode.system,
                  initialBinding: BindingsBuilder(() {

                    Get.lazyPut<SizeController>(
                          () => SizeController(),
                    );
                    // add more bindings in here

                  }),
                  initialRoute: AppPages.INITIAL,
                  getPages: AppPages.routes,
                )
              ),
            ),
            Positioned(
              left: 0,
              child: AnimatedContainer(
                color: Colors.blue,
                duration: const Duration(milliseconds: 500),
                height: MediaQuery.of(context).size.height,
                width: 300,
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Text('Dashboard'),
                    Text('Dashboard'),
                    Text('Dashboard'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class AdminLayout extends StatefulWidget {
//   AdminLayout({Key? key, this.mainAxisAlignment = MainAxisAlignment.start, this.crossAxisAlignment = CrossAxisAlignment.start, required this.sizeControl}) : super(key: key);

//   final MainAxisAlignment? mainAxisAlignment;
//   final CrossAxisAlignment? crossAxisAlignment;
//   final SizeController sizeControl;

//   @override
//   State<AdminLayout> createState() => _AdminLayoutState();
// }

// class _AdminLayoutState extends State<AdminLayout> {
//   late SizeController sizeControl;
//   late bool isDrawerOpen;
//   ThemeMode themeMode = ThemeMode.system;

//   GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     sizeControl = widget.sizeControl;
//     print("Size Has Changed!");
//     if(sizeControl.orientation.value == Orientation.landscape && !sizeControl.isTabScreen.value || sizeControl.isLargeScreen.value){
//       isDrawerOpen = true;
//     }else{
//       isDrawerOpen = false;
//     }
//   }

//   void onDrawerChanged(bool onDrawerChanged){
//     setState(() {
//       isDrawerOpen = onDrawerChanged;
//     });
//   }

//   void onChangedTheme(ThemeMode tMode){
//     setState(() {
//       themeMode = tMode;
//     });
//   }
  

//   @override
//   Widget build(BuildContext context) {
//     sizeControl.createSize(context);
//     print(isDrawerOpen.toString());
//     return Scaffold(
//       key: scaffoldKey,
//       onDrawerChanged: onDrawerChanged,
//       backgroundColor: Theme.of(context).backgroundColor,
//       drawer: (sizeControl.orientation.value == Orientation.landscape && !sizeControl.isTabScreen.value || sizeControl.isLargeScreen.value) ? null : Drawer(
//         child: NavSide(sizeControl: sizeControl, themeMode: themeMode, onChangedTheme: onChangedTheme, isDrawerOpen: isDrawerOpen,),
//       ),
//       body: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           if((sizeControl.orientation.value == Orientation.landscape && !sizeControl.isTabScreen.value || sizeControl.isLargeScreen.value))
//             NavSide(sizeControl: sizeControl, 
//             themeMode: themeMode, 
//             onChangedTheme: onChangedTheme, 
//             isDrawerOpen: isDrawerOpen,
//             ),
//           Container(
//             width: sizeControl.getWidthFromPrecentage((sizeControl.orientation.value == Orientation.landscape && !sizeControl.isTabScreen.value || sizeControl.isLargeScreen.value) && isDrawerOpen ? 80 : 100),
//             child: Stack(
//               children: [
//                 Container(
//                   width: sizeControl.getWidthFromPrecentage((sizeControl.orientation.value == Orientation.landscape && !sizeControl.isTabScreen.value || sizeControl.isLargeScreen.value) && isDrawerOpen ? 80 : 100),
//                   child: Column(
//                     children: [
//                       TopBar(
//                         isDrawerOpen: isDrawerOpen,
//                         sizeControl: sizeControl, 
//                         // leading: IconButton(
//                         //   onPressed: (){
//                         //     if(scaffoldKey.currentState != null && scaffoldKey.currentState!.hasDrawer){
//                         //       if(!isDrawerOpen && !scaffoldKey.currentState!.isDrawerOpen){
//                         //         scaffoldKey.currentState!.openDrawer();
//                         //       }else{
//                         //         scaffoldKey.currentState!.closeDrawer();
//                         //       }
//                         //   }else{
//                         //     onDrawerChanged(!isDrawerOpen);
//                         //   }
                          
//                         //   },
//                         //   icon: Icon(isDrawerOpen ? Icons.arrow_back_ios_new_rounded : Icons.arrow_forward_ios_rounded, color: Theme.of(context).iconTheme.color,)
//                         // ),
//                         action: IconButton(
//                           onPressed: (){}, 
//                           icon: Icon(Icons.more_vert_rounded, 
//                           color: Theme.of(context).iconTheme.color,)
//                           ),
//                       )
//                     ],
//                   ),
//                 ),
//                 Positioned(
//             left: 1,
//             top: sizeControl.getHeightFromPrecentage(50),
//             child: IconButton(
//                   color: Colors.blueAccent,
//                   onPressed: (){
//                       if(scaffoldKey.currentState != null && scaffoldKey.currentState!.hasDrawer){
//                         if(!isDrawerOpen && !scaffoldKey.currentState!.isDrawerOpen){
//                           scaffoldKey.currentState!.openDrawer();
//                         }else{
//                           scaffoldKey.currentState!.closeDrawer();
//                         }
//                     }else{
//                       onDrawerChanged(!isDrawerOpen);
//                     }
                    
//                     },
//                   icon: Icon(isDrawerOpen ? Icons.arrow_back_ios_new_rounded : Icons.arrow_forward_ios_rounded, color: Theme.of(context).iconTheme.color,)
//                 )
//             )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class TopBar extends StatelessWidget {
//   const TopBar({
//     Key? key,
//     required this.sizeControl,
//     this.leading,
//     this.action,
//     required this.isDrawerOpen,
//   }) : super(key: key);

//   final SizeController sizeControl;
//   final Widget? leading;
//   final Widget? action;
//   final bool isDrawerOpen;


//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: sizeControl.getHeightFromPrecentage(sizeControl.orientation.value == Orientation.landscape ? 10 : 7),
//       width: sizeControl.getWidthFromPrecentage((sizeControl.orientation.value == Orientation.landscape && !sizeControl.isTabScreen.value || sizeControl.isLargeScreen.value) && isDrawerOpen ? 80 : 100),
//       decoration: BoxDecoration(
//         border: Border(
//                   bottom: BorderSide(color: Theme.of(context).hintColor, width: 0.3)
//                 )
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           leading ?? const SizedBox(),
//           Text('Center'),
//           action ?? const SizedBox()
//         ],
//       ),
//     );
//   }
// }

// class NavSide extends StatelessWidget {
//   const NavSide({
//     Key? key,
//     required this.sizeControl,
//     required this.themeMode,
//     required this.onChangedTheme,
//     required this.isDrawerOpen,
//     this.onPressed
//   }) : super(key: key);

//   final SizeController sizeControl;
//   final ThemeMode themeMode;
//   final Function(ThemeMode themeMode) onChangedTheme;
//   final bool isDrawerOpen;
//   final Function() ? onPressed;

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 500),
//       width: sizeControl.getWidthFromPrecentage(sizeControl.orientation.value == Orientation.landscape ? !isDrawerOpen ? 4 : 20 : 80),
//       height: sizeControl.getHeightFromPrecentage(100),
//       decoration: BoxDecoration(
//         border: Border(
//           right: BorderSide(color: Theme.of(context).hintColor, width: 0.3)
//         )
//       ),
//       child: !isDrawerOpen ? Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(height: sizeControl.getHeightFromPrecentage(3),),
//           Image.asset('assets/logo.png', width: sizeControl.getHeightFromPrecentage(4), height: sizeControl.getHeightFromPrecentage(4),),
//           // SizedBox(height: sizeControl.getHeightFromPrecentage(40),),
          
          
//         ],
//       ) : Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//             height: sizeControl.getHeightFromPrecentage(25),
//             margin: EdgeInsets.symmetric(
//               horizontal: sizeControl.getWidthFromPrecentage(sizeControl.orientation.value == Orientation.landscape ? 1.8 : 5),
//               vertical: sizeControl.getHeightFromPrecentage(sizeControl.orientation.value == Orientation.landscape ? 2 : 1),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 // Top App Logo
//                 SizedBox(
//                   height: sizeControl.getHeightFromPrecentage(7),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         width: 100,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Image.asset('assets/logo.png', width: sizeControl.getHeightFromPrecentage(4), height: sizeControl.getHeightFromPrecentage(4),),
//                             Text('IISMEE')
//                           ],
//                         ),
//                       ),
//                       Icon(Icons.align_vertical_bottom_rounded, size: 5,)
//                     ],
//                   ),
//                 ),
//                 // Top App Menu 
//                 SizedBox(
//                   height: sizeControl.getHeightFromPrecentage(2),
//                 ),
//                 Container(
//                   margin: EdgeInsets.symmetric(horizontal: 10),
//                   // height: sizeControl.getHeightFromPrecentage(18),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SizedBox(
//                         height: sizeControl.getHeightFromPrecentage(5),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               width: 90,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Icon(Icons.home_filled, size: 5,),
//                                   Text('Dashboard')
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               width: 50,
//                               alignment: Alignment.centerRight,
//                               child: Icon(Icons.align_vertical_bottom_rounded, size: 5,)
//                             )
//                           ],
//                         ),
//                       ),

//                       SizedBox(
//                         height: sizeControl.getHeightFromPrecentage(5),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               width: 90,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Icon(Icons.home_filled, size: 5,),
//                                   Text('Dashboard')
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               width: 50,
//                               alignment: Alignment.centerRight,
//                               child: Icon(Icons.align_vertical_bottom_rounded, size: 5,)
//                             )
//                           ],
//                         ),
//                       ),

//                     ],
//                   ),
//                 ),

//                 Expanded(
//                     child: Divider()
//                 ),

//               ],
//             ),
//           ),

//           // Bottom Menu Profile 

//           Container(
//             height: sizeControl.getHeightFromPrecentage(15),
//             child: Column(
//               children: [
//                 Switch(
//                   value: themeMode == ThemeMode.dark, 
//                   onChanged: (value){
//                     Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
//                     onChangedTheme(value ? ThemeMode.dark : ThemeMode.light);
//                 }
//               ),

//               Container(
//                 height: sizeControl.getHeightFromPrecentage(6),
//               )

//               ],
//             ),
//           )

//         ],
//       ),
//     );
//   }
// }
