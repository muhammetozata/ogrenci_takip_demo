mixin FormValidation {
  String textFieldIsEmpty(String name, String value) {
    if (value.isEmpty) {
      return "$name alanını doldurunuz.";
    }

    if (value.length <= 2) {
      return "$name alanını 2 karakterden büyük olmak zorundadır.";
    }
    return null;
  }

  String textFieldIsInt(String name, String value) {
    if (value.isEmpty) {
      return "$name alanını doldurunuz.";
    }

    int i = int.parse(value);
    if (i <= 0 || i > 100) {
      return "$name alanını 0-100 arasında olmak zorundadır.";
    }
    return null;
  }
}
