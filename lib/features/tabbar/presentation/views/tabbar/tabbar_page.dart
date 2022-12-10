import 'package:flutter/cupertino.dart';
import 'package:jbbase_app/base/presentation/presentation.dart';
import 'package:jbbase_app/utils/config/app_route.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../controller/tabbar/tabbar_controller.dart';

extension TabItem on TabType {
  Widget get icon {
    switch (this) {
      case TabType.home:
        return Icon(
          CupertinoIcons.home,
          size: 20,
          color: Get.context?.theme.colorScheme.onPrimaryContainer,
        );
      case TabType.add:
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Get.context?.theme.colorScheme.secondaryContainer,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              CupertinoIcons.add,
              size: 20,
              color: Get.context?.theme.colorScheme.onPrimaryContainer,
            ),
          ),
        );
      case TabType.list:
        return Icon(
          CupertinoIcons.list_bullet,
          size: 20,
          color: Get.context?.theme.colorScheme.onPrimaryContainer,
        );
    }
  }

  Widget get inactiveIcon {
    switch (this) {
      case TabType.home:
        return Icon(
          CupertinoIcons.home,
          size: 20,
          color: Get.context?.theme.disabledColor,
        );
      case TabType.add:
        return Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Get.context?.theme.colorScheme.secondaryContainer,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              CupertinoIcons.add,
              size: 20,
              color: Get.context?.theme.disabledColor,
            ),
          ),
        );
      case TabType.list:
        return Icon(
          CupertinoIcons.list_bullet,
          size: 20,
          color: Get.context?.theme.disabledColor,
        );
    }
  }

  String get title {
    switch (this) {
      case TabType.home:
        return 'Home';
      case TabType.add:
        return 'Add';
      case TabType.list:
        return 'List';
    }
  }

  Widget get page {
    switch (this) {
      case TabType.home:
        return AppRoute.getPage(AppRoute.EX10)?.page() ?? Container();
      case TabType.add:
        return Container();
      case TabType.list:
        return AppRoute.getPage(AppRoute.EX20)?.page() ?? Container();
    }
  }

  PersistentBottomNavBarItem get item {
    return PersistentBottomNavBarItem(
      icon: icon,
      inactiveIcon: inactiveIcon,
      onPressed: this == TabType.add
          ? (_) async {
              L.debug('custom action');
            }
          : null,
    );
  }
}

class TabbarPage extends GetView<TabbarController> {
  List<Widget> _buildScreens() {
    return TabType.values.map((e) => e.page).toList();
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return TabType.values.map((e) => e.item).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PersistentTabView(
          context,
          backgroundColor: Get.context?.theme.appBarTheme.backgroundColor ?? Colors.white,
          controller: controller.tabController,
          screens: _buildScreens(),
          items: _navBarsItems(),
          confineInSafeArea: true,
          resizeToAvoidBottomInset: true,
          decoration: const NavBarDecoration(
            colorBehindNavBar: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(80, 187, 176, 222),
                blurRadius: 2,
                offset: Offset(0, 0),
              ),
            ],
          ),
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle.style12,
          onItemSelected: controller.onTabSelected,
        ),
      ],
    );
  }
}
