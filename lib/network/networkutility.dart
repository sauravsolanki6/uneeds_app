class NetworkUtility {
  // static String base_api = "https://uneedsgold.com/ung_test/";
  static String base_api = "https://uneedsgold.com/";
  static String sign_up_api = base_api + "api-create-account";
  static String unique_mobile_api = base_api + "api-get-unique-mobile";
  static String unique_email_api = base_api + "api-get-unique-email";
  static String unique_referal_api = base_api + "api-get-exits-referal";
  static String otp_verify_api = base_api + "api-verify-otp";
  static String resend_otp = base_api + "api_resend_otp";
  static String login_api = base_api + "api-login";
  static String forgot_password_api = base_api + "api-forgot-password";
  static String change_password_api = base_api + "api-update-password";
  static String get_live_rate_api = base_api + "api-live-rate";
  static String get_onward_profile_api = base_api + "api-my-profile";
  static String get_state_api = base_api + "api-get-state";
  static String get_state_city_api = base_api + "api-get-state-city";
  static String get_kyc_status_api = base_api + "api-get-kyc-status";
  static String get_fees_api = base_api + "api-get-fees";
  static String product_list_api = base_api + "api-get-all-product";
  static String buy_gold_emi_api = base_api + "api-insert-emi-order";
  static String update_onward_profile_api =
      base_api + "api-update-onward-profile";
  static String submit_kyc_api = base_api + "api-insert-kyc";
  static String update_profile_api = base_api + "api-update-my-profile";
  static String insert_bank_detail_api = base_api + "api-insert-bank-details";
  static String get_bank_details_api = base_api + "api-get-bank-details";
  static String change_bank_account_api = base_api + "api-account-make-primary";
  static String delete_bank_account_api = base_api + "api-delete-bank-details";
  static String get_kyc_api = base_api + "api-get-kyc";
  static String get_address_api = base_api + "api-get-my-address";
  static String place_order_with_emi_api = base_api + "api-place-emi-order";
  static String my_gold_order_with_emi_api = base_api + "api-order-list";
  static String repayment_schedule_api = base_api + "api-repayment-schedule";
  static String referal_earn_api = base_api + "api-referral-earn";
  static String earn_history_api = base_api + "api-view-earn-history";
  static String withdraw_history_api = base_api + "api-view-withdraw-history";
  static String order_emi_invoice_api = base_api + "api_emi_innvoice";
  static String all_amount_api = base_api + "api_all_amount";
  static String emi_recepit_api = base_api + "api_emi_recepit";
  static String emi_charge_paid_history_api =
      base_api + "api_emi_charge_paid_history";
  static String emi_charge_history_api = base_api + "api_emi_charge_history";
  static String buy_gold_checkout_api = base_api + "api_buy_gold_checkout";
  static String place_gold_order_api = base_api + "api_buy_gold_place_order";
  // static String send_request_api = base_api + "api_send_withdraw_request";//Not in use
  static String send_request_api = base_api + "api_send_withdraw_request_new";
  static String emi_pay_from_wallet_api =
      base_api + "api_monthly_emi_payment_wallet";

  static String referal_customer_list_api =
      base_api + "api_all_referal_customer";

  static String tds_history_api = base_api + "api_tds_deduct_history";
  static String purchase_history_api =
      base_api + "api_get_total_purchase_order";

  static String profit_list_api = base_api + "api_get_order_profit";
  static String api_product_innvoice = base_api + "api_product_innvoice";
  static String place_order_api = base_api + "api_check_prodcut_order_placed";
  static String confirm_order_api =
      base_api + "api_get_product_order_confirmed";
  static String shiped_order_api = base_api + "api_get_product_order_shipped";
  static String delivered_order_api =
      base_api + "api_check_prodcut_order_delivered";
  static String api_update_the_emi_pay_status =
      base_api + "api_update_the_emi_pay_status";
  static String api_update_the_product_pay_status =
      base_api + "api_update_product_buy_phone_pay";
  static String api_pay_emi_amount_through_gateway =
      base_api + "api_pay_emi_amount_through_gateway";

  static String api_initiate_cc_avenue_url =
      base_api + "api_initiate_cc_avenue";
  static String update_cc_avenue_emi_purchase_api =
      base_api + "api_update_the_ccavnue_emi_purchase";

  static String api_initiate_cc_avenue_request_for_emi =
      base_api + "api_initiate_cc_avenue_request_for_emi";
  static String api_update_the_ccavnue_emi_pay =
      base_api + "api_update_the_ccavnue_emi_pay";

  static String api_initiate_cc_avenue_for_product =
      base_api + "api_initiate_cc_avenue_for_product";

  static String api_update_ccavnue_product_response =
      base_api + "api_update_ccavnue_product_response";
  static String api_integrate_enach_setup =
      base_api + "api_integrate_enach_setup";
  static String api_enach_setup = base_api + "api_enach_setup";
  static String api_view_emi_order = base_api + "api_view_emi_order";
  static String api_check_emi_order_placed =
      base_api + "api_check_emi_order_placed";

  static String api_check_emi_order_confirmed =
      base_api + "api_check_emi_order_confirmed";
  static String api_check_emi_order_shipped =
      base_api + "api_check_emi_order_shipped";
  static String api_check_emi_order_delivered =
      base_api + "api_check_emi_order_delivered";
  static String api_initiate_phone_pay_url =
      base_api + "api_initiate_phone_pay_url";

  static String api_new_initiate_product_buy =
      base_api + "api_new_initiate_product_buy";
  static String api_add_nominee_url = base_api + "api_add_nominee";
  static String api_transfer_amount_url = base_api + "api_transfer_amount";
  static String api_wallet_debit_history_url =
      base_api + "api_wallet_debit_history";
  static String api_user_wallet_amount_url =
      base_api + "api_user_wallet_amount";

  static String api_wallet_credit_history_url =
      base_api + "api_wallet_credit_history";
  static String api_get_product_buy_order_details_through_wallet_url =
      base_api + "api_get_product_buy_order_details_through_wallet";
  static String api_update_the_wallet_buy_product_status_url =
      base_api + "api_update_the_wallet_buy_product_status";
  static String api_update_the_wallet_emi_gold_purchase_url =
      base_api + "api_update_the_wallet_emi_gold_purchase";
  static String api_update_emi_pay_through_wallet_url =
      base_api + "api_update_emi_pay_through_wallet";
  static String api_active_payment_way_url =
      base_api + "api_active_payment_way";
  static String api_delete_account_url = base_api + "api_delete_account";
  static String api_set_address_url = base_api + "api_set_address";
  static String update_customer_id_url =
      base_api + "api_update_buy_gold_customer_id";
  static String api_generate_enach_token_url =
      base_api + "api_generate_enach_token";
  static String api_get_enach_response_url =
      base_api + "api_get_enach_response";
  static String set_buy_product_by_uneed_wallet_url =
      base_api + "set_buy_product_by_uneed_wallet";
  static String update_emi_pay_through_uneeds_wallet_url =
      base_api + "update_emi_pay_through_uneeds_wallet";
  static String uneeds_wallet_emi_purchase_product_by_unwallet_url = base_api +
      "uneeds_wallet_emi_purchase_product_by_unwallet"; //buy gold on emi unwallet pay

  static int sign_up = 1;
  static int unique_field = 2; //Same use for unique email address
  static int otp_verify = 3;
  static int login = 4;
  static int forgot_password = 5;
  static int change_password = 6; //this means change password
  static int get_live_rate = 7;
  static int get_onward_profile = 8;
  static int get_state = 9;
  static int get_state_city = 10;
  static int get_kyc_status = 11;
  static int get_fees = 12;
  static int product_list = 13;
  static int buy_gold_emi = 14;
  static int update_onward_profile = 15;
  static int update_profile = 16;
  static int submit_kyc = 17;
  static int insert_bank_detail = 18;
  static int get_bank_details = 19;
  static int change_bank_account = 20;
  static int get_kyc = 21;
  static int get_address = 22;
  static int place_order_with_emi = 23;
  static int my_gold_order_with_emi = 24;
  static int repayment_schedule = 25;
  static int referal_earn = 26;
  static int earn_history = 27;
  static int withdraw_history = 28;
  static int order_emi_invoice = 29;
  static int all_amount = 30;
  static int emi_recepit = 31;
  static int emi_charge_paid_history = 32;
  static int emi_charge_history = 33;
  static int buy_gold_checkout = 34;
  static int place_gold_order = 35;
  static int send_request = 36;
  static int emi_pay_from_wallet = 37;
  static int tds_history = 38;
  static int referal_customer_list = 39;
  static int purchase_history = 40;
  static int profit_list = 41;
  static int my_gold_order_without_emi = 42;
  static int product_innvoice = 43;
  static int track_order = 44;
  static int update_the_emi_pay_status = 45;
  static int pay_emi_amount_through_gateway = 46;
  static int api_initiate_cc_avenue = 47;
  static int update_cc_avenue_emi_purchase = 48;
  static int update_the_ccavnue_emi_pay = 49;
  static int update_ccavnue_product_response = 50;
  static int integrate_enach_setup = 51;
  static int enach_setup = 52;
  static int view_emi_order = 53;
  static int check_emi_order_placed = 54;
  static int initiate_phone_pay_url = 55; //Not use
  static int new_initiate_product_buy = 56; //Not use
  static int api_add_nominee = 57;
  static int api_transfer_amount = 58;
  static int api_wallet_debit_history = 59;
  static int api_user_wallet_amount = 60;
  static int api_wallet_credit_history = 61;
  static int api_get_product_buy_order_details_through_wallet = 62;
  static int api_update_the_wallet_buy_product_status = 63;
  static int api_update_the_wallet_emi_gold_purchase = 64;
  static int api_update_emi_pay_through_wallet = 65;
  static int api_active_payment_way = 66;
  static int api_delete_account = 67;
  static int api_set_address = 68;
  static int update_customer_id = 69;
  static int api_generate_enach_token = 70;
  static int api_get_enach_response = 71;
  static int set_buy_product_by_uneed_wallet = 72;
  static int update_emi_pay_through_uneeds_wallet = 73;
  static int uneeds_wallet_emi_purchase_product_by_unwallet =
      74; //buy gold on emi unwallet payment
}
