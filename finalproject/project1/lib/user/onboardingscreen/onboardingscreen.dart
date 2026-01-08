import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project1/user/login/login.dart';
import 'package:project1/user/onboardingscreen/widgets/header.dart';
import 'package:project1/user/onboardingscreen/widgets/next_page_button.dart';
import 'package:project1/user/onboardingscreen/widgets/onboarding_page_indicator.dart';
import 'package:project1/user/onboardingscreen/widgets/pages/community/community_dark_card_content.dart';
import 'package:project1/user/onboardingscreen/widgets/pages/community/community_light_card_content.dart';
import 'package:project1/user/onboardingscreen/widgets/pages/community/community_text_column.dart';
import 'package:project1/user/onboardingscreen/widgets/pages/onboarding_page.dart';
import 'package:project1/user/onboardingscreen/widgets/pages/relationships/relationships_dark_card_content.dart';
import 'package:project1/user/onboardingscreen/widgets/pages/relationships/relationships_light_card_content.dart';
import 'package:project1/user/onboardingscreen/widgets/pages/relationships/relationships_text_column.dart';
import 'package:project1/user/onboardingscreen/widgets/pages/work/work_dark_card_content.dart';
import 'package:project1/user/onboardingscreen/widgets/pages/work/work_light_card_content.dart';
import 'package:project1/user/onboardingscreen/widgets/pages/work/work_text_column.dart';

import '../constants.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingState();
}

class _OnboardingState extends State<OnboardingScreen> {
  int _currentPage = 1;

  Future<void> finishOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_seen', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBrown,
      body: SafeArea(
        child: Column(
          children: [
            Header(onSkip: _goToLogin),

            Expanded(child: _getPage()),

            OnboardingPageIndicator(
              currentPage: _currentPage,
              child: NextPageButton(onPressed: _nextPage),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _goToLogin() async {
    await finishOnboarding();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  void _setNextPage(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    switch (_currentPage) {
      case 1:
        _setNextPage(2);
        break;
      case 2:
        _setNextPage(3);
        break;
      case 3:
        _goToLogin();
        break;
    }
  }

  Widget _getPage() {
    switch (_currentPage) {
      case 1:
        return const OnboardingPage(
          number: 1,
          lightCardChild: CommunityLightCardContent(),
          darkCardChild: CommunityDarkCardContent(),
          textColumn: CommunityTextColumn(),
        );
      case 2:
        return const OnboardingPage(
          number: 2,
          lightCardChild: EducationLightCardContent(),
          darkCardChild: EducationDarkCardContent(),
          textColumn: EducationTextColumn(),
        );
      case 3:
        return const OnboardingPage(
          number: 3,
          lightCardChild: WorkLightCardContent(),
          darkCardChild: WorkDarkCardContent(),
          textColumn: WorkTextColumn(),
        );
      default:
        return const SizedBox();
    }
  }
}
