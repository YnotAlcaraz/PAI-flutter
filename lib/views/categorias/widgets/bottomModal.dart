import 'package:flutter/material.dart';
import 'package:pai_flutter/models/categoriaModel.dart';
import 'package:pai_flutter/services/categoriaService.dart';
import 'package:pai_flutter/utils/constants.dart';
import 'package:pai_flutter/utils/customButton.dart';
import 'package:pai_flutter/utils/customTextField.dart';
import 'package:pai_flutter/utils/spacers.dart';

// ignore: must_be_immutable
class BottomModal extends StatelessWidget {
  final bool isEditing;
  final VoidCallback loadCategorias;
  late CategoriaModel? categoriaParam;

  BottomModal({
    super.key,
    required this.isEditing,
    required this.loadCategorias,
    this.categoriaParam,
  });


  @override
  Widget build(BuildContext context) {
  final TextEditingController descripcionTEC = TextEditingController();
  if (isEditing && categoriaParam != null) {
    descripcionTEC.text = categoriaParam!.descripcion;
  }

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom
      ),
      child: SizedBox(
        width: double.infinity,
        height: 300,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 18, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 2,
                width: 200,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 148, 148, 148),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const VerticalSpace(20),
              CustomTextField(
                textTEC: descripcionTEC,
                label: 'Nombre de la categoría',
              ),
              const VerticalSpace(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    label: 'Guardar',
                    height: 40,
                    fontSize: 16,
                    backgroundColor: primaryColor,
                    onPressed: () async {
                      if (isEditing == false) {
                        CategoriaModel categoria = CategoriaModel(
                          descripcion: descripcionTEC.text
                        );
                        await CategoriaService.instance.postCategorias(categoria);
                        loadCategorias();
                        Navigator.pop(context);
                      } else {
                        CategoriaModel categoria = CategoriaModel(
                          id: categoriaParam!.id,
                          descripcion: descripcionTEC.text,
                        );
                        await CategoriaService.instance.patchCategorias(categoria);
                        loadCategorias();
                        Navigator.pop(context);
                      }
                    },
                  ),
                  if (isEditing == true) ...{
                    CustomButton(
                      label: 'Eliminar',
                      height: 40,
                      fontSize: 16,
                      backgroundColor: Colors.red,
                      onPressed: () async {
                        Navigator.pop(context);
                        _showConfirmDelete(context);
                      },
                    ),
                  } else ...{
                    const SizedBox(
                      width: 150,
                      height: 40,
                    ),
                  }
                ],
              ),
            ]
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showConfirmDelete(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar categoría'),
        content: const Text('¿Estás seguro de que quieres eliminar esta categoría?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Cancelar',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: primaryColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              await CategoriaService.instance.deleteCategorias(categoriaParam!.id!);
              loadCategorias();
              Navigator.pop(context);
            },
            child: const Text(
              'Aceptar',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

