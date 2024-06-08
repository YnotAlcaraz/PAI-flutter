// ignore_for_file: use_build_context_synchronously, unused_element

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pai_flutter/models/categoriaModel.dart';
import 'package:pai_flutter/providers/categoriasProvider.dart';
import 'package:pai_flutter/services/categoriaService.dart';
import 'package:pai_flutter/utils/constants.dart';
import 'package:pai_flutter/utils/customButton.dart';
import 'package:pai_flutter/utils/customTextField.dart';
import 'package:pai_flutter/utils/spacers.dart';
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
            SizedBox(
              width: double.infinity,
              child: Align(
                alignment: Alignment.topLeft,
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _AddCard(
                      loadCategorias: loadCategorias,
                    ),
                    for (CategoriaModel categoria in categoriasList)
                      _CategoriaCard(
                        categoria: categoria,
                        loadCategorias: loadCategorias,
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _AddCard extends StatelessWidget {
  final VoidCallback loadCategorias;

  const _AddCard({
    super.key,
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
            return _BottomModal(
              isEditing: false,
              loadCategorias: loadCategorias,
            );
          }
        );
      },
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(5),
        dashPattern: const [6],
        color: primaryColor,
        strokeWidth: 2,
        child: const SizedBox(
          width: 146,
          height: 71,
          child: Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.add,
              size: 30,
              color: primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class _BottomModal extends StatelessWidget {
  final bool isEditing;
  final VoidCallback loadCategorias;
  late CategoriaModel? categoriaParam;

  _BottomModal({
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
                        // await CategoriaService.instance.deleteCategorias(categoriaParam!.id!);
                        // loadCategorias();
                        // Navigator.pop(context);
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

class _CategoriaCard extends StatelessWidget {
  final CategoriaModel categoria;
  final VoidCallback loadCategorias;

  const _CategoriaCard({
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
            return _BottomModal(
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