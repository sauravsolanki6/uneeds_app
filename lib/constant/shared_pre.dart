import 'package:UNGolds/constant/printmessage.dart';
import 'package:UNGolds/constant/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  late SharedPreferences sharedPreferences;

  Future setValueToSharedPrefernce(
      String key, String Value, BuildContext context) async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      return sharedPreferences.setString(key, Value);
    } catch (e) {
      PrintMessage.printmessage(e.toString(), 'setValueToSharedPrefernce',
          'SharedPreference', context);
    }
  }

  Future<String?> getValueFromSharedPrefernce(
      String key, BuildContext context) async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      String? abc = sharedPreferences.getString(key);
      if (abc == null) {
        return "";
      } else {
        return abc;
      }
    } catch (e) {
      PrintMessage.printmessage(e.toString(), 'getValueFromSharedPrefernce',
          'SharedPreference', context);
    }
    return "";
  }

  savevaluetosharedpref(String id, String name, BuildContext context) {
    try {
      SharedPreference().setValueToSharedPrefernce("Id", id, context);
      SharedPreference().setValueToSharedPrefernce("Name", name, context);
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), "savevaluetosharedpref", 'Sharedpref', context);
    }
  }

  savevalueonlogin(String id, String name, String mobilenumber, String password,
      BuildContext context) {
    try {
      SharedPreference().setValueToSharedPrefernce("Id", id, context);
      SharedPreference().setValueToSharedPrefernce("Name", name, context);

      SharedPreference()
          .setValueToSharedPrefernce("MobileNumber", mobilenumber, context);
      SharedPreference()
          .setValueToSharedPrefernce("Password", password, context);
      AppUtility.ID = id;
      AppUtility.NAME = name;
      AppUtility.MobileNumber = mobilenumber;
      AppUtility.Password = password;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), 'savevalueonlogin', 'SharedPreference', context);
    }
  }

  getvalueonligin(BuildContext context) async {
    try {
      AppUtility.ID = (await SharedPreference()
          .getValueFromSharedPrefernce("Id", context))!;

      AppUtility.SingUpDone = (await SharedPreference()
          .getValueFromSharedPrefernce("SignUpDone", context))!;
      AppUtility.NAME = (await SharedPreference()
          .getValueFromSharedPrefernce("Name", context))!;

      AppUtility.MobileNumber = (await SharedPreference()
          .getValueFromSharedPrefernce("MobileNumber", context))!;
      AppUtility.Password = (await SharedPreference()
          .getValueFromSharedPrefernce("Password", context))!;
    } catch (e) {
      PrintMessage.printmessage(
          e.toString(), 'getvalueonlogin', 'SharedPreference', context);
    }
  }
}
