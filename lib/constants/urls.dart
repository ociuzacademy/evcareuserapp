class UserUrl {
  // Base URL for the API server
  static const String baseUrl = "https://5nr43kq1-8001.inc1.devtunnels.ms";
  static const String userbaseUrl = "$baseUrl/user";

  static const String userRegUrl = "$userbaseUrl/user_register/";
  static const String loginUrl = "$userbaseUrl/login/";
  static const String vehicleRegUrl = "$userbaseUrl/user_register_vehicle/";
  static const String productListUrl =
      "$userbaseUrl/view_products/"; //List all products on the service center
  static const String simpleRepairRequestUrl =
      "$userbaseUrl/view_single_repair_request/"; // repaire request
  static const String simpleRepairRequestResponseUrl =
      "$userbaseUrl/user_update_status/"; // repaire request
  static const String update_statusUrl = "$userbaseUrl/user_update_status/";

  static const String userProfileUrl = "$userbaseUrl/user_view_profile/";

  static const String vehicleProfileUrl = "$userbaseUrl/user_register_vehicle/";
  static const String chargingStationUrl = "$userbaseUrl/view_ev_stations/";
  static const String bookslotUlr = '$userbaseUrl/book_slot/';
  static const String view_single_charging_station =
      '$userbaseUrl/view_single_charging_station/';
  static const String feedback = '$userbaseUrl/feedback/';
  static const String user_purchased_products =
      "$userbaseUrl/user_purchased_products/";
  static const String list_service_centres =
      '$userbaseUrl/list_service_centres/';
  static const String repair_request = '$userbaseUrl/repair_request/';
  static const String view_single_product = '$userbaseUrl/view_single_product/';
  static const String buy_product = '$userbaseUrl/buy_product/';
  static const String view_repair_request =
      '$userbaseUrl/view_repair_requests/';
  static const String view_vehicle_profile =
      '$userbaseUrl/user_vehicle_profile/';
  static const String view_charging_history = '$userbaseUrl/booking_history/';
  static const String single_booking = "$userbaseUrl/single_booking/";
  static const String stop_charging = '$userbaseUrl/stop_charging/';
  static const String start_charging = '$userbaseUrl/start_charging/';
}
