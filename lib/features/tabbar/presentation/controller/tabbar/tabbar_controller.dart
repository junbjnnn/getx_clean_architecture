import 'package:jbbase_app/base/presentation/presentation.dart';
import 'package:jbbase_app/features/example/example.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

enum TabType { home, add, list }

class TabbarController extends BaseController with GetSingleTickerProviderStateMixin {
  final _tabController = PersistentTabController(initialIndex: 0);
  final ExampleHomeController _exampleHomeController;
  final ExampleHomeListController _exampleHomeListController;

  PersistentTabController get tabController => _tabController;

  TabbarController(
    this._exampleHomeController,
    this._exampleHomeListController,
  );

  @override
  void onInit() {
    super.onInit();
    _initDependencies();
  }

  void _initDependencies() {}

  void onTabSelected(int index) {
    final tabType = TabType.values[index];

    // switch (tabType) {
    //   default:
    // }
  }
}
