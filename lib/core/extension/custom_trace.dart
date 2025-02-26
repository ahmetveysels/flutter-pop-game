class CustomTrace {
  final StackTrace _trace;

  String? fileName;
  String? functionName;
  String? callerFunctionName;
  int? lineNumber;
  int? columnNumber;

  CustomTrace(this._trace) {
    _parseTrace();
  }

  String _getFunctionNameFromFrame(String frame) {
    var currentTrace = frame;

    var indexOfWhiteSpace = currentTrace.indexOf(' ');

    var subStr = currentTrace.substring(indexOfWhiteSpace);

    var indexOfFunction = subStr.indexOf(RegExp(r'[A-Za-z0-9]'));

    subStr = subStr.substring(indexOfFunction);

    indexOfWhiteSpace = subStr.indexOf(' ');

    subStr = subStr.substring(0, indexOfWhiteSpace);

    return subStr;
  }

  void _parseTrace() {
    var frames = _trace.toString().split("\n");

    functionName = _getFunctionNameFromFrame(frames[0]);
  }
}
