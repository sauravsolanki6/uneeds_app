import 'package:UNGolds/constant/app_color.dart';
import 'package:UNGolds/constant/button_design.dart';
import 'package:UNGolds/constant/drawer_design.dart';
import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/network/response/get_fees_response.dart';
import 'package:UNGolds/screens/gold_order/buy_gold_on_emi_check.dart';
import 'package:UNGolds/screens/gold_order/buy_now.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../annimation/blinking_annimation.dart';
import '../../constant/login_drawer.dart';
import '../../constant/printmessage.dart';
import '../../constant/progressdialog.dart';
import '../../constant/snackbardesign.dart';
import '../../constant/utility.dart';
import '../../network/createjson.dart';
import '../../network/networkcall.dart';
import '../../network/networkutility.dart';
import '../../network/response/live_rate_response.dart';
import '../login_page/login_page.dart';

bool showbenifits = true;

class BuyGoldOnEMI extends StatefulWidget {
  State createState() => BuyGoldOnEMIState();
}

class BuyGoldOnEMIState extends State<BuyGoldOnEMI> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NetworkCallForLiveRate();
    Networkcallforfees();
  }

  Future<void> NetworkCallForLiveRate() async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading");
      Networkcall networkcall = Networkcall();
      List<Object?>? signup = await networkcall.getMethod(
          NetworkUtility.get_live_rate,
          NetworkUtility.get_live_rate_api,
          context);
      if (signup != null) {
        Navigator.pop(context);
        List<Liverateresponse> stateresponse = List.from(signup!);
        String status = stateresponse[0].status.toString();
        switch (status) {
          case "true":
            AppUtility.pergramrate =
                double.parse(stateresponse[0].data!.productPricePerGram!);
            setState(() {});
            break;
          case "false":
            SnackBarDesign(stateresponse[0].message!, context,
                AppColor.errorcolor, Colors.white);
            break;
        }
      } else {
        Navigator.pop(context);
        SnackBarDesign('Something went wrong!', context, AppColor.errorcolor,
            Colors.white);
      }
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), 'Networkcallforlogin', "OTP Verify", context);
    }
  }

  double bookingAmount = 0.0, processingfees = 0.0, membersheepfees = 0.0;
  String membersheeptype = "",
      membersheepstatus = "",
      proceesingfeesgst = "0.0",
      makingcharge = "",
      makinggst = "";

