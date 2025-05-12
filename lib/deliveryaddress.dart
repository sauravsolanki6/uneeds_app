import 'package:UNGolds/constant/button_design.dart';
import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/constant/snackbardesign.dart';
import 'package:UNGolds/network/response/deliveryaddressresponse.dart';
import 'package:UNGolds/screens/profile_page/profile_details.dart';
import 'package:UNGolds/screens/profile_page/profile_onward.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/get_utils.dart';

import 'constant/app_color.dart';
import 'constant/printmessage.dart';
import 'constant/progressdialog.dart';
import 'constant/textdesign.dart';
import 'constant/utility.dart';
import 'network/createjson.dart';
import 'network/networkcall.dart';
import 'network/networkutility.dart';
import 'network/response/get_city_response.dart';
import 'network/response/get_state_response.dart';

final firstnameController = TextEditingController();
final lastnameController = TextEditingController();
final mobilenumberController = TextEditingController();
final talukacontroller = TextEditingController();
final addressController = TextEditingController();
final pincodeController = TextEditingController();
bool validatefirstname = true,
    validatelastname = true,
    validatemobilenumber = true,
    validatestate = true,
    validatedist = true,
    validatetaluka = true,
    validateaddress = true,
    validatepincode = true;
String errorname = "",
    errorage = "",
    errormobilenumber = 'Please enter nominee contact',
    errorrelation = "",
    erroraddress = "",
    errorforpincode = "Please enter pincode";

class Deliveryaddress extends StatefulWidget {
  State createState() => DeliveryaddressState();
}

