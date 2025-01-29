class AppExceptions implements Exception{

final String? message;
final String? prefix;

AppExceptions({this.message,this.prefix});

@override
String toString(){
  return '${prefix ?? ""} ${message ?? ""}';
}

}

class NoInternetException extends AppExceptions{
  NoInternetException({
    String? message
  }):super(message: message ?? "No Interent Connection");
}

class UnauthorisedException extends AppExceptions {
  UnauthorisedException({String? message})
      : super(
          message: message ?? "Token is expired",
        );
}

class RequestTimeOutException extends AppExceptions {
  RequestTimeOutException({String? message})
      : super(
          message: message ?? "Time Out ",
        );
}

class FetchDataException extends AppExceptions {
  FetchDataException({String? message})
      : super(
          message: message ?? "Unable to fetch the data ",
        );
}
