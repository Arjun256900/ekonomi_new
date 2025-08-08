import 'package:flutter/material.dart';
import '../presenters/onboarding_presenter.dart';

class OnboardingProvider with ChangeNotifier {
  final OnboardingPresenter presenter = OnboardingPresenter();
  int _currentPage = 0;
  final PageController _pageController = PageController();

  int get currentPage => _currentPage;
  PageController get pageController => _pageController;
  List get onboardingPages => presenter.pages;

  void updatePage(int index) {
    _currentPage = index;
    notifyListeners();
  }

  void nextPage() {
    if (_currentPage < onboardingPages.length - 1) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }

  Future<void> completeOnboarding() async {
    await presenter.markOnboardingComplete();
  }
}
