class Validations {
  // validate email
  static String? validateEmail(String? value, [bool isRequried = true]) {
    if (value!.isEmpty && isRequried) return 'Email is required.';
    final RegExp nameExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    if (!nameExp.hasMatch(value) && isRequried) {
      return 'Please enter valid email address';
    }
    return null;
  }

  // validate first and last name
  static String? validateFName(String? value) {
    if (value!.isEmpty) {
      return 'Please your first name.';
    }
    RegExp nameExp = RegExp(r'^[A-Za-zğüşöçİĞÜŞÖÇ]*$');

    if (!nameExp.hasMatch(value)) {
      return 'Name must contain only alphabetical characters.';
    }
    return null;
  }

  // validate last name
  static String? validateLName(String? value) {
    if (value!.isEmpty) {
      return 'Please your last name.';
    }
    RegExp nameExp = RegExp(r'^[A-Za-zğüşöçİĞÜŞÖÇ]*$');

    if (!nameExp.hasMatch(value)) {
      return 'Name must contain only alphabetical characters.';
    }
    return null;
  }

  // Password validation
  static String? validatePassword(String? value) {
    if (value!.isEmpty || value.length < 8) {
      return 'Password must be 8 charaters long.';
    }
    if (!value.contains('@')) {
      return 'Password must contain @ symbol';
    }
    return null;
  }

  // Update Password validation
  static String? validateUPassword(String? value) {
    if ((value != null && value != '') && value.length < 8) {
      return 'Password must be 8 charaters long.';
    }
    if ((value != null && value != '') && !value.contains('@')) {
      return 'Password must contain @ symbol';
    }
    return null;
  }

  // ID number validation
  static String? validateIdNr(String? value) {
    if (value!.isEmpty) {
      return 'Enter your ID Number';
    }
    if (!(value.length == 13)) {
      return 'Password must be 13 digits long.';
    }
    final RegExp nrExp = RegExp(r"^[0-9]*$");
    if (!nrExp.hasMatch(value)) {
      return 'ID number must contain only digits.';
    }
    return null;
  }

  // Date of Birth validation
  static String? validateDob(String? value) {
    if (value!.isEmpty) {
      return 'Please select your Date of Birth.';
    }
    return null;
  }

  // Contact Number validation
  static String? validationContact(String? value) {
    if (value!.isEmpty) {
      return 'Enter your Contact Number';
    }
    if (!(value.length == 10)) {
      return 'Password must be 10 digits long.';
    }
    final RegExp nrExp = RegExp(r"^[0-9]*$");
    if (!nrExp.hasMatch(value)) {
      return 'Contact number must contain only digits.';
    }
    return null;
  }
}
