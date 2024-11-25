import 'package:flutter/material.dart';

import 'screens/add_photo_screen.dart';
import 'screens/birthday_screen.dart';
import 'screens/gender_screen.dart';
import 'screens/nickname_screen.dart';
import 'widgets/onboarding_frame.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: PageView(
          controller: _controller,
          physics: NeverScrollableScrollPhysics(),
          children: [
            OnboardingFrame(
              frameIndex: 0,
              onBackPressed: previousScreen,
              child: BirthdayScreen(onPressed: nextScreen),
            ),
            OnboardingFrame(
              frameIndex: 1,
              onBackPressed: previousScreen,
              child: NicknameScreen(onPressed: nextScreen),
            ),
            OnboardingFrame(
              frameIndex: 2,
              onBackPressed: previousScreen,
              child: GenderScreen(onPressed: nextScreen),
            ),
            OnboardingFrame(
              frameIndex: 3,
              onBackPressed: previousScreen,
              child: AddPhotoScreen(),
            ),
          ],
        ),
      ),
    );
  }

  void nextScreen() {
    _controller.nextPage(duration: Duration(milliseconds: 200), curve: Curves.linear);
  }

  void previousScreen() {
    _controller.previousPage(duration: Duration(milliseconds: 200), curve: Curves.linear);
  }
}
