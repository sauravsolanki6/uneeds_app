import 'package:UNGolds/constant/snackbardesign.dart';
import 'package:flutter/material.dart';

import 'app_color.dart';

class PrintMessage {
  static printmessage(String message, String functioname, String fileName,
      BuildContext context) {
    print(
        'Message: ${message}/ Function: ${functioname}/ FileName: ${fileName}');
    // SnackBarDesign(
    //     'Message: ${message}/ Function: ${functioname}/ FileName: ${fileName}',
    //     context,
    //     AppColor.errorcolor,
    //     Colors.white);
  }
}
