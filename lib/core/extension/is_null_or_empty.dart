extension NullOrEmpty on dynamic {
  /// String? values if null or empty return true, not null or empty return false
  bool get isNullOrEmptyExt => _isfNullOrEmpty(this);
}

bool _isfNullOrEmpty(String? value) {
  if (value == null || value.isEmpty) {
    return true;
  } else {
    return false;
  }
}
