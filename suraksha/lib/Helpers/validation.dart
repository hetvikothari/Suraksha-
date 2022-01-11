String? isValidPhone(value) {
  if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
    return 'Invalid Phone Number';
  }
  return null;
}

String? isValidEmail(value) {
  if (value.isEmpty) {
    return 'Email cannot be empty!';
  }
  if (!RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+[.][a-z]{2,3}$')
      .hasMatch(value)) {
    return 'Invalid Email Address';
  }
  return null;
}

String? isValidPassword(value) {
  if (value.length < 8) {
    return 'Password should hava atleast 8 characters!';
  }
  return null;
}

bool passwordsMatch(String pass1, String pass2) {
  if (pass1 == pass2) {
    return true;
  }
  return false;
}
