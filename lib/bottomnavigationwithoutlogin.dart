import 'package:UNGolds/constant/snackbardesign.dart';
import 'package:UNGolds/constant/utility.dart';
import 'package:UNGolds/network/response/live_rate_response.dart';
import 'package:UNGolds/screens/bankdetailpage/kyc_detail_page.dart';
import 'package:UNGolds/screens/gold_order/buy_gold.dart';
import 'package:UNGolds/screens/gold_order/buy_gold_on_emi.dart';
import 'package:UNGolds/screens/gold_order/my_gold_order.dart';
import 'package:UNGolds/screens/homepage/home_page.dart';
import 'package:UNGolds/screens/login_page/login_page.dart';
import 'package:UNGolds/screens/login_page/profit_page.dart';
import 'package:UNGolds/screens/profile_page/profile_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/search_bar/gf_search_bar.dart';
import 'package:permission_handler/permission_handler.dart';
import '../constant/app_color.dart';
import '../constant/printmessage.dart';
import '../constant/progressdialog.dart';
import '../constant/show_confirmation_dialog.dart';
import '../network/networkcall.dart';
import '../network/networkutility.dart';

class BottomNavigationWithoutLogin extends StatefulWidget {
  const BottomNavigationWithoutLogin({Key? key}) : super(key: key);

  @override
  State<BottomNavigationWithoutLogin> createState() =>
      _BottomNavigationWithoutLoginState();
}

class _BottomNavigationWithoutLoginState
    extends State<BottomNavigationWithoutLogin> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestpermission();
    NetworkCallForLiveRate();
  }

  Future<void> requestpermission() async {
    Map<Permission, PermissionStatus> status = await [
      Permission.storage,
    ].request();
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

  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = [
    HomePage(),
    BuyGold(),
    BuyGoldOnEMI(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  closeApp() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      SystemNavigator.pop();
    });
  }

  showConfirmationDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialogDesign(
            description: "Are you sure? Do you want to exit the application?",
            nobuttonPressed: () {
              Navigator.pop(context);
            },
            yesbuttonPressed: () {
              closeApp();
            },
            title: "Confirmation",
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex == 0) {
          // showConfirmationDialog();
          return true;
        } else {
          _onItemTapped(0);
        }
        return false;
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height / 10,
          child: GestureDetector(
            child: BottomAppBar(
              color: Colors.white,
              shape: CircularNotchedRectangle(),
              notchMargin: 5,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 0;
                        if (_selectedIndex == 0) {
                          _onItemTapped(_selectedIndex);
                        }
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 20, top: 10),
                      child: Column(
                        children: [
                          Icon(
                            Icons.home,
                            color: _selectedIndex == 0
                                ? AppColor.intoColor
                                : AppColor.deselect,
                          ).marginOnly(bottom: 0),
                          Text('Home',
                              style: TextStyle(
                                  color: _selectedIndex == 0
                                      ? AppColor.intoColor
                                      : AppColor.deselect,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1;
                        if (_selectedIndex == 1) {
                          _onItemTapped(_selectedIndex);
                        }
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 10, top: 10),
                      child: Column(
                        children: [
                          Icon(
                            Icons.favorite_border_outlined,
                            color: _selectedIndex == 1
                                ? AppColor.intoColor
                                : AppColor.deselect,
                          ),
                          Text('Buy Gold',
                              style: TextStyle(
                                  color: _selectedIndex == 1
                                      ? AppColor.intoColor
                                      : AppColor.deselect,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 2;
                        if (_selectedIndex == 2) {
                          _onItemTapped(_selectedIndex);
                        }
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 10, top: 10),
                      child: Column(
                        children: [
                          Icon(
                            Icons.shopping_cart_outlined,
                            color: _selectedIndex == 2
                                ? AppColor.intoColor
                                : AppColor.deselect,
                          ).marginOnly(bottom: 0),
                          Text('Buy Gold On EMI',
                              style: TextStyle(
                                  color: _selectedIndex == 2
                                      ? AppColor.intoColor
                                      : AppColor.deselect,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
