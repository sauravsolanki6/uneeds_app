import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/network/response/walletamountresponse.dart';
import 'package:UNGolds/network/response/walletcreadithistory.dart';
import 'package:UNGolds/wallet/walletcredithistory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../constant/app_color.dart';
import '../constant/button_design.dart';
import '../constant/drawer_design.dart';
import '../constant/printmessage.dart';
import '../constant/progressdialog.dart';
import '../constant/snackbardesign.dart';
import '../constant/textdesign.dart';
import '../constant/utility.dart';
import '../network/createjson.dart';
import '../network/networkcall.dart';
import '../network/networkutility.dart';
import 'walletdebithistory.dart';

class WalletMain extends StatefulWidget {
  State createState() => WalletmainState();
}

class WalletmainState extends State<WalletMain> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Networkcallforwalletamount();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    creaditamount = 0.0;
    debitamount = 0.0;
    walletbalanceamount = 0.0;
  }

  double creaditamount = 0.0, debitamount = 0.0, walletbalanceamount = 0.0;
  Future<void> Networkcallforwalletamount() async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading");
      String createjson = CreateJson()
          .createjsonforgetwalletdebithistory(AppUtility.ID, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.api_user_wallet_amount,
          NetworkUtility.api_user_wallet_amount_url,
          createjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Walletamountesponse> response = List.from(list!);
        String status = response[0].status.toString();
        switch (status) {
          case "true":
            creaditamount = double.parse(response[0].creditWalletAmount!);
            debitamount = double.parse(response[0].debitWalletAmount!);

            walletbalanceamount =
                double.parse(response[0].balanceWalletAmount!);
            setState(() {});
            break;
          case "false":
            SnackBarDesign(
                'No data found!', context, AppColor.errorcolor, Colors.white);

            break;
        }
      } else {
        SnackBarDesign('Something went wrong!', context, AppColor.errorcolor,
            Colors.white);

        Navigator.pop(context);
      }
    } catch (e) {
      PrintMessage.printmessage(e.toString(), 'Networkcallforreferandearn',
          "Refer And Earn ", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      endDrawer: CommonDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(CupertinoIcons.left_chevron)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  'My Wallet'.introTitleText(context),
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 0,
                          blurRadius: 1,
                          offset: Offset(1, 1),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'My Wallet',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              ),
                              // Column(
                              //   children: [
                              //     InkWell(
                              //       child: Text(
                              //         'Wallet Credit History',
                              //         style: TextStyle(
                              //             decoration: TextDecoration.underline,
                              //             color: AppColor.theamecolor,
                              //             fontSize: 12),
                              //       ),
                              //       onTap: () {
                              //         Navigator.push(context, MaterialPageRoute(
                              //           builder: (context) {
                              //             return Walletcredithistory();
                              //           },
                              //         ));
                              //       },
                              //     ),
                              //     InkWell(
                              //       child: Text(
                              //         'Wallet Debit History',
                              //         style: TextStyle(
                              //             decoration: TextDecoration.underline,
                              //             color: AppColor.theamecolor,
                              //             fontSize: 12),
                              //       ),
                              //       onTap: () {
                              //         Navigator.push(context, MaterialPageRoute(
                              //           builder: (context) {
                              //             return Walletdebithistory();
                              //           },
                              //         ));
                              //       },
                              //     ),
                              //   ],
                              // )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text('Credit Wallet Amount',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: AppColor.bordercolor,
                                      )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text('${creaditamount.inRupeesFormat()}',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: AppColor.bordercolor,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                              Column(
                                children: [
                                  Text('Debit Wallet Amount',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: AppColor.bordercolor,
                                      )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text('${debitamount.inRupeesFormat()}',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: AppColor.bordercolor,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                              Column(
                                children: [
                                  Text('Balance Wallet Amount',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: AppColor.bordercolor,
                                      )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      '${walletbalanceamount.inRupeesFormat()}',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: AppColor.bordercolor,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
                Center(
                    child: Lottie.asset('assets/images/walletf.json',
                        height: 300)),
                SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      ButtonDesign(
                          onPressed: () async {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return Walletcredithistory();
                              },
                            ));
                          },
                          child: 'Wallet Credit History'.buttoText()),
                      ButtonDesign(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return Walletdebithistory();
                              },
                            ));
                          },
                          child: 'Wallet Debit History'.buttoText()),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ],
            ).marginOnly(left: 10, right: 10),
          ),
        ),
      ),
    );
  }

  // Widget _firstCardWidget() {
  //   return Container(
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: GestureDetector(
  //         onTap: () {
  //           setState(() {
  //             _isSearching = !_isSearching;
  //           });
  //         },
  //         child: Container(
  //           decoration: BoxDecoration(
  //               color: Colors.white,
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.black.withOpacity(0.2),
  //                   spreadRadius: 0,
  //                   blurRadius: 1,
  //                   offset: Offset(1, 1),
  //                 ),
  //               ],
  //               borderRadius: BorderRadius.circular(10)),
  //           child: Row(
  //             children: [
  //               const SizedBox(
  //                 width: 10,
  //                 height: 50,
  //               ),
  //               _isSearching
  //                   ? Expanded(
  //                       child: TextField(
  //                         decoration: InputDecoration(
  //                             border: InputBorder.none,
  //                             hintText: 'Search here...',
  //                             hintStyle: TextDesign.hinttext),
  //                         autofocus: true,
  //                         style: const TextStyle(
  //                             fontSize: 14,
  //                             letterSpacing: 0.5,
  //                             color: Colors.black),
  //                         onChanged: (val) {
  //                           _searchlist.clear();

  //                           for (var i in walletdebithistory) {
  //                             if (i.amount!.contains(val) ||
  //                                 (i.remark!)
  //                                     .toLowerCase()
  //                                     .contains(val.toLowerCase()) ||
  //                                 (i.transactionNumber!).contains(val) ||
  //                                 (i.paymentMode!)
  //                                     .toLowerCase()
  //                                     .contains(val.toLowerCase()) ||
  //                                 DateFormat('dd-MM-yyyy')
  //                                     .format(i.payemntDate!)
  //                                     .contains(val) ||
  //                                 (i.amountBy!).contains(
  //                                     val.toLowerCase() == "admin"
  //                                         ? "0"
  //                                         : "1")) {
  //                               _searchlist.add(i);
  //                               setState(() {
  //                                 _searchlist;
  //                               });
  //                             } else {
  //                               setState(() {
  //                                 _searchlist;
  //                               });
  //                             }
  //                           }
  //                         },
  //                       ),
  //                     )
  //                   : Text(
  //                       'Search Here...',
  //                       style: TextDesign.hinttext,
  //                     ),
  //               const Spacer(),
  //               IconButton(
  //                   onPressed: () {
  //                     setState(() {
  //                       _isSearching = !_isSearching;
  //                       _searchlist.clear();
  //                     });
  //                   },
  //                   icon: Icon(
  //                     _isSearching
  //                         ? CupertinoIcons.clear_circled_solid
  //                         : Icons.search,
  //                     color: AppColor.intoColor,
  //                   )),
  //               const SizedBox(
  //                 width: 10,
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
