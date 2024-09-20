import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pai_flutter/models/categoriaModel.dart';
import 'package:pai_flutter/providers/categoriasProvider.dart';
import 'package:pai_flutter/utils/constants.dart';
import 'package:pai_flutter/utils/spacers.dart';
import 'package:pai_flutter/views/categorias/widgets/addCard.dart';
import 'package:pai_flutter/views/categorias/widgets/categoriaCard.dart';
import 'package:provider/provider.dart';

class CategoriasScreen extends StatefulWidget {
  const CategoriasScreen({Key? key}) : super(key: key);

  @override
  State<CategoriasScreen> createState() => _CategoriasScreenState();
}

class _CategoriasScreenState extends State<CategoriasScreen> {
  List<CategoriaModel> categoriasList = [];

  @override
  void initState() {
    loadCategorias();
    super.initState();
  }

  void loadCategorias() async {
    final categoriasProvider = context.read<CategoriasProvider>();
    await categoriasProvider.getCategorias();
    setState(() {
      categoriasList = categoriasProvider.categoriaList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Categorías',
              style: darkTitle,
            ),
            const VerticalSpace(20),
            Container(
              color: Colors.red,
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                runAlignment: WrapAlignment.spaceBetween,
                spacing: 10,
                runSpacing: 10,
                //TODO: Obtener el width de AddCard y CategoriaCard de forma dinamica (revistas)
                children: [
                  AddCard(
                    loadCategorias: loadCategorias,
                  ),
                  for (CategoriaModel categoria in categoriasList)
                    CategoriaCard(
                      categoria: categoria,
                      loadCategorias: loadCategorias,
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



// ignore: must_be_immutable
