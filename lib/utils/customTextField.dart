import 'package:flutter/material.dart';
import 'package:pai_flutter/utils/constants.dart';
import 'package:pai_flutter/utils/spacers.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textTEC;
  final String label;

  const CustomTextField({
    super.key,
    required this.textTEC,
    required this.label,
  });


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 16
            ),
          ),
          const VerticalSpace(5),
          TextFormField(
            controller: textTEC,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              filled: true,
              fillColor: const Color(0x7CD1D1D1),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: primaryColor,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  width: 1,
                  color: Colors.white,
                ),
              ),
            ),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}