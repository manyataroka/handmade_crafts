import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DashboardTab { home, menu, cart, profile }

class DashboardViewModel extends StateNotifier<DashboardTab> {
  DashboardViewModel() : super(DashboardTab.home);

  DashboardTab get currentTab => state;

  void setTab(DashboardTab tab) => state = tab;
}
