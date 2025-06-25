class DateFormatter {
  DateFormatter._();

  static String toPostgreSql(String date) {
    List<String> parts = date.split('/');
    return "${parts[2]}-${parts[1]}-${parts[0]}"; // Converte para YYYY-MM-DD
  }

  static String toBrazilian(String date) {
    List<String> parts = date.split('-');
    return "${parts[2]}/${parts[1]}/${parts[0]}"; // Converte para DD/MM/YYYY
  }
}
