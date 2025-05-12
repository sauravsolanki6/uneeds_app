import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/extension.dart';
import '../../constant/app_icon.dart';

class OnBoarding1 extends StatelessWidget {
  const OnBoarding1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: height / 30,
        ),
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 170,
          backgroundImage: AppIcon.onBoardingImage1(),
        ).marginOnly(top: 20, bottom: 20),
        Container(
          height: 96,
          child:
              """View And Exprience \n Furniture With The Help \nOf Augmented Reality"""
                  .introTitleText(context),
        )
      ],
    );
  }
}

class OnBoarding2 extends StatelessWidget {
  const OnBoarding2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: height / 30,
        ),
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 170,
          backgroundImage: AppIcon.onBoardingImage2(),
        ).marginOnly(top: 20, bottom: 20),
        Container(
          height: 96,
          child:
              """Design Your Space With\n Augmented Reality By \nCreating Room"""
                  .introTitleText(context),
        )
      ],
    );
  }
}

class OnBoarding3 extends StatelessWidget {
  const OnBoarding3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: height / 30,
        ),
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 170,
          backgroundImage: AppIcon.onBoardingImage3(),
        ).marginOnly(top: 20, bottom: 20),
        Container(
          height: 96,
          child:
              """Explore World Class Top \nFurnitures As Per Your \nRequirements & Choice"""
                  .introTitleText(context),
        )
      ],
    );
  }
}
