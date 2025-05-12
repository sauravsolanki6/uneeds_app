import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/extension.dart';
import '../../constant/app_color.dart';
import '../../constant/app_icon.dart';

class PageViewHomepage extends StatelessWidget {
  const PageViewHomepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 2),
      height: 150,
      width: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      spreadRadius: 0,
                      blurRadius: 1,
                      offset: Offset(1, 1),
                    ),
                  ],
          image: DecorationImage(
              image: AppIcon.pageViewImage(), fit: BoxFit.fill)),
      // child: Column(
      //   children: [
      //     Row(
      //       children: ['35% discount'.pageViewtext()],
      //     ).marginOnly(left: 16, top: 16),
      //     Row(
      //       children: ['For a cozy yellow set!'.pageViewSubText()],
      //     ).marginOnly(left: 16),
      //     Row(
      //       children: [
      //         Container(
      //           height: 40,
      //           width: 100,
      //           decoration: BoxDecoration(
      //               color: AppColor.intoColor,
      //               borderRadius: BorderRadius.circular(25)),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: ['Learn More'.pageViewButtonText()],
      //           ),
      //         ),
      //       ],
      //     ).marginOnly(left: 16, top: 25)
      //   ],
      // ),
    );
  }
}

class PageViewHomepage1 extends StatelessWidget {
  const PageViewHomepage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      height: 150,
      width: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
           boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      spreadRadius: 0,
                      blurRadius: 1,
                      offset: Offset(1, 1),
                    ),
                  ],
          image: DecorationImage(
              image: AppIcon.pageViewImage2(), fit: BoxFit.fill)),
      // child: Column(
      //   children: [
      //     Row(
      //       children: ['25% discount'.pageViewtext()],
      //     ).marginOnly(left: 16, top: 16),
      //     Row(
      //       children: ['For a cozy yellow set!'.pageViewSubText()],
      //     ).marginOnly(left: 16),
      //     Row(
      //       children: [
      //         Container(
      //           height: 40,
      //           width: 100,
      //           decoration: BoxDecoration(
      //               color: AppColor.intoColor,
      //               borderRadius: BorderRadius.circular(25)),
      //           child: Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: ['Learn More'.pageViewButtonText()],
      //           ),
      //         ),
      //       ],
      //     ).marginOnly(left: 16, top: 25)
      //   ],
      // ),
    );
  }
}

class PageViewHomepage2 extends StatelessWidget {
  const PageViewHomepage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      height: 150,
      width: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
              image: AppIcon.pageViewImage(), fit: BoxFit.fill)),
      child: Column(
        children: [
          Row(
            children: ['25% discount'.pageViewtext()],
          ).marginOnly(left: 16, top: 16),
          Row(
            children: ['For a cozy yellow set!'.pageViewSubText()],
          ).marginOnly(left: 16),
          Row(
            children: [
              Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                    color: AppColor.intoColor,
                    borderRadius: BorderRadius.circular(25)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: ['Learn More'.pageViewButtonText()],
                ),
              ),
            ],
          ).marginOnly(left: 16, top: 25)
        ],
      ),
    );
  }
}
