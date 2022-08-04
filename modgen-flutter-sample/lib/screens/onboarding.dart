import 'package:flutter/material.dart';
import 'package:onboarding/onboarding.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late Material materialButton;
  final onboardingPageList = [
    PageModel(
      widget: Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 45.0,
                vertical: 90.0,
              ),
              child: Icon(
                Icons.language,
                size: 128,
                color: Colors.white,
              )
              // Image.asset('assets/images/facebook.png',
              //     color: pageImageColor),
              ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 45.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Welcome to Wasabih!',
              style: pageTitleStyle,
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'The first Halal economy hub',
              style: pageInfoStyle,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    ),
    PageModel(
      widget: Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 45.0,
                vertical: 90.0,
              ),
              child: Icon(
                Icons.volunteer_activism,
                size: 128,
                color: Colors.white,
              )
              // Image.asset('assets/images/facebook.png',
              //     color: pageImageColor),
              ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 45.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'BE PART OF THE COMMUNITY',
              style: pageTitleStyle,
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Connect with your business partners.',
              style: pageInfoStyle,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    ),
    PageModel(
      widget: Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 45.0,
                vertical: 90.0,
              ),
              child: Icon(
                Icons.event,
                size: 128,
                color: Colors.white,
              )),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 45.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'All the halal events are here',
              style: pageTitleStyle,
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 45.0, vertical: 10.0),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Keep you inform of all halal event in the world',
              style: pageInfoStyle,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    )
  ];

  @override
  void initState() {
    super.initState();
    materialButton = _skipButton;
  }

  set _buildButton(int pageIndex) {
    if (pageIndex == 2) {
      setState(() {
        materialButton = _signupButton;
      });
    } else {
      setState(() {
        materialButton = _skipButton;
      });
    }
  }

  Material get _skipButton {
    return Material(
      borderRadius: defaultSkipButtonBorderRadius,
      color: defaultSkipButtonColor,
      child: InkWell(
        borderRadius: defaultSkipButtonBorderRadius,
        onTap: () {
          Navigator.pushReplacementNamed(context, '/event');
        },
        child: const Padding(
          padding: defaultSkipButtonPadding,
          child: Text(
            'Skip',
            style: defaultSkipButtonTextStyle,
          ),
        ),
      ),
    );
  }

  Material get _signupButton {
    return Material(
      borderRadius: defaultProceedButtonBorderRadius,
      color: defaultProceedButtonColor,
      child: InkWell(
        borderRadius: defaultProceedButtonBorderRadius,
        onTap: () {
          Navigator.pushReplacementNamed(context, '/event');
        },
        child: const Padding(
          padding: defaultProceedButtonPadding,
          child: Text(
            'Enter',
            style: defaultProceedButtonTextStyle,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Onboarding(
      pages: onboardingPageList,
      background: Colors.red.withRed(0xc0).withBlue(0x1b).withGreen(0x16),
      onPageChange: (int pageIndex) {
        _buildButton = pageIndex;
      },
      footer: Footer(
        child: materialButton,
        indicator: Indicator(
          indicatorDesign: IndicatorDesign.line(
            lineDesign: LineDesign(
              lineType: DesignType.line_nonuniform,
            ),
          ),
        ),
        footerPadding: const EdgeInsets.all(45.0),
      ),
    );
  }
}
