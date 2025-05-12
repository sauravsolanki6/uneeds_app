import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_color.dart';

class ButtonDesign extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double thickness;

  const ButtonDesign({
    Key? key,
    required this.onPressed,
    required this.child,
    this.thickness = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 45,
            decoration: BoxDecoration(
                color: AppColor.theamecolor,
                borderRadius: BorderRadius.circular(10)),
            child: InkWell(
              onTap: () {
                onPressed();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [child],
              ),
            ),
          ),
        )
      ],
    ).marginOnly(top: 15);
  }
}
