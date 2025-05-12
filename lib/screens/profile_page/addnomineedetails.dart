import 'package:UNGolds/constant/extension.dart';
import 'package:UNGolds/network/response/addnominee_response.dart';
import 'package:UNGolds/network/response/relation_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../constant/app_color.dart';
import '../../constant/button_design.dart';
import '../../constant/printmessage.dart';
import '../../constant/progressdialog.dart';
import '../../constant/snackbardesign.dart';
import '../../constant/textdesign.dart';
import '../../constant/utility.dart';
import '../../network/createjson.dart';
import '../../network/networkcall.dart';
import '../../network/networkutility.dart';

final nomineenameController = TextEditingController();
final nomineecontactController = TextEditingController();
final agecontroller = TextEditingController();
final addressController = TextEditingController();
bool validatename = true,
    validatecontact = true,
    validateage = true,
    validaterelation = true,
    validateaddress = true;
String errorname = "",
    errorage = "",
    errorcontact = 'Please enter nominee contact',
    errorrelation = "",
    erroraddress = "";
List<Relation> relationlist = <Relation>[
  Relation(0, "Mother"),
  Relation(1, "Father"),
  Relation(2, "Daughter"),
  Relation(3, "Son"),
  Relation(4, "Sister"),
  Relation(5, "Brother"),
  Relation(6, "Wife"),
  Relation(7, "Husband"),
  Relation(8, "Grandmother"),
  Relation(9, "Grandfather"),
  Relation(10, "Aunt"),
  Relation(11, "Uncle"),
  Relation(12, "Daughter-in-law"),
  Relation(13, "Son-in-law")
];
String relation_id = "";

class AddNomineeDetails extends StatefulWidget {
  State createState() => AddNomineeDetailsState();
}

