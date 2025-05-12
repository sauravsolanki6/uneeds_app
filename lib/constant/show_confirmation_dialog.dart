import 'package:UNGolds/constant/extension.dart';
import 'package:flutter/material.dart';

import 'app_color.dart';

class AlertDialogDesign extends StatelessWidget {
  final VoidCallback yesbuttonPressed;
  final VoidCallback nobuttonPressed;
  final String title;
  final String description;
  final double thickness;
  const AlertDialogDesign({
    Key? key,
    required this.yesbuttonPressed,
    required this.nobuttonPressed,
    required this.title,
    required this.description,
    this.thickness = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 5,
            width: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  child: Text(
                title,
                style: TextStyle(
                    color: AppColor.theamecolor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
                textAlign: TextAlign.center,
              )),
            ],
          ),
          Text(
            description,
            style: TextStyle(
                color: AppColor.bordercolor,
                fontWeight: FontWeight.w600,
                fontSize: 14),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        nobuttonPressed();
                      },
                      style: ElevatedButton.styleFrom(
                          side: BorderSide(color: Colors.white, width: 1),
                          backgroundColor: Colors.white),
                      child: Text(
                        'No',
                        style: TextStyle(
                            color: AppColor.redcolor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                        textAlign: TextAlign.center,
                      )),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        yesbuttonPressed();
                      },
                      style: ElevatedButton.styleFrom(
                          side: BorderSide(color: Colors.white, width: 1),
                          backgroundColor: Colors.white),
                      child: Text(
                        'Yes',
                        style: TextStyle(
                            color: AppColor.theamecolor,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                        textAlign: TextAlign.center,
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
