class myException implements Exception{
  String? _message;

  myException(String? message) {
    if(message == null){
      this._message = 'error';
    }else{
      this._message = message;
    }
  }
  @override
  String toString() {
    return _message!;
  }
}