import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/constant/printmessage.dart';
import 'package:UNGolds/constant/progressdialog.dart';
import 'package:UNGolds/constant/snackbardesign.dart';
import 'package:UNGolds/constant/utility.dart';
import 'package:UNGolds/network/createjson.dart';
import 'package:UNGolds/network/networkcall.dart';
import 'package:UNGolds/network/networkutility.dart';
import 'package:UNGolds/network/response/earn_history_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../constant/app_color.dart';
import '../../constant/textdesign.dart';

bool nodata = true, _isSearching = false;
List<EarnhistoryresponseDatum> EarnHistoryList = [];
List<EarnhistoryresponseDatum> _searchlist = [];

class EarnHistory extends StatefulWidget {
  State createState() => EarnHistoryState();
}

class EarnHistoryState extends State<EarnHistory> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Networkcallforearnhistory();
  }

  Future<void> Networkcallforearnhistory() async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading...");
      String createjson =
          CreateJson().createjsonforwithID(AppUtility.ID, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.earn_history,
          NetworkUtility.earn_history_api,
          createjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Earnhistoryresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            nodata = true;
            EarnHistoryList = response[0].data!;
            setState(() {});
            break;
          case "false":
            nodata = false;
            setState(() {});
            // SnackBarDesign(response[0].message!, context, AppColor.errorcolor,
            //     Colors.white);
            break;
        }
      } else {
        Navigator.pop(context);
        SnackBarDesign('Something went wrong!', context, AppColor.errorcolor,
            Colors.white);
      }
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), 'Networkcallforearnhistory', 'Earn History', context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nodata = false;
    EarnHistoryList.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  'Earn History'.introTitleText(context),
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
          child: nodata
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [_firstCardWidget(), Expanded(child: listview())],
                )
              : Center(
                  heightFactor: double.infinity,
                  widthFactor: double.infinity,
                  // child: Image.asset(
                  //   'assets/images/no_data_found.png',
                  // ),
                  child: Column(
                    children: [
                      Lottie.asset('assets/images/payal.json'),
                      Text(
                        ' No earn history found ',
                        style: TextStyle(
                            fontSize: 20,
                            color: AppColor.bordercolor,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Looks like you haven't earn yet ",
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
                  ),
                ),
        ),
      ),
    );
  }

  Widget _firstCardWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isSearching = !_isSearching;
          });
        },
        child: Container(
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
                            color: Colors.black,
                            decoration: TextDecoration.none),
                        onChanged: (val) {
                          _searchlist.clear();

                          for (var i in EarnHistoryList) {
                            if (i.name!
                                    .toLowerCase()
                                    .contains(val.toLowerCase()) ||
                                i.totalEarnPrice!.contains(val)) {
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
                    color: AppColor.bordercolor,
                  )),
              const SizedBox(
                width: 10,
              )
            ],
          ),
        ),
      ),
    ).marginOnly(left: 10, right: 10);
  }

  Widget listview() {
    return ListView.builder(
      itemCount: _isSearching ? _searchlist.length : EarnHistoryList.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Name : ',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColor.bordercolor),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Text(
                        _isSearching
                            ? _searchlist[index].name!
                            : EarnHistoryList[index].name!,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColor.bordercolor),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
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
                          ? double.parse(_searchlist[index].totalEarnPrice!)
                              .inRupeesFormat()
                          : double.parse(EarnHistoryList[index].totalEarnPrice!)
                              .inRupeesFormat(),
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColor.bordercolor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ).marginOnly(left: 10, right: 10);
  }
}
