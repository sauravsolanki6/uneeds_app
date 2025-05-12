import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/constant/progressdialog.dart';
import 'package:UNGolds/constant/shared_pre.dart';
import 'package:UNGolds/constant/show_confirmation_dialog.dart';
import 'package:UNGolds/constant/snackbardesign.dart';
import 'package:UNGolds/network/response/deleteaccoutresponse.dart';
import 'package:UNGolds/screens/Splashscreen/Splash_Screen.dart';
import 'package:UNGolds/screens/bankdetailpage/bank_detail_list.dart';
import 'package:UNGolds/screens/bottom_navigation_bar.dart';
import 'package:UNGolds/screens/referralandearn/referal_customer_list.dart';
import 'package:UNGolds/wallet/walletmain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../network/createjson.dart';
import '../network/networkcall.dart';
import '../network/networkutility.dart';
import '../screens/bankdetailpage/bank_detail_page.dart';
import '../screens/bankdetailpage/kyc_detail_page.dart';
import '../screens/change_password_page/change_password_page.dart';
import '../screens/gold_order/my_gold_order.dart';
import '../screens/login_page/login_page.dart';
import '../screens/profile_page/profile_details.dart';
import '../screens/referralandearn/referral_and_earn.dart';
import 'app_color.dart';
import 'button_design.dart';
import 'utility.dart';

