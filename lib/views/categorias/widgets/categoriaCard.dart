import 'package:flutter/material.dart';
import 'package:pai_flutter/models/categoriaModel.dart';
import 'package:pai_flutter/views/categorias/widgets/bottomModal.dart';

class CategoriaCard extends StatelessWidget {
  final CategoriaModel categoria;
  final VoidCallback loadCategorias;

  const CategoriaCard({
    super.key,
    required this.categoria,
    required this.loadCategorias,
  });


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return BottomModal(
              isEditing: true,
              loadCategorias: loadCategorias,
              categoriaParam: categoria,
            );
          }
        );
      },
      child: Container(
        width: 150,
        height: 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color(0x3C9E9E9E),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                categoria.descripcion,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w300
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}