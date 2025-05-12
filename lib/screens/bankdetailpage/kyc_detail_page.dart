import 'package:UNGolds/constant/app_color.dart';
import 'package:UNGolds/constant/drawer_design.dart';
import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/constant/utility.dart';
import 'package:UNGolds/network/response/get_kyc_status_response.dart';
import 'package:UNGolds/screens/bankdetailpage/kyc_done_stepper.dart';
import 'package:UNGolds/screens/bankdetailpage/stepper_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/printmessage.dart';
import '../../constant/progressdialog.dart';
import '../../network/createjson.dart';
import '../../network/networkcall.dart';
import '../../network/networkutility.dart';
import '../bottom_navigation_bar.dart';

String kycstatus = "0";

class KYCDetailPage extends StatefulWidget {
  String getback;
  KYCDetailPage(this.getback);
  State createState() => KYCDetailPageState();
}

class KYCDetailPageState extends State<KYCDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Networkcallforkycstatus();
  }

  Future<void> Networkcallforkycstatus() async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading");
      String createjson =
          CreateJson().createjsonforwithID(AppUtility.ID, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? signup = await networkcall.postMethod(
          NetworkUtility.get_kyc_status,
          NetworkUtility.get_kyc_status_api,
          createjson,
          context);
      if (signup != null) {
        Navigator.pop(context);
        List<Getkycstatusresponse> profileresponse = List.from(signup!);
        String status = profileresponse[0].status.toString();
        switch (status) {
          case "true":
            kycstatus = profileresponse[0].data!.kyc!;
            setState(() {});

            break;
          case "false":
            SnackBar(content: Text(profileresponse[0].message!));
            break;
        }
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), 'Networkcallforkycstatus', "KYC Detail", context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      endDrawer: CommonDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return BottomNavigationBarPage();
                },
              ));
            },
            icon: Icon(CupertinoIcons.left_chevron)),
        elevation: 0,
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  'KYC Details'.introTitleText(context),
                ],
              ).marginOnly(top: 10),
            ),
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 25,
            ).marginOnly(right: 10, top: 10)
          ],
        ),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [
                AppColor.intoColor.withOpacity(0.4),
                AppColor.theamecolor.withOpacity(0.4)
              ], // Adjust the colors as needed
            ),
          ),
          child: BackdropFilter(
              filter: const ColorFilter.mode(Colors.white, BlendMode.softLight),
              child: kycstatus == "0" || kycstatus == "2"
                  ? KYCStepper(kycstatus, widget.getback)
                  : KYCDoneStepper(kycstatus))),
    );
  }
}
