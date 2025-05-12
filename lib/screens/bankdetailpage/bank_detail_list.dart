import 'package:UNGolds/constant/app_color.dart';
import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/constant/utility.dart';
import 'package:UNGolds/network/createjson.dart';
import 'package:UNGolds/network/response/bank_details_response.dart';
import 'package:UNGolds/network/response/bank_operation_response.dart';
import 'package:UNGolds/screens/bankdetailpage/add_bank_detail_page.dart';
import 'package:UNGolds/screens/bankdetailpage/bank_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../constant/button_design.dart';
import '../../constant/drawer_design.dart';
import '../../constant/printmessage.dart';
import '../../constant/progressdialog.dart';
import '../../constant/show_confirmation_dialog.dart';
import '../../constant/snackbardesign.dart';
import '../../constant/textdesign.dart';
import '../../network/networkcall.dart';
import '../../network/networkutility.dart';
import '../bottom_navigation_bar.dart';

class BankDetailList extends StatefulWidget {
  String getback;
  BankDetailList(this.getback);
  State createState() => BankDetailListState();
}

bool nodata = true, _isSearching = false;
List<BankdetailresponseDatum> _searchList = [];

class BankDetailListState extends State<BankDetailList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NetworkcallForBankDetailsList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    accountlist.clear();
    nodata = true;
  }

  List<BankdetailresponseDatum> accountlist = [];
  Future<void> NetworkcallForBankDetailsList() async {
    try {
      print(" your id " + AppUtility.ID);
      accountlist.clear();
      ProgressDialog.showProgressDialog(context, "Loading");
      String createjson =
          CreateJson().createjsonforwithID(AppUtility.ID, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? signup = await networkcall.postMethod(
          NetworkUtility.get_bank_details,
          NetworkUtility.get_bank_details_api,
          createjson,
          context);
      if (signup != null) {
        Navigator.pop(context);
        List<Bankdetailresponse> response = List.from(signup!);
        String status = response[0].status.toString();
        switch (status) {
          case "true":
            accountlist = response[0].data!;
            if (accountlist.isNotEmpty) {
              nodata = true;
            } else {
              nodata = false;
            }
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
        nodata = false;
        setState(() {});
        Navigator.pop(context);
        SnackBarDesign('Something went wrong!', context, AppColor.errorcolor,
            Colors.white);
      }
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), 'Networkcallforlogin', "OTP Verify", context);
    }
  }

  void onGoBack(value) {
    if (!mounted) {
      setState(() {});
    } else {
      NetworkcallForBankDetailsList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      endDrawer: CommonDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        leading: IconButton(
            onPressed: () {
              // Navigator.pushReplacement(context, MaterialPageRoute(
              //   builder: (context) {
              //     return BottomNavigationBarPage();
              //   },
              // ));
              Navigator.pop(context);
            },
            icon: Icon(CupertinoIcons.left_chevron)),
        elevation: 0,
        toolbarHeight: 70,
        backgroundColor: context.theme.cardColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  'Bank Details'.introTitleText(context),
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
      floatingActionButton: nodata
          ? FloatingActionButton(
              backgroundColor: AppColor.theamecolor,
              child: Icon(
                CupertinoIcons.add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return AddBankDetailPage();
                    },
                  ),
                ).then((value) {
                  onGoBack(value);
                });
              })
          : Container(),
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
                  children: [_firstCardWidget(), Expanded(child: listofbank())],
                ),
              )
            : BackdropFilter(
                filter:
                    const ColorFilter.mode(Colors.white, BlendMode.softLight),
                child: Center(
                  heightFactor: double.infinity,
                  widthFactor: double.infinity,
                  // child: Image.asset(
                  //   'assets/images/no_data_found.png',
                  // ),
                  child: Column(
                    children: [
                      Lottie.asset('assets/images/payal.json'),
                      SizedBox(
                        height: height / 30,
                      ),
                      Text(
                        ' No bank details found ',
                        style: TextStyle(
                            fontSize: 20,
                            color: AppColor.darkcolor,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Looks like you haven't add your bank details yet ",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColor.darkcolor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: ButtonDesign(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return AddBankDetailPage();
                                  },
                                ),
                              ).then((value) {
                                if (widget.getback == "1") {
                                  Navigator.pop(context);
                                } else {
                                  onGoBack(value);
                                }
                              });
                            },
                            child: 'Add Bank Details'.buttoText()),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _firstCardWidget() {
    return Container(
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
                    blurRadius: 2,
                    offset: Offset(0, 0),
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
                            _searchList.clear();
                            String accounttype = "";
                            if (val.contains("Saving Account".toLowerCase())) {
                              accounttype = "0";
                            } else if (val
                                .contains("Salary Account".toLowerCase())) {
                              accounttype = "1";
                            } else if (val
                                .contains("Current Account".toLowerCase())) {
                              accounttype = "2";
                            } else if (val.contains(
                                "Fixed Deposite Account".toLowerCase())) {
                              accounttype = "3";
                            } else if (val.contains(
                                "Recurring Deposite Account".toLowerCase())) {
                              accounttype = "4";
                            } else if (val
                                .contains("NRI Account".toLowerCase())) {
                              accounttype = "5";
                            }
                            for (var i in accountlist) {
                              if (i.bankName!
                                      .toLowerCase()
                                      .contains(val.toLowerCase()) ||
                                  i.accountNumber!.contains(val) ||
                                  i.accountType!
                                      .toLowerCase()
                                      .contains(accounttype) ||
                                  i.ifscCode!.contains(val)) {
                                _searchList.add(i);
                                setState(() {
                                  _searchList;
                                });
                              } else {
                                setState(() {
                                  _searchList;
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
                        _searchList.clear();
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

  int account = 0;

  Widget listofbank() {
    return ListView.builder(
      itemCount: _isSearching ? _searchList.length : accountlist.length,
      itemBuilder: (context, index) {
        String acconttypename = "";
        String accounttype = _isSearching
            ? _searchList[index].accountType!
            : accountlist[index].accountType!;
        if (accounttype == "0") {
          acconttypename = "Saving Account";
        } else if (accounttype == "1") {
          acconttypename = "Salary Account";
        } else if (accounttype == "2") {
          acconttypename = "Current Account";
        } else if (accounttype == "3") {
          acconttypename = "Fixed Deposite Account";
        } else if (accounttype == "4") {
          acconttypename = "Recurring Deposite Account";
        } else if (accounttype == "5") {
          acconttypename = "NRI Account";
        }
        String isprimary = _isSearching
            ? _searchList[index].account!
            : accountlist[index].account!;
        account = _isSearching
            ? int.parse(_searchList[index].account!)
            : int.parse(accountlist[index].account!);

        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return BankDetailPage(
                    index, _isSearching ? _searchList : accountlist);
              },
            ));
          },
          child: Padding(
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              _isSearching
                                  ? _searchList[index].bankName!
                                  : accountlist[index].bankName!,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.darkcolor),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              'Account Number : ${_isSearching ? _searchList[index].accountNumber! : accountlist[index].accountNumber!} ',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.bordercolor),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              'IFSC Code : ${_isSearching ? _searchList[index].ifscCode! : accountlist[index].ifscCode!} ',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.bordercolor),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              'Account Type : ${acconttypename} ',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.bordercolor),
                            ),
                          ),
                          isprimary == "1"
                              ? Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    'Primary Account',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.greencolor),
                                  ),
                                ).marginOnly(top: 2)
                              : Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    'Secondary Account',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.intoColor),
                                  ),
                                ).marginOnly(top: 2),
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          isprimary == "1"
                              ? SnackBarDesign(
                                  'Sorry! This is already primary account',
                                  context,
                                  AppColor.redcolor,
                                  Colors.white)
                              : Showconfirmatondialog(
                                  _isSearching
                                      ? _searchList[index].id!
                                      : accountlist[index].id!,
                                  NetworkUtility.change_bank_account_api,
                                  "Are you sure? You want to change primary account? ",
                                  1);
                        },
                        icon: Icon(
                          CupertinoIcons.check_mark_circled,
                          color: account == 1
                              ? AppColor.greencolor
                              : AppColor.intoColor,
                        )),
                    IconButton(
                        onPressed: () {
                          isprimary == "1"
                              ? SnackBarDesign(
                                  'Sorry! Not allow to delete primary account',
                                  context,
                                  AppColor.redcolor,
                                  Colors.white)
                              : Showconfirmatondialog(
                                  _isSearching
                                      ? _searchList[index].id!
                                      : accountlist[index].id!,
                                  NetworkUtility.delete_bank_account_api,
                                  "Are you sure? You want to delete bank account details ? ",
                                  2);
                        },
                        icon: Icon(
                          CupertinoIcons.delete,
                          color: AppColor.bordercolor,
                        )),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Showconfirmatondialog(String tableid, String api, String dec, int type) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialogDesign(
            description: dec,
            nobuttonPressed: () {
              Navigator.pop(context);
            },
            yesbuttonPressed: () {
              Navigator.pop(context);
              NetworkCallForBankOperation(tableid, api, type);
            },
            title: "Confirmation",
          );
        });
  }

  Future<void> NetworkCallForBankOperation(
      String tableid, String api, int type) async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading...");
      String createjson = CreateJson()
          .createjsonforbankoperation(context, AppUtility.ID, tableid);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.change_bank_account, api, createjson, context);
      if (list != null) {
        Navigator.pop(context);
        List<Bankaccountoperationresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            if (type == 1) {
              SnackBarDesign('Account made as primary successfully!', context,
                  AppColor.sucesscolor, Colors.white);
            } else {
              SnackBarDesign('Bank account deleted successfully!', context,
                  AppColor.sucesscolor, Colors.white);
            }

            break;
          case "false":
            if (type == 1) {
              SnackBarDesign('Failed to make account primary!', context,
                  AppColor.errorcolor, Colors.white);
            } else {
              SnackBarDesign('Failed to delete account', context,
                  AppColor.errorcolor, Colors.white);
            }

            break;
        }
        NetworkcallForBankDetailsList();
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      PrintMessage.printmessage(e.toString(), 'NetworkCallForSubmitKYCForm',
          'Stepper For KYC', context);
    }
  }
}
