import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:pai_flutter/utils/constants.dart';
import 'package:pai_flutter/views/categorias/widgets/bottomModal.dart';

class AddCard extends StatelessWidget {
  final VoidCallback loadCategorias;

  const AddCard({
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
            return BottomModal(
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