//status=1 dont show memnber ship status 0 show
  Future<void> Networkcallforfees() async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading");
      String createjson =
          CreateJson().createjsonforwithID(AppUtility.ID, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? signup = await networkcall.postMethod(
          NetworkUtility.get_fees,
          NetworkUtility.get_fees_api,
          createjson,
          context);
      if (signup != null) {
        Navigator.pop(context);
        List<Getfeesresponse> response = List.from(signup!);
        String status = response[0].status.toString();
        switch (status) {
          case "true":
            bookingAmount = double.parse(response[0].data!.advanceBookingFess!);
            processingfees = double.parse(response[0].data!.processingFess!);
            membersheepfees =
                double.parse(response[0].data!.updatedMembershipFees!);
            membersheeptype = response[0].data!.membershipType!;
            membersheepstatus = response[0].data!.membershipStatus!;
            if (response[0].data!.processingFessGst == null) {
              proceesingfeesgst = "0.0";
            } else {
              proceesingfeesgst = response[0].data!.processingFessGst!;
            }
            makingcharge = response[0].data!.makingCharge!;
            makingchargesgst = response[0].data!.makingChargeGst!;
            setState(() {});
            break;
          case "false":
            SnackBar(content: Text(response[0].message!));
            break;
        }
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), 'Networkcallforfees', "Buy Gold On EMI", context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    showbenifits = true;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      endDrawer: AppUtility.ID != "" ? CommonDrawer() : LoginDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        // leading: IconButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     icon: Icon(CupertinoIcons.left_chevron)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  'Buy Gold On EMI'.introTitleText(context),
                ],
              ).marginOnly(top: 10),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(10),
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
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 0,
                        blurRadius: 2,
                        offset: Offset(0, 0),
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        _thirdWidget(),
                        _fourthWidget(),
                        _fifthWidget(),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 12.0, right: 12.0),
                          child: _sixWidget(),
                        ),
                      ]),
                ),
                //   showbenifits ? hidebenifitsbutton() : showbenifitsbutton(),
                SizedBox(
                  height: 10,
                ),
                _sevenWidget(),
                showbenifits ? _nineWidget() : Container(),
                showbenifits ? _tenthWidget() : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _firstWidget() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: CircleAvatar(
        radius: 22.0,
        backgroundColor: Color(0xffddae48),
        child: CircleAvatar(
          radius: 20.0,
          backgroundColor: Colors.white,
          backgroundImage: const AssetImage('assets/images/ic_launcher.png'),
        ),
      ),
    );
  }

  Widget _thirdWidget() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Text(
        'Gold Rate 99.95  Purity ( 1 Gram Rate) ',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: AppColor.bordercolor,
            fontSize: 15,
            fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _fourthWidget() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Text(
        ' ${AppUtility.pergramrate.inRupeesFormat()} ',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Color(0xffddae48),
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _fifthWidget() {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: BlinkingWidget(
              child: Container(
                height: 10,
                width: 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffF44336),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 2,
          ),
          Text(
            'Live',
            style: TextStyle(
                color: Color(0xffF44336),
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _sixWidget() {
    return ButtonDesign(
        onPressed: () {
          if (AppUtility.ID != "") {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return BuyGoldOnEMICheck(
                    AppUtility.pergramrate,
                    bookingAmount,
                    processingfees,
                    membersheepfees,
                    membersheeptype,
                    membersheepstatus,
                    proceesingfeesgst,
                    makingcharge,
                    makinggst);
              },
            )).then(
              (value) {
                NetworkCallForLiveRate();
                Networkcallforfees();
              },
            );
          } else {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return LoginPage(true);
              },
            )).then((value) {
              NetworkCallForLiveRate();
              Networkcallforfees();
            });
          }
        },
        child: AppUtility.ID != ""
            ? 'BUY NOW'.buttoText()
            : "LOGIN TO BUY ON EMI ".buttoText());
  }

  Widget _sevenWidget() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 1,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/new/hallmark.png',
                      width: 50,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "BIS Hallmarked",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 68, 67, 67)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 1,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/quality.png',
                      width: 50,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Quality Assurance",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 68, 67, 67)),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 1,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/new/guarantee.png',
                      width: 50,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Purity Guarantee",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 68, 67, 67)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 1,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/new/100-per.png',
                      width: 50,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "100% Verify",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 68, 67, 67)),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _nineWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'UNG Gold EMI Benifits:',
          style: TextStyle(
              color: AppColor.bordercolor,
              fontSize: 14,
              fontWeight: FontWeight.w600),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  Widget showbenifitsbutton() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            showbenifits = true;
            setState(() {});
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Transform.scale(
                  scale: 0.7,
                  child: Checkbox(
                      value: showbenifits,
                      checkColor: const Color(0xff9c27b0),
                      activeColor: Colors.white,
                      onChanged: (value) {
                        setState(() {
                          showbenifits = value!;
                        });
                      })),
              Text('Show Benifits',
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: AppColor.greycolor)),
            ],
          ),
        ),
      ),
    );
  }

  Widget hidebenifitsbutton() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            showbenifits = false;
            setState(() {});
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                  value: showbenifits,
                  checkColor: const Color(0xff9c27b0),
                  activeColor: Colors.white,
                  onChanged: (value) {
                    setState(() {
                      showbenifits = value!;
                    });
                  }),
              Text('Hide Benifits',
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: AppColor.greycolor)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tenthWidget() {
    return Column(
        children: [_tenth1(), _tenth2(), _tenth3(), _tenth4(), _tenth5()]);
  }

  Widget _tenth1() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "\u2022",
            style: TextStyle(
              color: AppColor.bordercolor,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              'Purchase gold effortlessly with our convenient EMI (Equated Monthly Installment) option.',
              style: TextStyle(
                color: AppColor.bordercolor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tenth2() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "\u2022",
            style: TextStyle(
              color: AppColor.bordercolor,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              'Choose from flexible EMI plans tailored to suit your budget and preferences.',
              style: TextStyle(
                color: AppColor.bordercolor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _tenth3() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "\u2022",
            style: TextStyle(
              color: AppColor.bordercolor,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              'Benefit from low processing fees when you buy gold using our EMI option.',
              style: TextStyle(
                color: AppColor.bordercolor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _tenth4() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "\u2022",
            style: TextStyle(
              color: AppColor.bordercolor,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              'Our secure EMI payment gateway ensures the confidentiality of your financial information.',
              style: TextStyle(
                color: AppColor.bordercolor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _tenth5() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "\u2022",
            style: TextStyle(
              color: AppColor.bordercolor,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                'Make your gold purchase today and enjoy the convenience of spreading the cost over time.',
                style: TextStyle(
                  color: AppColor.bordercolor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              )),
        ],
      ),
    );
  }
}
