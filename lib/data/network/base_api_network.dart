abstract class BaseApiNetwork {
  Future<dynamic> getData(String url);

  Future<dynamic> postData(String url, var data);
}
