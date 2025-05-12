import 'package:UNGolds/constant/drawer_design.dart';
import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/constant/utility.dart';
import 'package:UNGolds/network/response/order_profit_response.dart';
import 'package:UNGolds/screens/homepage/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../constant/app_color.dart';
import '../../constant/login_drawer.dart';
import '../../constant/printmessage.dart';
import '../../constant/progressdialog.dart';
import '../../constant/snackbardesign.dart';
import '../../network/createjson.dart';
import '../../network/networkcall.dart';
import '../../network/networkutility.dart';
import '../../network/response/live_rate_response.dart';

bool nodata = false;
List<OrderprofitDatum> profitlist = [];
double totalProfit = 0.0;

class ProfitPage extends StatefulWidget {
  State createState() => ProfitPageState();
}

class ProfitPageState extends State<ProfitPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NetworkCallForLiveRate(true);
    Networkcallforprofitlist(true);
  }

  Future<void> NetworkCallForLiveRate(bool showprogress) async {
    try {
      if (showprogress == true) {
        ProgressDialog.showProgressDialog(context, "Loading");
      }
      Networkcall networkcall = Networkcall();
      List<Object?>? signup = await networkcall.getMethod(
          NetworkUtility.get_live_rate,
          NetworkUtility.get_live_rate_api,
          context);
      if (signup != null) {
        if (showprogress == true) {
          Navigator.pop(context);
        }
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
        if (showprogress == true) {
          Navigator.pop(context);
        }
        SnackBarDesign('Something went wrong!', context, AppColor.errorcolor,
            Colors.white);
      }
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), 'Networkcallforlogin', "OTP Verify", context);
    }
  }

  Future<void> Networkcallforprofitlist(bool showprogress) async {
    try {
      if (showprogress == true) {
        ProgressDialog.showProgressDialog(context, "Loading");
      }
      String createjson =
          CreateJson().createjsonforwithID(AppUtility.ID, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.profit_list,
          NetworkUtility.profit_list_api,
          createjson,
          context);
      if (list != null) {
        if (showprogress == true) {
          Navigator.pop(context);
        }

        List<Orderprofitresponse> response = List.from(list!);
        String status = response[0].status.toString();
        switch (status) {
          case "true":
            profitlist = response[0].data!;
            if (profitlist.isEmpty) {
              nodata = false;
            } else {
              for (int i = 0; i < profitlist.length; i++) {
                double purchaserate =
                    double.parse(profitlist[i].purchaseLiveRate!);
                double purchasegram = double.parse(profitlist[i].purchaseGram!);
                double purchaseprice = purchasegram * purchaserate;
                double todayspriceforyourpurchase =
                    AppUtility.pergramrate * purchasegram;
                double yourprofit = 0.0;
                if (purchaseprice > todayspriceforyourpurchase) {
                  yourprofit = 0.0;
                } else {
                  yourprofit = todayspriceforyourpurchase - purchaseprice;
                  totalProfit = totalProfit + yourprofit;
                  setState(() {});
                }
              }
              nodata = true;
            }
            setState(() {});
            break;
          case "false":
            nodata = false;
            setState(() {});

            break;
        }
      } else {
        nodata = false;
        setState(() {});
        if (showprogress == true) {
          Navigator.pop(context);
        }
      }
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), 'Networkcallforproductlist', "Buy Gold ", context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nodata = true;
    totalProfit = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        endDrawer: AppUtility.ID != "" ? CommonDrawer() : LoginDrawer(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          toolbarHeight: 70,
          backgroundColor: AppColor.bgcolor.withOpacity(0.2),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    'Profit'.introTitleText(context),
                  ],
                ).marginOnly(top: 10),
              ),
            ],
          ),
        ),
        body: Container(
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
          child: nodata
              ? BackdropFilter(
                  filter:
                      const ColorFilter.mode(Colors.white, BlendMode.softLight),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Total Profit: ",
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: AppColor.darkcolor),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            totalProfit.inRupeesFormat(),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColor.darkcolor),
                          ),
                        ],
                      ),
                      Expanded(child: listofprofit())
                    ],
                  ),
                )
              : BackdropFilter(
                  filter:
                      const ColorFilter.mode(Colors.white, BlendMode.softLight),
                  child: Center(
                    heightFactor: double.infinity,
                    widthFactor: double.infinity,
                    child: Column(
                      children: [
                        Lottie.asset('assets/images/payal.json'),
                        SizedBox(
                          height: height / 30,
                        ),
                        Text(
                          ' No profit details found ',
                          style: TextStyle(
                              fontSize: 20,
                              color: AppColor.darkcolor,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
        ));
  }

  Widget listofprofit() {
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(Duration(seconds: 1), () {
          setState(() {
            profitlist.clear();
            totalProfit = 0.0;
            NetworkCallForLiveRate(false);
            Networkcallforprofitlist(false);
          });
        });
      },
      child: ListView.builder(
        itemCount: profitlist.length,
        itemBuilder: (context, index) {
          double purchaserate =
              double.parse(profitlist[index].purchaseLiveRate!);
          double purchasegram = double.parse(profitlist[index].purchaseGram!);
          double purchaseprice = purchasegram * purchaserate;
          double todayspriceforyourpurchase =
              AppUtility.pergramrate * purchasegram;
          double yourprofit = 0.0;
          if (purchaseprice > todayspriceforyourpurchase) {
            yourprofit = 0.0;
          } else {
            totalProfit = totalProfit + yourprofit;
            yourprofit = todayspriceforyourpurchase - purchaseprice;
          }

          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              padding:
                  EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 0,
                    blurRadius: 2,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Your Profit: ",
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: AppColor.darkcolor),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          yourprofit.inRupeesFormat(),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColor.darkcolor),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Purchase Gram: ",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.bordercolor),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              profitlist[index].purchaseGram!,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.bordercolor),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Purchase Rate (per gram): ',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.bordercolor),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              double.parse(profitlist[index].purchaseLiveRate!)
                                  .inRupeesFormat(),
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.bordercolor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Order Date:',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: AppColor.bordercolor),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          DateFormat('dd-MM-yyyy')
                              .format(profitlist[index].paymentDate!),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppColor.bordercolor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
