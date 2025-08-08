import 'package:shared_preferences/shared_preferences.dart';
import '../models/onboarding_model.dart';

class OnboardingPresenter {
  final List<OnboardingModel> pages = [
    OnboardingModel(
      title: "Get Started",
      description:
          "Kickstart your financial journey. Set up your digital wallet effortlessly and start managing your money in minutes.",
      imagePath: "assets/onboarding/Onboarding_1.png",
    ),
    OnboardingModel(
      title: "Control Wealth",
      description:
          "Stay on top of your finances. Track spending, set budgets, and manage investments with ease.",
      imagePath: "assets/onboarding/Onboarding_2.png",
    ),
    OnboardingModel(
      title: "Achieve Goals",
      description:
          "Set financial targets and reach them step by step. Our app helps you stay on track and celebrate your progress.",
      imagePath: "assets/onboarding/Onboarding_3.png",
    ),
  ];

  Future<void> markOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete', true);
  }

  Future<bool> isOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboarding_complete') ?? false;
  }
}
