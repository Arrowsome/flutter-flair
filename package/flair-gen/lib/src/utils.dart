abstract class Utils {
  static String opacToHex(int opac) =>
      ((opac / 100) * 255).round().toRadixString(16);
}
