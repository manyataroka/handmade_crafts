import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingViewModel extends StateNotifier<int> {
  OnboardingViewModel() : super(0);

  int get currentPage => state;
  int totalPages = 3;

  void setPage(int page) {
    if (page >= 0 && page < totalPages) {
      state = page;
    }
  }

  void nextPage() {
    if (state < totalPages - 1) {
      state++;
    }
  }

  bool get isLastPage => state == totalPages - 1;
}