class AddNomineeDetailsState extends State<AddNomineeDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nomineenameController.clear();
    nomineecontactController.clear();
    agecontroller.clear();
    addressController.clear();
    relation_id = "";
    validatename = true;
    validatecontact = true;
    validateage = true;
    validaterelation = true;
    validateaddress = true;
    errorcontact = "";
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
      backgroundColor: context.theme.cardColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
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
                  'Add Nominee Details'.introTitleText(context),
                ],
              ).marginOnly(top: 10),
            ),
            const CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 25,
            ).marginOnly(right: 10, top: 10)
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text('Nominee Name *',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        )),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: context.theme.colorScheme.background,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.only(left: 5),
                    child: Container(
                      margin: EdgeInsets.only(left: 5),
                      child: TextField(
                        controller: nomineenameController,
                        onChanged: (value) {
                          validatename = true;
                          setState(() {});
                        },
                        style: TextStyle(color: Colors.black),
                        cursorColor: Color(0xff7E7E7E),
                        decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: 'Enter Nominee Name',
                            // errorText:
                            //     validatename ? null : 'Please nominee name',
                            errorStyle: TextDesign.errortext,
                            hintStyle: TextDesign.hinttext),
                      ),
                    ),
                  ).marginOnly(top: 10, right: 20),
                  if (!validatename)
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 5,
                          top: 3.0,
                          bottom: 4.0), // Adjust the padding as needed
                      child: Text(
                        'Please enter nominee name',
                        style: TextDesign.errortext, // Custom error text style
                      ),
                    ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text('Nominee Contact *',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        )),
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
                          if (value.length == 10 && value != '0000000000') {
                            validatecontact = true;
                          } else {
                            validatecontact = false;
                            errorcontact = 'Please enter valid nominee contact';
                          }
                          setState(() {});
                        },
                        controller: nomineecontactController,
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                          LengthLimitingTextInputFormatter(10),
                        ],
                        cursorColor: Color(0xff7E7E7E),
                        decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none, // Add this line
                            focusedErrorBorder:
                                InputBorder.none, // Add this line
                            hintText: 'Enter Nominee Contact',
                            //errorText: validatecontact ? null : errorcontact,
                            errorStyle: TextDesign.errortext,
                            hintStyle: TextDesign.hinttext),
                      ),
                    ),
                  ).marginOnly(top: 10, right: 20),
                  if (!validatecontact)
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 5,
                          top: 3.0,
                          bottom: 4.0), // Adjust the padding as needed
                      child: Text(
                        errorcontact,
                        style: TextDesign.errortext, // Custom error text style
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
                      'Nominee Age *',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
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
                          validateage = true;
                          setState(() {});
                        },
                        controller: agecontroller,
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d{0,2}')),
                        ],
                        cursorColor: Color(0xff7E7E7E),
                        decoration: InputDecoration(
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none, // Add this line
                            focusedErrorBorder:
                                InputBorder.none, // Add this line
                            hintText: 'Enter Nominee Age',
                            // errorText:
                            //     validateage ? null : 'Please enter nominee age',
                            errorStyle: TextDesign.errortext,
                            hintStyle: TextDesign.hinttext),
                      ),
                    ),
                  ).marginOnly(top: 10, right: 20),
                  if (!validateage)
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 5,
                          top: 3.0,
                          bottom: 4.0), // Adjust the padding as needed
                      child: Text(
                        "Please enter nominee age",
                        style: TextDesign.errortext, // Custom error text style
                      ),
                    ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              sixWidegt(),
              SizedBox(
                height: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text('Nominee Address *',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        )),
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
                            errorBorder: InputBorder.none, // Add this line
                            focusedErrorBorder:
                                InputBorder.none, // Add this line
                            hintText: 'Enter Nominee Address',
                            // errorText: validateaddress
                            //     ? null
                            //     : 'Please enter nominee address',
                            errorStyle: TextDesign.errortext,
                            hintStyle: TextDesign.hinttext),
                      ),
                    ),
                  ).marginOnly(top: 10, right: 20),
                  if (!validateaddress)
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 5,
                          top: 3.0,
                          bottom: 4.0), // Adjust the padding as needed
                      child: Text(
                        "Please enter nominee address",
                        style: TextDesign.errortext, // Custom error text style
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
      ),
    ));
  }

  Widget sixWidegt() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Relation With Customer *',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
            ),
          ],
        ).marginOnly(top: 20),
        Container(
          height: 48,
          margin: EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
              color: context.theme.colorScheme.background,
              borderRadius: BorderRadius.circular(8),
              shape: BoxShape.rectangle),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
              value: relation_id,
              isDense: true,
              isExpanded: true,
              menuMaxHeight: 350,
              items: [
                const DropdownMenuItem(
                    child: Text(
                      "Select Relation",
                      style: TextStyle(
                          color: Color.fromARGB(255, 117, 117, 117),
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    value: ""),
                ...relationlist.map<DropdownMenuItem<String>>((e) {
                  return DropdownMenuItem(
                      child: Text(
                        e.relationame.toString(),
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      value: e.relationame.toString());
                }).toList()
              ],
              onChanged: (newValue) {
                setState(
                  () {
                    relation_id = newValue!;
                    validaterelation = true;
                  },
                );
              },
            )),
          ),
        ).marginOnly(top: 10, right: 20),
        if (!validaterelation)
          Padding(
            padding: const EdgeInsets.only(
                left: 5, top: 3.0, bottom: 4.0), // Adjust the padding as needed
            child: Text(
              'Please select relation with customer',
              style: TextDesign.errortext, // Custom error text style
            ),
          ),
      ],
    );
  }

  validatefields() {
    validatename = true;
    validatecontact = true;
    validateage = true;
    validaterelation = true;
    validateaddress = true;
    if (nomineenameController.text.isEmpty &&
        nomineecontactController.text.isEmpty &&
        agecontroller.text.isEmpty &&
        relation_id == "" &&
        addressController.text.isEmpty) {
      validatename = false;
      validatecontact = false;
      validateage = false;
      validaterelation = false;
      validateaddress = false;
      errorcontact = 'Please enter nominee contact';
      setState(() {});
    } else if (nomineecontactController.text.isEmpty &&
        agecontroller.text.isEmpty &&
        relation_id == "" &&
        addressController.text.isEmpty) {
      validatecontact = false;
      validateage = false;
      validaterelation = false;
      validateaddress = false;
      errorcontact = 'Please enter nominee contact';
      setState(() {});
    } else if (agecontroller.text.isEmpty &&
        relation_id == "" &&
        addressController.text.isEmpty) {
      validateage = false;
      validaterelation = false;
      validateaddress = false;
      setState(() {});
    } else if (relation_id == "" && addressController.text.isEmpty) {
      validaterelation = false;
      validateaddress = false;
      setState(() {});
    } else if (nomineenameController.text.isEmpty) {
      validatename = false;
      setState(() {});
    } else if (nomineecontactController.text.isEmpty) {
      validatecontact = false;
      errorcontact = 'Please enter nominee contact';
      setState(() {});
      // } else if (nomineecontactController.text.isNotEmpty &&
      //     nomineecontactController.text.isPhoneNumber) {
      //   validatecontact = false;
      //   errorcontact = 'Please enter valid nominee contact';
      //   setState(() {});
    } else if (agecontroller.text.isEmpty) {
      validateage = false;
      setState(() {});
    } else if (relation_id == "") {
      validaterelation = false;

      setState(() {});
    } else if (addressController.text.isEmpty) {
      validateaddress = false;
      setState(() {});
    } else {
      setState(() {});
      Networkcallforaddnomineedetails();
    }
  }

  Future<void> Networkcallforaddnomineedetails() async {
    try {
      ProgressDialog.showProgressDialog(context, "Loading...");
      String createjson = CreateJson().cretajsonforaddnomineedetails(
          context,
          AppUtility.ID,
          nomineenameController.text,
          nomineecontactController.text,
          agecontroller.text,
          relation_id,
          addressController.text);
      Networkcall networkcall = Networkcall();
      List<Object?>? list = await networkcall.postMethod(
          NetworkUtility.api_add_nominee,
          NetworkUtility.api_add_nominee_url,
          createjson,
          context);
      if (list != null) {
        Navigator.pop(context);
        List<Addnomineedetailsresponse> response = List.from(list!);
        String status = response[0].status!;
        switch (status) {
          case "true":
            SnackBarDesign('Nominee details added successfully!', context,
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
