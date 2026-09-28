class Validators{
  Validators._();

  static final  RegExp _emailRegExp = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\'
    r'[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  );

  static String? validateEmail(String? value) {
    if(value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    if(!_emailRegExp.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if(value == null || value.isEmpty) {
      return 'Password is required';
    }
    if(value.length < 8) {
      return'Password must be at least 8 characters';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if(value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }
    if(value.trim().length < 9) {
      return 'Please enter a valid phone number';
    }
    return null;
  }
  static String? validateRequired(String? value, String fieldName) {
    if(value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }
}