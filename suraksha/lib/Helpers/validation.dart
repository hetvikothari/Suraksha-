bool isEmail(String email) {
  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(email)) {
    return false;
  }
  return true;
}

bool checkLength(String password) {
  if (password.length > 8) {
    return true;
  } else {
    return false;
  }
}

bool passwordsMatch(String pass1, String pass2) {
  if (pass1 == pass2) {
    return true;
  } else {
    return false;
  }
}
