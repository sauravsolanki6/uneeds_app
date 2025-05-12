import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../constant/extension.dart';
import '../../constant/app_color.dart';
import '../../constant/app_icon.dart';
import '../login_page/login_page.dart';
import 'on_boarding_controller.dart';
import 'on_boarding_screen_1.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final introController = Get.put(IntroScreenController());
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.cardColor,
        bottomNavigationBar: Obx(
          () => introController.selectedIndex.value == 2
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      height: 50,
                      width: 280,
                      decoration: BoxDecoration(
                          color: AppColor.intoColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: GestureDetector(
                        onTap: () {
                          print('------------>Login Page');
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) {
                              return LoginPage(false);
                            },
                          ));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            'Get Started'.getText(),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) {
                            return LoginPage(false);
                          },
                        ));
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ).marginOnly(left: 30, bottom: 20),
                    ),
                    GestureDetector(
                      onTap: () {
                        introController.pageController.value.nextPage(
                            duration: Duration(seconds: 1), curve: Curves.ease);
                      },
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: AppColor.intoColor,
                        child: Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: Colors.white,
                          size: 15,
                        ),
                      ).marginOnly(right: 30, bottom: 20),
                    ),
                  ],
                ),
        ),
        body: Stack(
          children: [
            PageView(
              onPageChanged: introController.onPageChange,
              physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              controller: introController.pageController.value,
              children: const [
                OnBoarding1(),
                OnBoarding2(),
                OnBoarding3(),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: height / 1.4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: SmoothPageIndicator(
                        controller: introController.pageController.value,
                        // PageController
                        count: 3,
                        effect: WormEffect(
                            dotWidth: 10,
                            dotHeight: 10,
                            activeDotColor: AppColor.intoColor,
                            dotColor: Color(0xff98B7B3)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
