// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:pai_flutter/models/categoriaModel.dart';

class CategoriaService {
  final Duration maxTimeout = const Duration(seconds: 5);

  static CategoriaService get instance => CategoriaService();

  List<CategoriaModel> parseFromJsonList(String data) {
    try {
      final jsonData = jsonDecode(data) as List;
      return jsonData.map((categoria) => CategoriaModel.fromJson(categoria)).toList();
    } catch (err) {
      print('Error parsing JSON: $err');
      return [];
    }
  }

  Future<List<CategoriaModel>> getCategorias() async {
    try {
      final Response response = await get(
        Uri.parse('${dotenv.env['HOST']}/categorias'),
      ).timeout(maxTimeout);

      if (response.statusCode == 200) {
        return compute(parseFromJsonList, response.body);
      } else {
        print('HTTP Error: ${response.statusCode}');
        return [];
      }
    } catch (err) {
      print('Network Error: ${err.toString()}');
      return [];
    }
  }

  Future<void> postCategorias(CategoriaModel categoria) async {
    try {
      final response = await post(
        Uri.parse('${dotenv.env['HOST']}/categorias'),
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(categoria.toJson()),
      );

      if (response.statusCode == 200) {
        print('Categoria creada');
      } else {
        throw Exception('Error al crear categoria: ${response.statusCode}');
      }
    } catch (err) {
      throw Exception('Error de red: $err');
    }
  }

  Future<void> patchCategorias(CategoriaModel categoria) async {
    try {
      final response = await patch(
        Uri.parse('${dotenv.env['HOST']}/categorias/${categoria.id}'),
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(categoria.toJson()),
      );

      if (response.statusCode == 200) {
        print('Categoria editada');
      } else {
        throw Exception('Error al editar la categoria: ${response.statusCode}');
      }

    } catch (err) {
      throw Exception('Error de red: $err');
    }
  }

  Future<void> deleteCategorias(int categoriaId) async {
    try {
      final response = await delete(
        Uri.parse('${dotenv.env['HOST']}/categorias/$categoriaId'),
      );
      if (response.statusCode == 200) {
        print('Categoria eliminada');
      } else {
        throw Exception('Error al eliminar la categoria: ${response.statusCode}');
      }

    } catch (err) {
      throw Exception('Error de red: $err');
    }
  }
}