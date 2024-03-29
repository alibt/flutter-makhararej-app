extension Validators on String {
  bool isEmail() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }

  bool isStrongPassword() {
    final regex =
        RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$%\^&\*])(?=.{8,})');
    return regex.hasMatch(this);
  }

  String? emailValidator() {
    if ((isEmpty)) {
      return 'Please enter your email';
    }
    if (!isEmail()) {
      return 'Please enter a valid email';
    }
    return null;
  }
}