class DeliveryaddressState extends State<Deliveryaddress> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstnameController.text = AppUtility.NAME;
    mobilenumberController.text = AppUtility.MobileNumber;
    NetworkcallForgetstate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    clearallfields();
  }

  clearallfields() {
    validatefirstname = true;
    validatelastname = true;
    validatemobilenumber = true;
    validatestate = true;
    validatedist = true;
    validatetaluka = true;
    validateaddress = true;
    validatepincode = true;
    firstnameController.clear();
    lastnameController.clear();
    mobilenumberController.clear();
    state_id = "";
    city_id = "";
    talukacontroller.clear();
    pincodeController.clear();
    addressController.clear();
  }

  List<GetstateresponseDatum> statelist = [];
  Future<void> NetworkcallForgetstate() async {
    try {
      city_id = "";
      state_id = "";
      citylist.clear();
      statelist.clear();
      ProgressDialog.showProgressDialog(context, "Loading");
      Networkcall networkcall = Networkcall();
      List<Object?>? signup = await networkcall.getMethod(
          NetworkUtility.get_state, NetworkUtility.get_state_api, context);
      if (signup != null) {
        Navigator.pop(context);
        List<Getstateresponse> stateresponse = List.from(signup!);
        String status = stateresponse[0].status.toString();
        switch (status) {
          case "true":
            statelist = stateresponse[0].data!;
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

  String country_id = "", state_id = "", city_id = "";
  List<GetcityresponseDatum> citylist = [];
  Future<void> NetworkcallForgetcity(String stateid) async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading");
      String createjson = CreateJson().createjsonforCity(stateid, context);
      Networkcall networkcall = Networkcall();
      List<Object?>? signup = await networkcall.postMethod(
          NetworkUtility.get_state_city,
          NetworkUtility.get_state_city_api,
          createjson,
          context);
      if (signup != null) {
        Navigator.pop(context);
        List<Getcityresponse> cityresponse = List.from(signup!);
        String status = cityresponse[0].status.toString();
        switch (status) {
          case "true":
            citylist = cityresponse[0].data!;
            setState(() {});
            break;
          case "false":
            SnackBarDesign(cityresponse[0].message!, context,
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
          e.toString(), 'Networkcallforcity', "Profile Onward", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return SafeArea(
        child: Scaffold(
      backgroundColor: context.theme.cardColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
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
                  'Delivery Address'.introTitleText(context),
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
        // physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/bg.png'), // Replace 'assets/background_image.jpg' with your image path
                fit: BoxFit.cover, //
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kindly provide a valid delivery address to ensure the prompt and accurate delivery of your product to its intended destination by our reputable company.',
                    style: TextStyle(fontSize: 10),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                'Full Name *',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: context.theme.colorScheme.background,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(left: 5),
                              child: Container(
                                margin: EdgeInsets.only(left: 5),
                                child: TextField(
                                  controller: firstnameController,
                                  readOnly: true,
                                  enabled: true,
                                  onChanged: (value) {
                                    validatefirstname = true;
                                    setState(() {});
                                  },
                                  style: TextStyle(color: Colors.black),
                                  cursorColor: Color(0xff7E7E7E),
                                  decoration: InputDecoration(
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      hintText: 'Enter Your Full Name',
                                      // errorText: validatefirstname
                                      //     ? null
                                      //     : 'Please enter your first name',
                                      errorStyle: TextDesign.errortext,
                                      hintStyle: TextDesign.hinttext),
                                ),
                              ),
                            ).marginOnly(top: 10, right: 20),
                            SizedBox(
                              height: 3,
                            ),
                            validatefirstname
                                ? Container()
                                : Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child: Text(
                                      'Please enter your full name',
                                      style: TextDesign.errortext,
                                    ),
                                  ),
                          ],
                        ),

                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Container(
                        //       child: 'Last Name *'.TegSubText(),
                        //     ),
                        //     Container(
                        //       decoration: BoxDecoration(
                        //           color: context.theme.colorScheme.background,
                        //           borderRadius: BorderRadius.circular(10)),
                        //       margin: EdgeInsets.only(left: 5),
                        //       child: Container(
                        //         margin: EdgeInsets.only(left: 5),
                        //         child: TextField(
                        //           controller: lastnameController,
                        //           onChanged: (value) {
                        //             validatelastname = true;
                        //             setState(() {});
                        //           },
                        //           style: TextStyle(color: Colors.black),
                        //           cursorColor: Color(0xff7E7E7E),
                        //           decoration: InputDecoration(
                        //               focusedBorder: InputBorder.none,
                        //               enabledBorder: InputBorder.none,
                        //               hintText: 'Enter Your Last Name',
                        //               // errorText: validatelastname
                        //               //     ? null
                        //               //     : 'Please enter your last name',
                        //               errorStyle: TextDesign.errortext,
                        //               hintStyle: TextDesign.hinttext),
                        //         ),
                        //       ),
                        //     ).marginOnly(top: 10, right: 20),
                        //     SizedBox(
                        //       height: 3,
                        //     ),
                        //     validatelastname
                        //         ? Container()
                        //         : Container(
                        //             margin: EdgeInsets.only(left: 5),
                        //             child: Text(
                        //               'Please enter your last name',
                        //               style: TextDesign.errortext,
                        //             ),
                        //           ),
                        //   ],
                        // ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                'Mobile Number*',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: context.theme.colorScheme.background,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(left: 5),
                              child: Container(
                                margin: EdgeInsets.only(left: 5),
                                child: TextField(
                                  readOnly: true,
                                  enabled: true,
                                  onChanged: (value) {
                                    if (value.length == 10 &&
                                        value != '0000000000') {
                                      validatemobilenumber = true;
                                    } else {
                                      validatemobilenumber = false;
                                      errormobilenumber =
                                          'Please enter valid mobile number';
                                    }
                                    setState(() {});
                                  },
                                  controller: mobilenumberController,
                                  style: TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[0-9]")),
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  cursorColor: Color(0xff7E7E7E),
                                  decoration: InputDecoration(
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      hintText: 'Enter Your Mobile Number',
                                      // errorText:
                                      //     validatemobilenumber ? null : errormobilenumber,
                                      errorStyle: TextDesign.errortext,
                                      hintStyle: TextDesign.hinttext),
                                ),
                              ),
                            ).marginOnly(top: 10, right: 20),
                            validatemobilenumber
                                ? Container()
                                : Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child: Text(
                                      errormobilenumber,
                                      style: TextDesign.errortext,
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                'Country *',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                            ),
                            Container(
                              height: 48,
                              margin: EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                color: context.theme.colorScheme.background,
                                borderRadius: BorderRadius.circular(5),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                    color:
                                        AppColor.bordercolor.withOpacity(0.2)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                  value: country_id,
                                  isDense: true,
                                  isExpanded: true,
                                  menuMaxHeight: 350,
                                  items: const [
                                    DropdownMenuItem(
                                        child: Text(
                                          "India",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 117, 117, 117),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        value: ""),
                                  ],
                                  onChanged: (newValue) {},
                                )),
                              ),
                            ).marginOnly(top: 5, right: 20),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                'State *',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                            ),
                            Container(
                              height: 48,
                              margin: EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                color: context.theme.colorScheme.background,
                                borderRadius: BorderRadius.circular(5),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                    color:
                                        AppColor.bordercolor.withOpacity(0.2)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                  value: state_id,
                                  isDense: true,
                                  isExpanded: true,
                                  menuMaxHeight: 350,
                                  items: [
                                    const DropdownMenuItem(
                                        child: Text(
                                          "Select State",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 117, 117, 117),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        value: ""),
                                    ...statelist
                                        .map<DropdownMenuItem<String>>((e) {
                                      return DropdownMenuItem(
                                          child: Text(
                                            e.name.toString(),
                                            style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          value: e.id.toString());
                                    }).toList()
                                  ],
                                  onChanged: (newValue) {
                                    setState(
                                      () {
                                        state_id = newValue!;
                                        city_id = "";
                                        validatestate = true;
                                        citylist.clear();
                                        NetworkcallForgetcity(state_id);
                                      },
                                    );
                                  },
                                )),
                              ),
                            ).marginOnly(top: 10, right: 20),
                            SizedBox(
                              height: 3,
                            ),
                            validatestate
                                ? Container()
                                : Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child: Text(
                                      'Please select state',
                                      style: TextDesign.errortext,
                                    ),
                                  )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                'City *',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                            ),
                            Container(
                              height: 48,
                              margin: EdgeInsets.only(left: 5),
                              decoration: BoxDecoration(
                                color: context.theme.colorScheme.background,
                                borderRadius: BorderRadius.circular(5),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                    color:
                                        AppColor.bordercolor.withOpacity(0.2)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: city_id,
                                    isDense: true,
                                    isExpanded: true,
                                    menuMaxHeight: 350,
                                    items: [
                                      const DropdownMenuItem(
                                          child: Text(
                                            "Select City",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 117, 117, 117),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          value: ""),
                                      ...citylist
                                          .map<DropdownMenuItem<String>>((e) {
                                        return DropdownMenuItem(
                                            child: Text(
                                              e.name.toString(),
                                              style: TextStyle(
                                                  color: Colors.grey.shade600,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            value: e.id.toString());
                                      }).toList()
                                    ],
                                    onChanged: (newValue) {
                                      setState(
                                        () {
                                          city_id = newValue!;
                                          validatedist = true;
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ).marginOnly(top: 10, right: 20),
                            SizedBox(
                              height: 3,
                            ),
                            validatedist
                                ? Container()
                                : Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child: Text(
                                      'Please select city',
                                      style: TextDesign.errortext,
                                    ),
                                  )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                'Taluka *',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: context.theme.colorScheme.background,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(left: 5),
                              child: Container(
                                margin: EdgeInsets.only(left: 5),
                                child: TextField(
                                  onChanged: (value) {
                                    validatetaluka = true;
                                    setState(() {});
                                  },
                                  controller: talukacontroller,
                                  style: TextStyle(color: Colors.black),
                                  cursorColor: Color(0xff7E7E7E),
                                  decoration: InputDecoration(
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      hintText: 'Enter Taluka',
                                      // errorText:
                                      //     validatetaluka ? null : 'Please enter taluka',
                                      errorStyle: TextDesign.errortext,
                                      hintStyle: TextDesign.hinttext),
                                ),
                              ),
                            ).marginOnly(top: 10, right: 20),
                            SizedBox(
                              height: 3,
                            ),
                            validatetaluka
                                ? Container()
                                : Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child: Text(
                                      "Please enter taluka",
                                      style: TextDesign.errortext,
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                'Pin Code *',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: context.theme.colorScheme.background,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(left: 5),
                              child: Container(
                                margin: EdgeInsets.only(left: 5),
                                child: TextField(
                                  controller: pincodeController,
                                  onChanged: (value) {
                                    validatepincode = false;
                                    if (value.length != 6) {
                                      errorforpincode =
                                          'Pincode must be exactly 6 digits long';
                                    } else if (value == '000000') {
                                      errorforpincode =
                                          'Pincode cannot be all zeros';
                                    } else if (!RegExp(r'^[1-9][0-9]{5}$')
                                        .hasMatch(value)) {
                                      errorforpincode = 'Invalid pincode';
                                    } else {
                                      validatepincode = true;
                                    }
                                    setState(() {});
                                  },
                                  style: TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.number,
                                  // maxLength: 6,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp("[0-9]")),
                                    LengthLimitingTextInputFormatter(6),
                                  ],
                                  cursorColor: Color(0xff7E7E7E),
                                  decoration: InputDecoration(
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      hintText: 'Enter Your Pincode',
                                      // errorText:
                                      //     validatepincode ? null : 'Please enter pincode',
                                      errorStyle: TextDesign.errortext,
                                      hintStyle: TextDesign.hinttext),
                                ),
                              ),
                            ).marginOnly(top: 10, right: 20),
                            SizedBox(
                              height: 3,
                            ),
                            validatepincode
                                ? Container()
                                : Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child: Text(
                                      errorforpincode,
                                      style: TextDesign.errortext,
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                'Your Address *',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: context.theme.colorScheme.background,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(left: 5),
                              child: Container(
                                margin: EdgeInsets.only(left: 5),
                                child: TextField(
                                  onChanged: (value) {
                                    validateaddress = true;
                                    setState(() {});
                                  },
                                  controller: addressController,
                                  style: TextStyle(color: Colors.black),
                                  cursorColor: Color(0xff7E7E7E),
                                  decoration: InputDecoration(
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      hintText: 'Enter Your Address',
                                      // errorText: validateaddress
                                      //     ? null
                                      //     : 'Please enter your address',
                                      errorStyle: TextDesign.errortext,
                                      hintStyle: TextDesign.hinttext),
                                ),
                              ),
                            ).marginOnly(top: 10, right: 20),
                            validateaddress
                                ? Container()
                                : Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child: Text(
                                      "Please enter your address",
                                      style: TextDesign.errortext,
                                    ),
                                  ),
                          ],
                        ),
                        ButtonDesign(
                            onPressed: () {
                              validatefields();
                            },
                            child: 'Submit'.buttoText())
                      ],
                    ),
                  ),
                ],
              ).marginOnly(left: 20, right: 20),
            ),
          ),
        ),
      ),
    ));
  }

  String? validatePincode(String value) {
    if (value.length != 6) {
      return 'Pincode must be exactly 6 digits long';
    } else if (value == '000000') {
      return 'Pincode cannot be all zeros';
    } else if (!RegExp(r'^[1-9][0-9]{5}$').hasMatch(value)) {
      return 'Invalid pincode';
    }
    return null;
  }

  validatefields() {
    validatefirstname = true;
    validatelastname = true;
    validatemobilenumber = true;
    validatestate = true;
    validatedist = true;
    validatetaluka = true;
    validateaddress = true;
    if (firstnameController.text.isEmpty &&
        mobilenumberController.text.isEmpty &&
        state_id == '' &&
        city_id == "" &&
        talukacontroller.text.isEmpty &&
        pincodeController.text.isEmpty &&
        addressController.text.isEmpty) {
      validatefirstname = false;
      validatelastname = false;
      validatemobilenumber = false;
      validatestate = false;
      validatedist = false;
      validatetaluka = false;
      validatepincode = false;
      validateaddress = false;
      errormobilenumber = 'Please enter your mobile number';
      setState(() {});
    }
    // else if (lastnameController.text.isEmpty &&
    //     mobilenumberController.text.isEmpty &&
    //     state_id == '' &&
    //     city_id == "" &&
    //     talukacontroller.text.isEmpty &&
    //     pincodeController.text.isEmpty &&
    //     addressController.text.isEmpty) {
    //   validatelastname = false;
    //   validatemobilenumber = false;
    //   validatestate = false;
    //   validatedist = false;
    //   validatetaluka = false;
    //   validatepincode = false;
    //   validateaddress = false;
    //   errormobilenumber = 'Please enter your mobile number';
    //   setState(() {});
    // }
    else if (mobilenumberController.text.isEmpty &&
        state_id == '' &&
        city_id == "" &&
        talukacontroller.text.isEmpty &&
        pincodeController.text.isEmpty &&
        addressController.text.isEmpty) {
      validatemobilenumber = false;
      validatestate = false;
      validatedist = false;
      validatetaluka = false;
      validatepincode = false;
      validateaddress = false;

      errormobilenumber = 'Please enter your mobile number';
      setState(() {});
    } else if (state_id == '' &&
        city_id == "" &&
        talukacontroller.text.isEmpty &&
        pincodeController.text.isEmpty &&
        addressController.text.isEmpty) {
      validatestate = false;
      validatedist = false;
      validatetaluka = false;
      validatepincode = false;
      validateaddress = false;
      setState(() {});
    } else if (city_id == "" &&
        talukacontroller.text.isEmpty &&
        pincodeController.text.isEmpty &&
        addressController.text.isEmpty) {
      validatedist = false;
      validatetaluka = false;
      validatepincode = false;
      validateaddress = false;
      setState(() {});
    } else if (talukacontroller.text.isEmpty &&
        pincodeController.text.isEmpty &&
        addressController.text.isEmpty) {
      validatetaluka = false;
      validatepincode = false;
      validateaddress = false;
      setState(() {});
    } else if (pincodeController.text.isEmpty &&
        addressController.text.isEmpty) {
      validatepincode = false;
      validateaddress = false;
      setState(() {});
    } else if (addressController.text.isEmpty) {
      validateaddress = false;
      setState(() {});
    } else if (firstnameController.text.isEmpty) {
      validatefirstname = false;
      setState(() {});
      // } else if (lastnameController.text.isEmpty) {
      //   validatelastname = false;
      //   setState(() {});
    } else if (mobilenumberController.text.isEmpty) {
      validatemobilenumber = false;
      errormobilenumber = 'Please enter nominee contact';
      setState(() {});
    } else if (state_id == '') {
      validatestate = false;
      setState(() {});
    } else if (city_id == "") {
      validatedist = false;
      setState(() {});
    } else if (pincodeController.text.isEmpty) {
      validatepincode = false;
      setState(() {});
    } else if (talukacontroller.text.isEmpty) {
      validatetaluka = false;
      setState(() {});
    } else {
      setState(() {});
      Networkcallforadddeliveryaddress();
    }
  }

  Future<void> Networkcallforadddeliveryaddress() async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading...");
      String createjson = CreateJson().cretajsonforadddeliveryaddress(
          context,
          AppUtility.ID,
          firstnameController.text,
          '',
          mobilenumberController.text,
          "101",
          state_id,
          city_id,
          talukacontroller.text,
          pincodeController.text,
          addressController.text);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.api_set_address,
          NetworkUtility.api_set_address_url,
          createjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Deliveryaddressresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            SnackBarDesign('Delivery address added successfully!', context,
                AppColor.sucesscolor, Colors.white);
            Navigator.pop(context);

            break;
          case "false":
            SnackBarDesign(response[0].message!, context, AppColor.errorcolor,
                Colors.white);
            break;
        }
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      PrintMessage.printmessage(e.toString(), 'NetworkCallForSubmitKYCForm',
          'Stepper For KYC', context);
    }
  }
}
