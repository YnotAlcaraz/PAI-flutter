import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF0F0A53);
const TextStyle darkTitle = TextStyle(
  fontSize: 30,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

const TextStyle lightTitle = TextStyle(
  fontSize: 14,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

enum FetchingStatus {
  noData,
  waiting,
  done,
}
