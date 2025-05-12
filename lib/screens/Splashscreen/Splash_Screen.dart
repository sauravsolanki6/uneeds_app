import 'dart:async';

import 'package:UNGolds/bottomnavigationwithoutlogin.dart';
import 'package:UNGolds/constant/printmessage.dart';
import 'package:UNGolds/constant/utility.dart';
import 'package:UNGolds/screens/login_page/login_page.dart';
import 'package:android_play_install_referrer/android_play_install_referrer.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

// import 'package:uni_links/uni_links.dart';

import '../../constant/app_assets.dart';
import '../../constant/app_icon.dart';
import '../../constant/shared_pre.dart';
import '../../dbhelper.dart';
import '../bottom_navigation_bar.dart';
import '../onboardingpage/Onboarding_Page.dart';
import '../sign_up/sign_up.dart';

bool _initialUriIsHandled = false;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Uri? _initialUri;
  Uri? _latestUri;
  Object? _err;

  StreamSubscription? _sub;
  void initState() {
    super.initState();

    getValueFromSharedPref();

    Timer(
      const Duration(seconds: 3),
      () {
        checkIfDownloadedViaReferral();
      },
    );
  }

  getValueFromSharedPref() async {
    try {
      await SharedPreference().getvalueonligin(context);
      if (AppUtility.MobileNumber == "") {
        storeValue(AppUtility.MobileNumber);
      } else {
        updateSecondValue(AppUtility.MobileNumber);
      }
    } catch (e) {
      print(e);
      //  PrintMessage.printmessage(e.toString(), 'getValueFromSharedPref', 'Main',);
    }
  }

  bool googlePlayInstantParam = false;
  Future<String> initReferrerDetails() async {
    String referrerDetailsString;
    try {
      ReferrerDetails referrerDetails =
          await AndroidPlayInstallReferrer.installReferrer;
      referrerDetailsString = referrerDetails.installReferrer.toString();
      googlePlayInstantParam = referrerDetails.googlePlayInstantParam;
      setState(() {});
    } catch (e) {
      referrerDetailsString = 'Failed to get referrer details: $e';
    }
    return referrerDetailsString;
  }

  String? name, mobile;
  void getInstallReferrerDetails() async {
    ReferrerDetails referrerDetails =
        await AndroidPlayInstallReferrer.installReferrer;
    String referrerDetailsString = referrerDetails.installReferrer.toString();

    // Parse the referrer string to get the name and mobile parameters
    Uri referrerUri = Uri.parse(referrerDetailsString);

    // Extract the 'name' and 'mobile' parameters from the query string
    name = referrerUri.queryParameters['name'];
    mobile = referrerUri.queryParameters['mobile'];

    // Use the extracted name and mobile values
    print('Name: $name');
    print('Mobile: $mobile');
  }

  Future<void> checkIfDownloadedViaReferral() async {
    try {
      ReferrerDetails referrerDetails =
          await AndroidPlayInstallReferrer.installReferrer;
      String? referrer = referrerDetails.installReferrer;

      if (referrer!.contains("utm_source") ||
          referrer!.contains("referral_code")) {
        print("App was downloaded using a referral link.");
        Uri referrerUri = Uri.parse(referrer);
        String? name = referrerUri.queryParameters['name'];
        String? mobile = referrerUri.queryParameters['mobile'];

        if (name == null && mobile == null) {
          movetonext2();
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return SignUp(mobile!, name!, false);
            },
          ));
        }
      } else {
        movetonext2();
      }
    } catch (e) {
      print("Failed to retrieve install referrer: $e");
    }
  }

  Movetonext() async {
    String abc = await initReferrerDetails();
    if (abc == "utm_source=google-play&utm_medium=organic") {
      movetonext2();
    } else {
      // if (AppUtility.SingUpDone != "1") {
      // Navigator.pushReplacement(context, MaterialPageRoute(
      //   builder: (context) {
      //     return SignUp(abc, "");
      //   },
      // ));
      // } else {
      movetonext2();
      // }
    }
  }

  movetonext2() {
    if (AppUtility.ID != "") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNavigationBarPage()),
      );
    } else {
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => LoginPage(false),
      //   ),
      // );
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return BottomNavigationWithoutLogin();
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Image.asset(
            "assets/images/ic_launcher.png",
          ),
        ),
      ),
    );
  }
}

void storeValue(String value) async {
  DatabaseHelper db = DatabaseHelper();
  await db.insertValue(value);

  print("Value stored: $value");
}

void updateSecondValue(String mobile) async {
  DatabaseHelper dbHelper = DatabaseHelper();

  // Update the second value (id = 2) to a new value
  int updatedCount = await dbHelper.updateValue(1, mobile);
  if (updatedCount > 0) {
    print('Value updated successfully!');
  } else {
    print('Failed to update value.');
  }
}
