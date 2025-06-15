import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'http://10.0.2.2:5021/api'; // creo q hay q cambiarlo..

  // ---------- 1. REGISTRO ----------
  static Future<String> registerSwipe({
    required String email,
    required double angulo,
    required double tiempo,
    required double rapidez,
  }) async {
    final url = Uri.parse('$_baseUrl/auth/register');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'angulo': angulo,
        'tiempo': tiempo,
        'rapidez': rapidez,
      }),
    );

    if (response.statusCode == 200) {
      return "Registro exitoso";
    } else {
      return "Error: ${response.body}";
    }
  }

  // ---------- 2. LOGIN ----------
  static Future<String> loginSwipe({
    required String email,
    required double angulo,
    required double tiempo,
    required double rapidez,
  }) async {
    final url = Uri.parse('$_baseUrl/auth/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'angulo': angulo,
        'tiempo': tiempo,
        'rapidez': rapidez,
      }),
    );

    if (response.statusCode == 200) {
      return "Login exitoso";
    } else {
      return "Error: ${response.body}";
    }
  }

  // ---------- 3. LISTAR ARTÍCULOS ----------
  static Future<List<Map<String, dynamic>>> getArticulos() async {
    final url = Uri.parse('$_baseUrl/articulos/lista');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception("Error al obtener artículos");
    }
  }

  // ---------- 4. COMPRAR ARTÍCULO ----------
  static Future<String> comprarArticulo({
    required int articuloId,
    required int usuarioId,
  }) async {
    final url = Uri.parse('$_baseUrl/articulos/comprar');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'articulo_Id': articuloId,
        'usuario_Id': usuarioId,
      }),
    );

    if (response.statusCode == 200) {
      return "Compra realizada";
    } else {
      return "Error: ${response.body}";
    }
  }

  // ---------- 5. VER ARTÍCULOS COMPRADOS ----------
  static Future<List<Map<String, dynamic>>> getCompras(int usuarioId) async {
    final url = Uri.parse('$_baseUrl/articulos/comprados/$usuarioId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception("Error al obtener compras");
    }
  }
}
