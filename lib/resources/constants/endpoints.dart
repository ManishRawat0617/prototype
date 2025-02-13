class EndPoints {
  static const String baseURl = "http://192.168.1.6:9000/";
  // static const String baseURl = "https://demoapi-c96s.onrender.com/";
  static const String registerUser = baseURl + "user/auth/register";
  static const String loginUser = baseURl + "user/auth/login";
  static const String roles = baseURl + "role";
  static const String filterRoles = baseURl + "role/api/roles/role";
  static const String websocketUrl = "http://192.168.1.6:4004";
  // static const String websocketUrl = "https://webrtc-nje6.onrender.com/";

  static const String userDetails = baseURl + "userDetails/";
  static const String userDetailsRegister = baseURl + "userDetails/register";
  static const String userLogin = baseURl + "userDetails/login";
  static const String userDetailsUpdate = baseURl;
  static const String userDetailsDelete = baseURl;
  static const String userSearch = baseURl + "userDetails/filter";
  static const String userLanguageRegister = baseURl + "userLanguage/register";
  static const String userExperienceRegister =
      baseURl + "userExperience/register";

  static const String allLanguages = baseURl + "list/language";
  static const String allIndustryCategories = baseURl + "list/industryCategory";
  static const String allIndustryRole = baseURl + "list/newindustryRole";
}
