import 'package:flutter/material.dart';
import 'package:pai_flutter/models/categoriaModel.dart';
import 'package:pai_flutter/services/categoriaService.dart';
import 'package:pai_flutter/utils/constants.dart';

class CategoriasProvider extends ChangeNotifier {
  List<CategoriaModel> categoriaList = [];
  FetchingStatus fetchingStatus = FetchingStatus.waiting;
  
  getCategorias() async {
    try {
      categoriaList = await CategoriaService.instance.getCategorias();
      fetchingStatus = categoriaList.isEmpty ? FetchingStatus.noData : FetchingStatus.done;
      notifyListeners();
    } catch (err) {
      categoriaList = [];
      fetchingStatus = FetchingStatus.noData;
      notifyListeners();
    }
  }
}