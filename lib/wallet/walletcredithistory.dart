import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/constant/printmessage.dart';
import 'package:UNGolds/constant/progressdialog.dart';
import 'package:UNGolds/constant/utility.dart';
import 'package:UNGolds/network/createjson.dart';
import 'package:UNGolds/network/networkcall.dart';
import 'package:UNGolds/network/networkutility.dart';
import 'package:UNGolds/network/response/walletdebithistoryresponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../constant/app_color.dart';
import '../constant/textdesign.dart';
import '../network/response/walletcreadithistory.dart';

List<WalletcreadithstoryDatum> walletdebithistory = [];
List<WalletcreadithstoryDatum> _searchlist = [];
bool nodata = false, _isSearching = false;

class Walletcredithistory extends StatefulWidget {
  State createState() => WalletcredithistoryState();
}

class WalletcredithistoryState extends State<Walletcredithistory> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Networkcallforgetwalletcreadithistory();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    walletdebithistory.clear();
    nodata = false;
    _isSearching = false;
    _searchlist.clear();
  }

  Future<void> Networkcallforgetwalletcreadithistory() async {
    try {
      String createjson = CreateJson()
          .createjsonforgetwalletdebithistory(AppUtility.ID, context);
      ProgressDialog.showProgressDialog(context, " title");
      List<Object?>? list = await Networkcall().postMethod(
          NetworkUtility.api_wallet_credit_history,
          NetworkUtility.api_wallet_credit_history_url,
          createjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Walletcreadithstoryresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            walletdebithistory = response[0].data!;
            if (walletdebithistory.length > 0) {
              nodata = true;
            } else {
              nodata = false;
            }
            setState(() {});
            break;
          case "false":
            nodata = false;
            setState(() {});
            break;
        }
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(),
          "Networkcallforgetwalletdebithistory",
          "Wallet Debit History",
          context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
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
                  'Wallet Credit History'.introTitleText(context),
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
            child: nodata
                ? Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _firstCardWidget(),
                        Expanded(child: listview()),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  )
                : Center(
                    child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Lottie.asset('assets/images/payal.json',
                            height:
                                (MediaQuery.of(context).size.height / 2) - 200),
                        Text(
                          ' No wallet credit history found ',
                          style: TextStyle(
                              fontSize: 20,
                              color: AppColor.bordercolor,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Looks like you haven't wallet credit history yet ",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColor.bordercolor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )),
          ),
        ),
      ),
    );
  }

  Widget _firstCardWidget() {
    return Container(
      //  margin: EdgeInsets.only(left: 10, right: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              _isSearching = !_isSearching;
            });
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 0,
                    blurRadius: 1,
                    offset: Offset(1, 1),
                  ),
                ],
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                  height: 50,
                ),
                _isSearching
                    ? Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search here...',
                              hintStyle: TextDesign.hinttext),
                          autofocus: true,
                          style: const TextStyle(
                              fontSize: 14,
                              letterSpacing: 0.5,
                              color: Colors.black),
                          onChanged: (val) {
                            _searchlist.clear();

                            for (var i in walletdebithistory) {
                              if (double.parse(i.amount!)
                                      .toString()
                                      .contains(val) ||
                                  (i.remark!)
                                      .toLowerCase()
                                      .contains(val.toLowerCase()) ||
                                  (i.transactionNumber!)
                                      .toLowerCase()
                                      .contains(val.toLowerCase()) ||
                                  (i.paymentMode!)
                                      .toLowerCase()
                                      .contains(val.toLowerCase()) ||
                                  DateFormat('dd-MM-yyyy')
                                      .format(i.payemntDate!)
                                      .contains(val) ||
                                  i.amountBy!.contains(
                                      val.toLowerCase() == 'admin'
                                          ? "0"
                                          : "1")) {
                                _searchlist.add(i);
                                setState(() {
                                  _searchlist;
                                });
                              } else {
                                setState(() {
                                  _searchlist;
                                });
                              }
                            }
                          },
                        ),
                      )
                    : Text(
                        'Search Here...',
                        style: TextDesign.hinttext,
                      ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _isSearching = !_isSearching;
                        _searchlist.clear();
                      });
                    },
                    icon: Icon(
                      _isSearching
                          ? CupertinoIcons.clear_circled_solid
                          : Icons.search,
                      color: AppColor.intoColor,
                    )),
                const SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget listview() {
    List<WalletcreadithstoryDatum> list =
        _isSearching ? _searchlist : walletdebithistory;
    return list.length > 0
        ? ListView.builder(
            itemCount:
                _isSearching ? _searchlist.length : walletdebithistory.length,
            itemBuilder: (context, index) {
              String addby = _isSearching
                  ? _searchlist[index].amountBy!
                  : walletdebithistory[index].amountBy!;
              return Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Amount : ',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.bordercolor),
                              ),
                              Text(
                                _isSearching
                                    ? double.parse(_searchlist[index].amount!)
                                        .inRupeesFormat()
                                    : double.parse(
                                            walletdebithistory[index].amount!)
                                        .inRupeesFormat(),
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.bordercolor),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Transaction Number : ',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.bordercolor),
                              ),
                              Text(
                                _isSearching
                                    ? _searchlist[index].transactionNumber!
                                    : walletdebithistory[index]
                                        .transactionNumber!,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.bordercolor),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Transfer/ Add By : ',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.bordercolor),
                              ),
                              Text(
                                addby == "0" ? 'Admin' : "Own",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.bordercolor),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Date : ',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.bordercolor),
                              ),
                              Text(
                                _isSearching
                                    ? DateFormat('dd-MM-yyyy')
                                        .format(_searchlist[index].payemntDate!)
                                    : DateFormat('dd-MM-yyyy').format(
                                        walletdebithistory[index].payemntDate!),
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.bordercolor),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Payment Mode : ',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColor.bordercolor),
                          ),
                          Expanded(
                            child: Text(
                              _isSearching
                                  ? _searchlist[index].paymentMode!
                                  : walletdebithistory[index].paymentMode!,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.bordercolor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ).marginOnly(left: 5, right: 5)
        : Center(
            heightFactor: 100,
            widthFactor: 100,
            child: Column(
              children: [
                Lottie.asset('assets/images/payal.json'),
                Text(
                  ' No wallet credit history found ',
                  style: TextStyle(
                      fontSize: 20,
                      color: AppColor.bordercolor,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Looks like you haven't wallet credit history yet ",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColor.bordercolor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ));
  }
}
