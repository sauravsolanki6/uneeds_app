import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/constant/shared_pre.dart';
import 'package:UNGolds/constant/show_confirmation_dialog.dart';
import 'package:UNGolds/screens/bankdetailpage/bank_detail_list.dart';
import 'package:UNGolds/screens/bottom_navigation_bar.dart';
import 'package:UNGolds/screens/referralandearn/referal_customer_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../network/networkutility.dart';
import '../screens/bankdetailpage/bank_detail_page.dart';
import '../screens/bankdetailpage/kyc_detail_page.dart';
import '../screens/change_password_page/change_password_page.dart';
import '../screens/gold_order/buy_gold.dart';
import '../screens/gold_order/buy_gold_on_emi.dart';
import '../screens/gold_order/my_gold_order.dart';
import '../screens/login_page/login_page.dart';
import '../screens/profile_page/profile_details.dart';
import '../screens/referralandearn/referral_and_earn.dart';
import 'app_color.dart';
import 'button_design.dart';
import 'utility.dart';

class LoginDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return drawer(context);
  }

  Widget drawer(BuildContext context) {
    return Drawer(
      child: Container(
        width: double.infinity,
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 20,
                ),
                _listTile("Home", 0, context, "home"),
                _drawerSpace(),
                _listTile("Buy Gold", 1, context, "buy_gold"),
                _drawerSpace(),
                _listTile("Buy Gold On EMI", 2, context, 'buy_gold_on_emi'),
                _drawerSpace(),
                _listTile("About Us", 3, context, 'about_us'),
                _drawerSpace(),
                _listTile("Contact Us", 4, context, 'contact_us'),
                _drawerSpace(),
                _listTile("Terms And Conditions", 5, context, 'terms'),
                _drawerSpace(),
                _listTile("Privacy Policy", 6, context, 'privacy'),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 20.0, bottom: 15.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: AppColor.theamecolor,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0)),
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return LoginPage(false);
                              },
                            ));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Border radius for the ElevatedButton
                            ),
                          ),
                          child: 'LOGIN'.buttoText(),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _drawerSpace() {
    return const SizedBox(
      height: 0,
    );
  }

  Widget _listTile(String text, int i, BuildContext context, String icon) {
    IconData iconData = _getIconData(icon);
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
        margin: const EdgeInsets.only(left: 5, right: 5, top: 8, bottom: 15),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: AppColor.intoColor, width: 0.5))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(
                        iconData,
                        color: AppColor.bordercolor,
                      )),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  text,
                  style: TextStyle(
                      fontSize: 16,
                      color: AppColor.bordercolor,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Container(
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
                color: AppColor.bordercolor,
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        switch (i) {
          case 0:
            //My Gold Order
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return BottomNavigationBarPage();
              },
            ));
            break;
          case 1:
            //Buy Gold
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return BuyGold();
              },
            ));
            break;
          case 2:
            //Buy Gold On EMI
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return BuyGoldOnEMI();
              },
            ));
            break;
          case 3:
            // About Us
            _launchURL("aboutus-page");
            break;
          case 4:
            // Contact Us
            _launchURL("contact-us");
            break;
          case 5:
            // Contact Us
            _launchURL("terms-condition");
            break;
          case 6:
            // Contact Us
            _launchURL("privacy-policy");
            break;
        }
      },
    );
  }

  // void _launchURL(String url) async {
  //   await launch(NetworkUtility.base_api + url, forceWebView: true);
  // }
  void _launchURL(String url) async {
    String _url = NetworkUtility.base_api + url;
    //await launch(, forceWebView: true);
    await canLaunchUrl(Uri.parse(_url))
        ? await launchUrl(Uri.parse(_url))
        : throw 'Could not launch $_url';
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'home':
        return Icons.home;
      case 'buy_gold':
        return Icons.favorite_border;
      case 'buy_gold_on_emi':
        return Icons.shopping_cart_outlined;
      case 'about_us':
        return Icons.group;
      case 'contact_us':
        return Icons.contact_phone;
      case 'terms':
        return Icons.edit;
      case 'privacy':
        return Icons.privacy_tip;
      default:
        return Icons.error; // Return a default icon in case of an unknown icon
    }
  }
}
