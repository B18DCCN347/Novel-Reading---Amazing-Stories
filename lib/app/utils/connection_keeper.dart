class ConnectionKeeper {
  static Function? _callback;
  static void triggerCallback() {
    if (_callback != null) _callback!();
  }

  static void changeCallback(Function callback) {
    _callback = callback;
  }

  static void clear() {
    _callback = null;
  }
}
