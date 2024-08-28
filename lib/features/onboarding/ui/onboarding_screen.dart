import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tweetapp/features/auth/ui/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //  Page View
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [
              Container(
                color: Colors.blue,
              ),
              Container(
                color: Colors.yellow,
              ),
              Container(
                color: Colors.green,
              ),

              // DotIndicators
            ],
          ),
          Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Skip Button
                  InkWell(
                      onTap: () {
                        _controller.jumpToPage(2);
                      },
                      child: const Text("Skip")),

                  SmoothPageIndicator(
                    effect: const ExpandingDotsEffect(),
                    controller: _controller,
                    count: 3,
                  ),
                  onLastPage
                      ? InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Done",
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            _controller.nextPage(
                              duration: const Duration(
                                milliseconds: 500,
                              ),
                              curve: Curves.easeIn,
                            );
                          },
                          child: const Text(
                            "Next",
                          ),
                        ),
                ]),
          ),
        ],
      ),
    );
  }
}
