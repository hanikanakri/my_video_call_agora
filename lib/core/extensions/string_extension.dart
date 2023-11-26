extension StringExtensions on String {
  bool get hasOnlyWhitespaces => trim().isEmpty && isNotEmpty;

  bool get isEmptyOrNull {
    if (this == null) {
      return true;
    }
    return isEmpty;
  }

  bool get isNoInternetError => contains('SocketException: Failed host lookup');

  bool get isURLImage =>
      (isNotEmpty) && (contains('http') || contains('https'));

  String toSpaceSeparated() {
    final value =
        replaceAllMapped(RegExp(r'.{4}'), (match) => '${match.group(0)} ');
    return value;
  }

  String formatCopy() {
    return replaceAll('},', '\n},\n')
        .replaceAll('[{', '[\n{\n')
        .replaceAll(',"', ',\n"')
        .replaceAll('{"', '{\n"')
        .replaceAll('}]', '\n}\n]');
  }

  toUnsignedInteger() {
    try {
      final integer = int.parse(this);
      if (integer < 0) throw const FormatException();
      return integer.toString();
    } on FormatException {
      return 'Invalid';
    }
  }

  toInteger() {
    try {
      final integer = int.parse(this);
      return integer.toString();
    } catch (e) {
      return 'Invalid';
    }
  }
}