class CommonDrawer extends StatelessWidget {
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
                Column(
                  children: [
                    Container(
                      color: AppColor.intoColor,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 25, 8, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                CupertinoIcons.right_chevron,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              child: Flexible(
                                child: Text(
                                  AppUtility.NAME,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 26, 29, 34),
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Colors.grey.shade200,
                              child: CircleAvatar(
                                radius: 20.0,
                                backgroundColor: Colors.grey.withOpacity(0.1),
                                backgroundImage: const AssetImage(
                                    'assets/images/ic_launcher.png'),
                              ),
                            ),

                            // IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.power))
                          ],
                        ),
                      ),
                    ),
                    Container(
                      // padding: const EdgeInsets.only(top: 20),
                      // decoration: BoxDecoration(
                      //   gradient: LinearGradient(
                      //     begin: Alignment.topLeft,
                      //     end: Alignment.topRight,
                      //     colors: [
                      //       AppColor.intoColor.withOpacity(0.2),
                      //       AppColor.theamecolor.withOpacity(0.2)
                      //     ], // Adjust the colors as needed
                      //   ),
                      // ),
                      width: double.infinity,
                      child: Column(
                        children: [
                          _listTile("Home", 0, context, "home"),
                          _drawerSpace(),
                          _listTile("My Gold / Pay EMI", 1, context, "abc"),
                          _drawerSpace(),
                          _listTile("My KYC", 2, context, 'kyc'),
                          _drawerSpace(),
                          _listTile("My Wallet", 14, context, 'wallet'),
                          _drawerSpace(),
                          _listTile("Referral And Earn", 3, context, 'people'),
                          _drawerSpace(),
                          _listTile(
                              "All Referral Customer", 9, context, 'people'),
                          _drawerSpace(),
                          _listTile("My Bank Details", 4, context, 'bank'),
                          _drawerSpace(),
                          _listTile("My Profile", 5, context, 'profile'),
                          _drawerSpace(),
                          _listTile("My Vendor", 6, context, 'vender'),
                          _drawerSpace(),
                          _listTile("Change Password", 7, context, 'password'),
                          _drawerSpace(),
                          _listTile("About Us", 10, context, 'about_us'),
                          _drawerSpace(),
                          _listTile("Contact Us", 11, context, 'contact_us'),
                          _drawerSpace(),
                          _listTile(
                              "Terms And Conditions", 12, context, 'terms'),
                          _drawerSpace(),
                          _listTile("Privacy Policy", 13, context, 'privacy'),
                          AppUtility.MobileNumber == "9766869071"
                              ? _listTile(
                                  "Delete Account", 15, context, 'delete')
                              : Container(),
                        ],
                      ),
                    ),
                  ],
                ),
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
                            showConfirmationDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Border radius for the ElevatedButton
                            ),
                          ),
                          child: 'LOG OUT'.buttoText(),
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
            //My Gold Order
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return MyGoldOrder();
              },
            ));
            break;
          case 2:
            //My KYC
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return KYCDetailPage("0");
              },
            ));
            break;
          case 3: //Referral And Earn
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return ReferralAndEarn();
              },
            ));

            break;
          case 4: //My Bank Details
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return BankDetailList("0");
              },
            ));
            break;
          case 5:
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return ProfileDetails();
              },
            ));
            break;
          case 6: //My Vendor
            // showToast("You are not allowed", AppColor.errorcolor);
            SnackBarDesign("You are not allowed", context, AppColor.errorcolor,
                Colors.white);
            break;
          case 7: //Setting
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const ChangePasswordPage();
              },
            ));
            break;
          case 8: //Logout
            showConfirmationDialog(context);
            break;
          case 9:
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return ReferalCustomerList();
              },
            ));
            break;
          case 10:
            // About Us
            _launchURL("aboutus-page");
            break;
          case 11:
            // Contact Us
            _launchURL("contact-us");
            break;
          case 12:
            // Contact Us
            _launchURL("terms-condition");
            break;
          case 13:
            // Contact Us
            _launchURL("privacy-policy");
            break;
          case 14:
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return WalletMain();
              },
            ));
            break;
          case 15:
            showConfirmationDialogDeleteAccount(context);
            break;
        }
      },
    );
  }

  // void _launchURL(String url) async {
  //   String _url = NetworkUtility.base_api + url;
  //   await launchUrl(Uri.parse(_url));
  // }

  void _launchURL(String url) async {
    String _url = NetworkUtility.base_api + url;
    //await launch(, forceWebView: true);
    await canLaunchUrl(Uri.parse(_url))
        ? await launchUrl(Uri.parse(_url))
        : throw 'Could not launch $_url';
  }

  void showToast(String message, Color backgroundColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor.withOpacity(0.2),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  showConfirmationDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialogDesign(
            description: "Are you sure? Do you want to logout ?",
            nobuttonPressed: () {
              Navigator.pop(context);
            },
            yesbuttonPressed: () {
              SharedPreference().savevalueonlogin("", "", "", "", context);
              updateSecondValue("");
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                builder: (context) {
                  return LoginPage(false);
                },
              ), (route) => false);
            },
            title: "Confirmation",
          );
        });
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'home':
        return Icons.home;
      case 'abc':
        return Icons.account_balance_wallet_rounded;
      case 'kyc':
        return Icons.laptop_mac_rounded;
      case 'people':
        return Icons.people;
      case 'bank':
        return Icons.account_balance;
      case 'password':
        return Icons.password_rounded;
      case 'profile':
        return Icons.account_circle_rounded;
      case 'vender':
        return Icons.people_alt_outlined;
      case 'about_us':
        return Icons.group;
      case 'contact_us':
        return Icons.contact_phone;
      case 'terms':
        return Icons.edit;
      case 'privacy':
        return Icons.privacy_tip;
      case 'delete':
        return Icons.delete;
      case 'wallet':
        return Icons.wallet;
      default:
        return Icons.error; // Return a default icon in case of an unknown icon
    }
  }

  showConfirmationDialogDeleteAccount(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialogDesign(
            description: "Are you sure?  Do you want to delete account ?",
            nobuttonPressed: () {
              Navigator.pop(context);
            },
            yesbuttonPressed: () {
              // SharedPreference().savevalueonlogin("", "", "", "", context);
              // updateSecondValue("");
              // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
              //   builder: (context) {
              //     return LoginPage(false);
              //   },
              // ), (route) => false);
              Networkcallfordeleteaccount(context);
            },
            title: "Confirmation",
          );
        });
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: MediaQuery.of(context).viewInsets,
          color: Colors.transparent,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Wrap(
              children: [
                ClipRect(
                  child: Container(
                    padding: EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Delete Account",
                          style: GoogleFonts.inter(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: AppColor.theamecolor,
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 1,
                          color: Colors.grey[300], // Horizontal gray line
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Are you sure you want to delete account?",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              // Use Expanded for Cancel button
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Close the modal
                                },
                                style: ButtonStyle(
                                  side: MaterialStateProperty.resolveWith<
                                      BorderSide>(
                                    (Set<MaterialState> states) {
                                      return BorderSide(
                                          color:
                                              Colors.grey[300]!); // Gray border
                                    },
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Cancel',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                                width: 50), // Adjust spacing between buttons
                            Expanded(
                              // Use Expanded for Yes, logout button
                              child: ElevatedButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  Networkcallfordeleteaccount(context);
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(AppColor
                                              .theamecolor // Blue background
                                          ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Yes, Delete',
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> Networkcallfordeleteaccount(BuildContext context) async {
    try {
      String jsonstring =
          CreateJson().createjsonfordelete(AppUtility.ID, context);
      // ProgressDialog.showProgressDialog(context, "title");
      List<Object?>? list = await Networkcall().postMethod(
          NetworkUtility.api_delete_account,
          NetworkUtility.api_delete_account_url,
          jsonstring,
          context);
      if (list != null) {
        // Navigator.pop(context);
        List<Deleteaccountresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            // SnackBarDesign("Account deleted successfully!", context,
            //     AppColor.sucesscolor, Colors.white);
            //  SharedPreferences idsaver = await SharedPreferences.getInstance();
            //await idsaver.clear();
            SharedPreference().savevalueonlogin("", "", "", "", context);
            updateSecondValue("");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage(false)),
            );

            break;
          case "false":
            SnackBarDesign(response[0].message!, context, AppColor.errorcolor,
                Colors.white);
            break;
        }
      } else {
        // Navigator.pop(context);
        SnackBarDesign("Something went wrong!", context, AppColor.errorcolor,
            Colors.white);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
