class UserUrl {
  // Base URL for the API server 
  static const String baseUrl="https://vqp6fbbv-8001.inc1.devtunnels.ms/user";
  static const String userRegUrl = "$baseUrl/user_register/";
  static const String loginUrl = "$baseUrl/login/";
  static const String vehicleRegUrl = "$baseUrl/user_register_vehicle/";
  static const String productListUrl = "$baseUrl/view_products/";//List all products on the service center 
  static const String simpleRepairRequestUrl = "$baseUrl/view_single_repair_request/";// repaire request 
  static const String simpleRepairRequestResponseUrl = "$baseUrl/user_update_status/";// repaire request 
  static const String update_statusUrl= "$baseUrl/user_update_status/";
  
  static const String userProfileUrl= "$baseUrl/user_view_profile/";

  static const String vehicleProfileUrl= "$baseUrl/user_register_vehicle/";
  static const String chargingStationUrl = "$baseUrl/view_ev_stations/";
  
}
