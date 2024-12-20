class EndPoints {
  static const String baseURl = "http://192.168.1.33:8080/";
  static const String registerUser = baseURl + "user/auth/register";
  static const String loginUser = baseURl + "user/auth/login";
  static const String roles = baseURl + "role";
  static const String filterRoles = baseURl + "role/api/roles/role";
  static const String websocketUrl = "http://192.168.1.33:4004";
  // static const String websocketUrl = "https://webrtc-tgwt.onrender.com";
}
