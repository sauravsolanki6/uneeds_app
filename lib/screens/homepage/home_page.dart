import 'package:UNGolds/constant/drawer_design.dart';
import 'package:UNGolds/constant/login_drawer.dart';
import 'package:UNGolds/constant/show_confirmation_dialog.dart';

import 'package:UNGolds/screens/gold_order/buy_gold.dart';

import 'package:UNGolds/screens/gold_order/buy_gold_on_emi_check.dart';
import 'package:UNGolds/screens/gold_order/buy_now.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../annimation/blinking_annimation.dart';
import '../../constant/app_color.dart';

import '../../constant/printmessage.dart';
import '../../constant/progressdialog.dart';
import '../../constant/shared_pre.dart';
import '../../constant/snackbardesign.dart';
import '../../constant/textdesign.dart';
import '../../constant/utility.dart';
import '../../constant/extension.dart';
import '../../dbhelper.dart';
import '../../network/createjson.dart';
import '../../network/networkcall.dart';
import '../../network/networkutility.dart';
import '../../network/response/get_profile_response.dart';
import '../../network/response/live_rate_response.dart';
import '../../network/response/product_list_response.dart';
import '../gold_order/buy_gold_on_emi.dart';
import 'pageview_homepage.dart';

int selectedIndex = 0;

class HomeScreenController extends GetxController {
  Rx<PageController> pageController = PageController().obs;
  RxInt selectedIndex = 0.obs;

  onChang(int index) {
    selectedIndex.value = index;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // getUser();
  }
}

