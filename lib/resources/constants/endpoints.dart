class EndPoints {
  static const String baseURl = "http://192.168.1.2:8000/";
  // static const String baseURl = "https://demoapi-c96s.onrender.com/";
  static const String registerUser = baseURl + "user/auth/register";
  static const String loginUser = baseURl + "user/auth/login";
  static const String roles = baseURl + "role";
  static const String filterRoles = baseURl + "role/api/roles/role";
  static const String websocketUrl = "http://192.168.1.2:4004";
  // static const String websocketUrl = "https://webrtc-nje6.onrender.com/";
}
