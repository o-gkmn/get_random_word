class AddWordValidateMixin {
  String? nullCheck(String? value) {
    if (value!.isEmpty) {
      return "Boş alanın doldurulması zorunludur";
    }
    return null;
  }
}
