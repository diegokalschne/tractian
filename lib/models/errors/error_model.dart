enum ErrorType { generic, http, internet }

class ErrorModel implements Exception {
  ErrorModel(this.description, {this.callback, this.errorCode}) : type = ErrorType.generic;

  ErrorModel.internet({this.description = 'Não há conexão com à internet. Verifique o seu wifi ou dados móveis', this.callback, this.errorCode}) : type = ErrorType.internet;

  ErrorModel.http(this.description, {this.callback, this.errorCode}) : type = ErrorType.http;

  final String description;
  final ErrorType type;
  final Future Function()? callback;
  final int? errorCode;

  @override
  String toString() {
    return description;
  }
}