int limit = 10, index = 0;
bool nodata = false;
List<ProductlistresponseDatum> productlist = [];
List<ProductlistresponseDatum> searchproductlist = [];
final FocusNode _focusNode = FocusNode();

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool switchValue = true;
  double bookingAmount = 0.0, processingfees = 0.0, membersheepfees = 0.0;
  String membersheeptype = "",
      membersheepstatus = "",
      proceesingfeesgst = "0.0",
      makingcharge = "",
      makinggst = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productlist.clear();
    getvalue();
    NetworkcallForgetprofiledetails();
    NetworkCallForLiveRate(true);
    Networkcallforproductlist(index, true, "recent", "");
  }

  Future<void> NetworkcallForgetprofiledetails() async {
    try {
      String createjson =
          CreateJson().createjsonforwithID(AppUtility.ID, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? signup = await networkcall.postMethod(
          NetworkUtility.get_onward_profile,
          NetworkUtility.get_onward_profile_api,
          createjson,
          context);
      if (signup != null) {
        List<Getprofileresponse> profileresponse = List.from(signup!);
        String status = profileresponse[0].status.toString();
        switch (status) {
          case "true":
            AppUtility.NAME = profileresponse[0].data![0].firstName! +
                " " +
                profileresponse[0].data![0].lastName!;
            SharedPreference().savevalueonlogin(
                AppUtility.ID,
                profileresponse[0].data![0].firstName! +
                    " " +
                    profileresponse[0].data![0].lastName!,
                profileresponse[0].data![0].mobile!,
                profileresponse[0].data![0].password!,
                context);

            setState(() {});
            break;
          case "false":
            break;
        }
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  getvalue() async {
    DatabaseHelper db = DatabaseHelper();
    String? value = await db.getValueById(1);

    if (value != null) {
      AppUtility.MobileNumber = value;
      print("Retrieved value: $value");
    } else {
      print("No value found");
    }
  }

  Future<void> NetworkCallForLiveRate(bool showprogress) async {
    try {
      if (showprogress) ProgressDialog.showProgressDialog(context, "Loading");
      Networkcall networkcall = Networkcall();
      List<Object?>? signup = await networkcall.getMethod(
          NetworkUtility.get_live_rate,
          NetworkUtility.get_live_rate_api,
          context);
      if (signup != null) {
        if (showprogress) Navigator.pop(context);
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
        if (showprogress) Navigator.pop(context);
        SnackBarDesign('Something went wrong!', context, AppColor.errorcolor,
            Colors.white);
      }
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), 'Networkcallforlogin', "OTP Verify", context);
    }
  }

  Future<void> Networkcallforproductlist(int index, bool showprogress,
      String producttype, String searchtext) async {
    try {
      if (showprogress) ProgressDialog.showProgressDialog(context, "Loading");
      String createjson = CreateJson().createjsonforproductlist(
          index, context, limit, producttype, searchtext);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.product_list,
          NetworkUtility.product_list_api,
          createjson,
          context);
      if (list != null) {
        if (showprogress) Navigator.pop(context);

        List<Productlistresponse> response = List.from(list!);
        String status = response[0].status.toString();
        switch (status) {
          case "true":
            productlist = response[0].data!;
            if (productlist.isEmpty) {
              nodata = false;
            } else {
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
        setState(() {
          nodata = false;
        });
        if (showprogress) Navigator.pop(context);
      }
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), 'Networkcallforproductlist', "Buy Gold ", context);
    }
  }

  Future<void> NetworkcallforSearchproductlist(int index, bool showprogress,
      String producttype, String searchtext) async {
    try {
      if (showprogress) ProgressDialog.showProgressDialog(context, "Loading");
      String createjson = CreateJson().createjsonforproductlist(
          index, context, limit, producttype, searchtext);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.product_list,
          NetworkUtility.product_list_api,
          createjson,
          context);
      if (list != null) {
        if (showprogress) Navigator.pop(context);

        List<Productlistresponse> response = List.from(list!);
        String status = response[0].status.toString();
        switch (status) {
          case "true":
            searchproductlist = response[0].data!;
            if (searchproductlist.isEmpty) {
              nodata = false;
            } else {
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
        setState(() {
          nodata = false;
        });
        if (showprogress) Navigator.pop(context);
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
    nodata = false;
    productlist.clear();
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
              SystemNavigator.pop();
            },
            title: "Confirmation",
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final homeController = Get.put(HomeScreenController());

    return WillPopScope(
      onWillPop: () => showConfirmationDialog(),
      child: Scaffold(
        endDrawer: AppUtility.ID != "" ? CommonDrawer() : LoginDrawer(),
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          toolbarHeight: 80,
          elevation: 0,
          backgroundColor: AppColor.bgcolor.withOpacity(0.1),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: 'Welcome'.TegSubText(),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Text(
                      AppUtility.NAME,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ).marginOnly(right: 80),
            ],
          ),
        ),
        body: GestureDetector(
          onTap: () {
            searchp.clear();
            searchproductlist.clear();
            _focusNode.unfocus();
            setState(() {});
          },
          child: RefreshIndicator(
            onRefresh: () {
              return Future.delayed(const Duration(seconds: 1), () {
                NetworkCallForLiveRate(false);
                Networkcallforproductlist(0, false, "recent", "");
                NetworkcallForgetprofiledetails();
              });
            },
            child: SingleChildScrollView(
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
                  filter:
                      const ColorFilter.mode(Colors.white, BlendMode.softLight),
                  child: Column(
                    children: [
                      Container(
                        height: height / 60,
                      ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //       color: Colors.white,
                      //       boxShadow: [
                      //         BoxShadow(
                      //           color: Colors.black.withOpacity(0.2),
                      //           spreadRadius: 0,
                      //           blurRadius: 1,
                      //           offset: const Offset(1, 1),
                      //         ),
                      //       ],
                      //       borderRadius: BorderRadius.circular(10)),
                      //   margin: const EdgeInsets.only(
                      //     left: 15,
                      //     right: 15,
                      //   ),
                      //   child: TextField(
                      //     onTap: () {
                      //       // Navigator.push(context, MaterialPageRoute(
                      //       //   builder: (context) {
                      //       //     return BuyGold();
                      //       //   },
                      //       // ));
                      //       _focusNode.requestFocus();
                      //     },
                      //     textAlignVertical: TextAlignVertical.center,
                      //     focusNode: _focusNode,
                      //     controller: searchp,
                      //     cursorColor: const Color(0xff7E7E7E),
                      //     decoration: InputDecoration(
                      //         focusedBorder: InputBorder.none,
                      //         enabledBorder: InputBorder.none,
                      //         hintText: 'Search Products',
                      //         hintStyle: TextDesign.hinttext,

                      //         //suffixIcon: Icon(CupertinoIcons.clear_circled_solid),
                      //         suffixIcon: IconButton(
                      //             onPressed: () {
                      //               if (searchp.text.isNotEmpty) {
                      //                 if (searchp.text.length > 2) {
                      //                   NetworkcallforSearchproductlist(
                      //                       0, true, "all", searchp.text);
                      //                 }
                      //               }
                      //             },
                      //             icon: const Icon(Icons.search))),
                      //   ).marginOnly(left: 10),
                      // ),
                      // searchproductlist.isNotEmpty
                      //     ? Container(
                      //         color: Colors.white,
                      //         child: SizedBox(
                      //           height: 200,
                      //           child: ListView.builder(
                      //             itemCount: searchproductlist.length,
                      //             itemBuilder: (context, index) {
                      //               return GestureDetector(
                      //                 onTap: () {
                      //                   String productcarat = "";
                      //                   if (productlist[index].productType ==
                      //                       "0") {
                      //                     productcarat = "22k";
                      //                   } else if (productlist[index]
                      //                           .productType ==
                      //                       "1") {
                      //                     productcarat = "24k";
                      //                   } else if (productlist[index]
                      //                           .productType ==
                      //                       "2") {
                      //                     productcarat = "18k";
                      //                   } else {
                      //                     productcarat = "";
                      //                   }
                      //                   Navigator.push(context,
                      //                       MaterialPageRoute(
                      //                     builder: (context) {
                      //                       return BuyNow(
                      //                           searchproductlist[index]
                      //                               .productName!,
                      //                           searchproductlist[index]
                      //                               .maxPrice!,
                      //                           searchproductlist[index]
                      //                               .imagePath!,
                      //                           productcarat,
                      //                           searchproductlist[index],
                      //                           searchproductlist[index].id!);
                      //                     },
                      //                   )).then(
                      //                     (value) {
                      //                       searchp.clear();
                      //                       searchproductlist.clear();
                      //                       _focusNode.unfocus();
                      //                       setState(() {});
                      //                       NetworkCallForLiveRate(true);
                      //                       Networkcallforproductlist(
                      //                           0, true, "recent", "");
                      //                     },
                      //                   );
                      //                 },
                      //                 child: ListTile(
                      //                   title: Container(
                      //                       width: MediaQuery.of(context)
                      //                               .size
                      //                               .width *
                      //                           0.8,
                      //                       child: Text(
                      //                         'Product Name: ' +
                      //                             searchproductlist[index]
                      //                                 .productName!,
                      //                         style: TextDesign.hinttext,
                      //                       )),
                      //                 ),
                      //               );
                      //             },
                      //           ),
                      //         ),
                      //       ).marginOnly(left: 15, right: 15, top: 5)
                      //     : Container(),
                      Container(
                        height: height / 40,
                      ),
                      Container(
                        // width: 350,
                        width: MediaQuery.of(context).size.width * 1.1,
                        height: 150,
                        child: PageView(
                          scrollDirection: Axis.horizontal,
                          controller: homeController.pageController.value,
                          children: const [
                            PageViewHomepage(),
                            PageViewHomepage1()
                            // PageViewHomepage2()
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: height / 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: SmoothPageIndicator(
                                  controller:
                                      homeController.pageController.value,
                                  // PageController
                                  count: 2,
                                  effect: WormEffect(
                                      dotWidth: 10,
                                      dotHeight: 10,
                                      activeDotColor: AppColor.intoColor,
                                      dotColor: const Color(0xff98B7B3)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        height: height / 40,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 0,
                                  blurRadius: 1,
                                  offset: const Offset(1, 1),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10)),
                          margin: const EdgeInsets.only(
                            left: 15,
                            right: 15,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  // return BuyGoldOnEMICheck(
                                  //     AppUtility.pergramrate,
                                  //     bookingAmount,
                                  //     processingfees,
                                  //     membersheepfees,
                                  //     membersheeptype,
                                  //     membersheepstatus,
                                  //     proceesingfeesgst,
                                  //     makingcharge,
                                  //     makinggst);
                                  return BuyGoldOnEMI();
                                },
                              )).then(
                                (value) {
                                  NetworkCallForLiveRate(true);
                                  Networkcallforproductlist(
                                      0, true, "recent", "");
                                },
                              );
                              ;
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                //  mainAxisAlignment: MainAxisAlignment.center,
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
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  const Text(
                                    'Live',
                                    style: TextStyle(
                                        color: Color(0xffF44336),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    ' ${AppUtility.pergramrate.inRupeesFormat()} ',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Color(0xffddae48),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  const Text(
                                    'BUY NOW',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xffddae48),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const CircleAvatar(
                                    radius: 10,
                                    backgroundColor: Color(0xffddae48),
                                    child: Icon(
                                      CupertinoIcons.right_chevron,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )),
                      Container(
                        height: height / 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Explore Our Digital Gold Marketplace',
                            style: TextStyle(
                                color: Color.fromARGB(255, 40, 40, 40),
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return BuyGold();
                                  },
                                )).then(
                                  (value) {
                                    NetworkCallForLiveRate(false);
                                    Networkcallforproductlist(
                                        0, false, "recent", "");
                                  },
                                );
                              },
                              child: Container(
                                  child: Text(
                                'View All',
                                style: TextStyle(
                                    color: AppColor.intoColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                                textAlign: TextAlign.center,
                              ))),
                        ],
                      ).marginOnly(left: 20, right: 20),
                      Container(
                        height: height / 40,
                      ),
                      nodata
                          ? SizedBox(
                              height: 250,
                              child: ListView.builder(
                                itemCount: productlist.length > 10
                                    ? 10
                                    : productlist.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return listview(index);
                                },
                              ),
                            )
                          : Container(),
                      Container(
                        height: height / 80,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 15),
                            child: 'Frequently Asked Question\'s'
                                .homePageText(context),
                          ),
                        ],
                      ),
                      Container(
                        height: height / 80,
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 0,
                                    blurRadius: 1,
                                    offset: const Offset(1, 1),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(
                                    5.0), // Adjust border radius as needed
                              ),
                              child: ExpansionTile(
                                title: const Text(
                                  'Who are we? What makes Uneeds Gold different?',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 67, 66, 66)),
                                ),
                                children: <Widget>[
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Divider(
                                      height: 1,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      'Uneeds Gold is different because we offer you an exquisite range of fine jewellery designs from India and a unique and hassle free online shopping experience that you\'re sure to enjoy.',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Color.fromARGB(
                                              255, 110, 109, 109)),
                                    ),
                                  ),
                                ],
                                //  tilePadding: EdgeInsets.zero, // To remove the default padding around the tile
                                // initiallyExpanded: false, // Set to true if you want the tile to be initially expanded
                                // collapsedTextColor: Colors.black, // Text color when tile is collapsed
                                // textColor: Colors.black, // Text color when tile is expanded
                                iconColor: Colors.black, // Icon color
                                // backgroundColor: Colors.white, // Background color of the tile
                                // collapsedIconColor: Colors.black, // Icon color when tile is collapsed
                                shape: RoundedRectangleBorder(
                                  // Custom shape to remove top and bottom borders
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: BorderSide
                                      .none, // Remove top and bottom borders
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 0,
                                    blurRadius: 1,
                                    offset: const Offset(1, 1),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(
                                    5.0), // Adjust border radius as needed
                              ),
                              child: ExpansionTile(
                                title: const Text(
                                  'Where is Uneeds Gold located?',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 67, 66, 66)),
                                ),
                                children: <Widget>[
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Divider(
                                      height: 1,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      'We are situated in the vibrant city of Pune, Maharashtra, India, at S.No-63/2B, Manali Arcade, Flat-E204, near D-Mart, Parvati, Pune City, Maharashtra, 411009. Our location is easily accessible, and we take pride in our roots in this diverse and culturally rich city.',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Color.fromARGB(
                                              255, 110, 109, 109)),
                                    ),
                                  ),
                                ],
                                iconColor: Colors.black, // Icon color
                                // backgroundColor: Colors.white, // Background color of the tile
                                // collapsedIconColor: Colors.black, // Icon color when tile is collapsed
                                shape: RoundedRectangleBorder(
                                  // Custom shape to remove top and bottom borders
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: BorderSide
                                      .none, // Remove top and bottom borders
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 0,
                                    blurRadius: 1,
                                    offset: const Offset(1, 1),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(
                                    5.0), // Adjust border radius as needed
                              ),
                              child: ExpansionTile(
                                expandedCrossAxisAlignment:
                                    CrossAxisAlignment.start,
                                title: const Text(
                                  'Where is your jewellery made?',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 67, 66, 66)),
                                ),
                                children: <Widget>[
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Divider(
                                      height: 1,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      'All our jewellery are manufactured in India.',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Color.fromARGB(
                                              255, 110, 109, 109)),
                                    ),
                                  ),
                                ],
                                iconColor: Colors.black, // Icon color
                                // backgroundColor: Colors.white, // Background color of the tile
                                // collapsedIconColor: Colors.black, // Icon color when tile is collapsed
                                shape: RoundedRectangleBorder(
                                  // Custom shape to remove top and bottom borders
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: BorderSide
                                      .none, // Remove top and bottom borders
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 0,
                                    blurRadius: 1,
                                    offset: const Offset(1, 1),
                                  ),
                                ],

                                borderRadius: BorderRadius.circular(
                                    5.0), // Adjust border radius as needed
                              ),
                              child: ExpansionTile(
                                expandedCrossAxisAlignment:
                                    CrossAxisAlignment.start,
                                title: const Text(
                                  'Does Uneeds Gold have a catalog?',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 67, 66, 66)),
                                ),
                                children: <Widget>[
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Divider(
                                      height: 1,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      'No, we don\'t have a print catalog as of now.',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Color.fromARGB(
                                              255, 110, 109, 109)),
                                    ),
                                  ),
                                ],
                                iconColor: Colors.black, // Icon color
                                // backgroundColor: Colors.white, // Background color of the tile
                                // collapsedIconColor: Colors.black, // Icon color when tile is collapsed
                                shape: RoundedRectangleBorder(
                                  // Custom shape to remove top and bottom borders
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: BorderSide
                                      .none, // Remove top and bottom borders
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 0,
                                    blurRadius: 1,
                                    offset: const Offset(1, 1),
                                  ),
                                ],
                                // border: Border.all(
                                // color: Colors.grey, // Choose your desired border color
                                // width: 1.0, // Adjust the border width as needed
                                // ),
                                borderRadius: BorderRadius.circular(
                                    5.0), // Adjust border radius as needed
                              ),
                              child: ExpansionTile(
                                expandedCrossAxisAlignment:
                                    CrossAxisAlignment.start,
                                title: const Text(
                                  'Do you offer any additional discounts?',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 67, 66, 66)),
                                ),
                                children: <Widget>[
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Divider(
                                      height: 1,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      'No, we do not offer any additional discounts. Our all inclusive MRP is lower than most stores. Our products are offered directly from the manufacturer and with no overheads like rent, inventory costs, etc. We are able to pass on this benefit to all our customers by way of honest and competitive prices.',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Color.fromARGB(
                                              255, 110, 109, 109)),
                                    ),
                                  ),
                                ],
                                iconColor: Colors.black, // Icon color
                                // backgroundColor: Colors.white, // Background color of the tile
                                // collapsedIconColor: Colors.black, // Icon color when tile is collapsed
                                shape: RoundedRectangleBorder(
                                  // Custom shape to remove top and bottom borders
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: BorderSide
                                      .none, // Remove top and bottom borders
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 15),
                            child: 'How We Ensure The Safety Of Your Gold'
                                .homePageText(context),
                          ),
                        ],
                      ),
                      Container(
                        height: height / 80,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 0,
                                    blurRadius: 1,
                                    offset: const Offset(1, 1),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/new/hallmark.png',
                                    width: 50,
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "BIS Hallmarked",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(255, 68, 67, 67)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 0,
                                    blurRadius: 1,
                                    offset: const Offset(1, 1),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/new/fast.png',
                                    width: 50,
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "Fastest Delivery",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(255, 68, 67, 67)),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 0,
                                    blurRadius: 1,
                                    offset: const Offset(1, 1),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/new/guarantee.png',
                                    width: 50,
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "Purity Guarantee",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(255, 68, 67, 67)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 0,
                                    blurRadius: 1,
                                    offset: const Offset(1, 1),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/new/100-per.png',
                                    width: 50,
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "100% Verify",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(255, 68, 67, 67)),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextEditingController searchp = TextEditingController();

  Widget listview(int index1) {
    String productcarat = "";
    if (productlist[index1].productType == "0") {
      productcarat = "22k";
    } else if (productlist[index1].productType == "1") {
      productcarat = "24k";
    } else if (productlist[index1].productType == "2") {
      productcarat = "18k";
    } else {
      productcarat = "";
    }
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return BuyNow(
                productlist[index1].productName!,
                productlist[index1].maxPrice!,
                productlist[index1].imagePath!,
                productcarat,
                productlist[index1],
                productlist[index1].id!);
          },
        )).then(
          (value) {
            NetworkCallForLiveRate(true);
            Networkcallforproductlist(0, true, "recent", "");
          },
        );
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 0),
            ),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppColor.bgcolor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: Stack(
                children: [
                  Center(
                    child: CachedNetworkImage(
                      imageUrl: NetworkUtility.base_api +
                          productlist[index1].imagePath!,
                      errorWidget: (context, url, error) {
                        return Image.asset(
                          "assets/images/ic_launcher.png",
                          fit: BoxFit.cover,
                        );
                      },
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          // height: 120,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: imageProvider,
                            ),
                          ),
                        );
                      },
                      height: 120,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: AppColor.intoColor,
                          child: productcarat.gramText(),
                        ).marginOnly(right: 8),
                      )
                    ],
                  ),
                ],
              ),
            ).paddingOnly(top: 5),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Text(
                      productlist[index1].productName! +
                          "(${productlist[index1].productInGram!} gm)",
                      style: TextStyle(color: AppColor.greycolor, fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ).marginOnly(top: 15, left: 15, bottom: 2),
            ),
            Row(
              children: [
                Text(
                  double.parse(productlist[index1].maxPrice!).inRupeesFormat(),
                  style: const TextStyle(
                      color: Color(0xffF2A666),
                      fontWeight: FontWeight.w400,
                      fontSize: 13),
                )
              ],
            ).marginOnly(left: 15, top: 5, bottom: 5),
            Expanded(
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: AppColor.theamecolor,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15))),
                    padding: const EdgeInsets.all(2),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Buy Now',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
                      ],
                    )))
          ],
        ),
      ),
    );
  }
}
