import 'package:ekonomi_new/background/backGround.dart';
import 'package:ekonomi_new/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/onboarding_provider.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingProvider(),
      child: Consumer<OnboardingProvider>(
        builder: (context, provider, child) {
          return Stack(
            children: [
              Positioned.fill(child: Background()),
              Scaffold(
                backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                body: Stack(
                  children: [
                    PageView.builder(
                      controller: provider.pageController,
                      itemCount: provider.onboardingPages.length,
                      onPageChanged: provider.updatePage,
                      itemBuilder: (context, index) {
                        final page = provider.onboardingPages[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Image.asset(
                                  page.imagePath,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      page.title,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      page.description,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        );
                      },
                    ),

                    // Bottom Controls
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Page Indicator
                              Row(
                                children: List.generate(
                                  provider.onboardingPages.length,
                                  (index) => AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    height: 8,
                                    width: provider.currentPage == index
                                        ? 20
                                        : 8,
                                    decoration: BoxDecoration(
                                      color: provider.currentPage == index
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey[300],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                              ),

                              // Next Button
                              ElevatedButton(
                                onPressed: () async {
                                  if (provider.currentPage ==
                                      provider.onboardingPages.length - 1) {
                                    await provider.completeOnboarding();
                                    Navigator.pushReplacement(
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => Homescreen(),
                                      ),
                                    );
                                  } else {
                                    provider.nextPage();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  minimumSize: const Size(62, 62),
                                ),
                                child: const Icon(
                                  Icons.arrow_forward,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
