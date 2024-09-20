import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pai_flutter/views/categorias/categoriasScreen.dart';
import 'package:pai_flutter/views/empleados/empleadosScreen.dart';
import 'package:pai_flutter/views/inventario/inventarioScreen.dart';
import 'package:pai_flutter/views/pagos/pagosScreen.dart';
import 'package:pai_flutter/views/pedidos/pedidosScreen.dart';
import 'package:pai_flutter/views/proveedores/proveedoresScreen.dart';
import 'package:pai_flutter/providers/categoriasProvider.dart';
import 'package:pai_flutter/providers/screenProvider.dart';
import 'package:pai_flutter/utils/constants.dart';
import 'package:pai_flutter/utils/sidebar.dart';
import 'package:pai_flutter/views/ventas/ventasScreen.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(
    fileName: '.env',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ScreenProvider()),
        ChangeNotifierProvider(create: (_) => ExpandableMenuProvider()),
        ChangeNotifierProvider(create: (_) => CategoriasProvider()),
      ],
      child: MaterialApp(
        title: 'PAI',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          drawerTheme: DrawerThemeData(
            shape: Border.all(color: Colors.transparent), // Sin bordes
          ),
          fontFamily: 'Helvetica',
        ),
        //TODO: Change routes for MaterialPageRoute (?)
        initialRoute: '/',
        routes: {
          '/': (context) => MyHomePage(),
          '/inventario': (context) => const InventarioScreen(),
          '/ventas': (context) => const VentasScreen(),
          '/pedidos': (context) => const PedidosScreen(),
          '/empleados': (context) => const EmpleadosScreen(),
          '/pagos': (context) => const PagosScreen(),
          '/categorias': (context) => const CategoriasScreen(),
          '/proveedores': (context) => const ProveedoresScreen(),
        }
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenManager = context.watch<ScreenProvider>();

    return Scaffold(
      appBar: AppBar(
        // title: const Text(
        //   'PROYECTO DE ADMINISTRACIÓN DE INVENTARIOS',
        //   style: lightTitle,
        // ),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const SideBar(),
      body: screenManager.currentScreen,
    );
  }
}

