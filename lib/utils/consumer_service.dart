import 'package:http/http.dart' as http;

class ConsumerServices {
  String url = 'http://localhost';

  static Future<http.Response> _getMethod(url) async {
    return http.get(url);
  }
}
