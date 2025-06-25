import 'package:intl/intl.dart';
import 'package:semeio_app/app/model/map_symbol.dart';

class Utils {
  static Map<String, MapSymbol> symbols = {
    "rio de janeiro": MapSymbol(
        description: "Símbolo do RJ",
        assetUrl: "assets/images/icons/riodejaneiro.png"),
    "bahia": MapSymbol(
        description: "Símbolo da bahia",
        assetUrl: "assets/images/icons/bahia.png"),
    "rio grande do norte": MapSymbol(
        description: "Símbolo do RN",
        assetUrl: "assets/images/icons/riograndedonorte.png"),
    "acre": MapSymbol(
        assetUrl: "assets/images/icons/acre.png",
        description: "Símbolo do Acre"),
    "ceará": MapSymbol(
        assetUrl: "assets/images/icons/ceara.png",
        description: "Símbolo do Ceará"),
    "piauí": MapSymbol(
        assetUrl: "assets/images/icons/piaui.png",
        description:
            "A Congada é uma festa cultural e religiosa afro-brasileira que mistura música, dança e teatro, celebrando a coroação do Rei do Congo. Homenageia santos como Nossa Senhora do Rosário e São Benedito. Com cortejos, tambores e cantos...")
  };
  static int calcAge(String birthDate) {
    DateTime birth = DateTime.parse(birthDate);
    DateTime today = DateTime.now();

    int age = today.year - birth.year;

    if (today.month < birth.month ||
        (today.month == birth.month && today.day < birth.day)) {
      age--;
    }

    return age;
  }

  static String getMonthName(int month) {
    List<String> months = [
      "",
      "Janeiro",
      "Fevereiro",
      "Março",
      "Abril",
      "Maio",
      "Junho",
      "Julho",
      "Agosto",
      "Setembro",
      "Outubro",
      "Novembro",
      "Dezembro"
    ];

    return (month >= 1 && month <= 12) ? months[month] : "Mês inválido";
  }

  static String formatDate(DateTime date) {
    final f = DateFormat("dd/MM/yyyy");
    return f.format(date);
  }

  static MapSymbol? getSymbol(String state) {
    String stateWithoutBlankAndUpper = state.toLowerCase().trim();
    MapSymbol? symbol = symbols[stateWithoutBlankAndUpper];
    return symbol ??
        MapSymbol(
            assetUrl: "assets/images/placeholder.png",
            description: "Símbolo não encontrado.");
  }
}
