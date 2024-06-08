import 'package:flutter/material.dart';
import 'package:pai_flutter/categoriasScreen.dart';
import 'package:pai_flutter/dashboardScreen.dart';
import 'package:pai_flutter/empleadosScreen.dart';
import 'package:pai_flutter/inventarioScreen.dart';
import 'package:pai_flutter/pagosScreen.dart';
import 'package:pai_flutter/pedidosScreen.dart';
import 'package:pai_flutter/proveedoresScreen.dart';
import 'package:pai_flutter/providers/screenProvider.dart';
import 'package:pai_flutter/utils/constants.dart';
import 'package:pai_flutter/ventasScreen.dart';
import 'package:provider/provider.dart';

class SideBar extends StatefulWidget {
  const SideBar({
    super.key,
  });

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  bool expandedCatalogs = false;

  @override
  Widget build(BuildContext context) {
  final screenManager = context.watch<ScreenProvider>();

  final expandedMenu = context.watch<ExpandableMenuProvider>();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 100,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: primaryColor,
              ),
              child: Image(
                image: AssetImage('assets/PAI-Logo.png'),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('DASHBOARD'),
            onTap: () {
              _changeScreen(context, const DashboardScreen());
            },
            tileColor: screenManager.currentScreen.runtimeType == DashboardScreen ? Colors.blue.withOpacity(0.2) : null,
          ),
          ListTile(
            leading: const Icon(Icons.inventory),
            title: const Text('INVENTARIO'),
            onTap: () {
              _changeScreen(context, const InventarioScreen());
            },
            tileColor: screenManager.currentScreen.runtimeType == InventarioScreen ? Colors.blue.withOpacity(0.2) : null,
          ),
          ListTile(
            leading: const Icon(Icons.monetization_on_outlined),
            title: const Text('VENTAS'),
            onTap: () {
              _changeScreen(context, const VentasScreen());
            },
            tileColor: screenManager.currentScreen.runtimeType == VentasScreen ? Colors.blue.withOpacity(0.2) : null,
          ),
          ListTile(
            leading: const Icon(Icons.add_shopping_cart_outlined),
            title: const Text('PEDIDOS'),
            onTap: () {
              _changeScreen(context, const PedidosScreen());
            },
            tileColor: screenManager.currentScreen.runtimeType == PedidosScreen ? Colors.blue.withOpacity(0.2) : null,
          ),
          ListTile(
            leading: const Icon(Icons.apps_outlined),
            title: const Text('CATÁLOGOS'),
            trailing:  expandedMenu.isExpanded ?  const Icon(Icons.arrow_drop_up_outlined) : const Icon(Icons.arrow_drop_down_outlined),
            onTap: () {
              setState(() {
                context.read<ExpandableMenuProvider>().updateExpanded(!expandedMenu.isExpanded);
              });
            },
          ),
          if (expandedMenu.isExpanded) ...{
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.people),
                  title: const Text('EMPLEADOS'),
                  onTap: () {
                    _changeScreen(context, const EmpleadosScreen());
                  },
                  tileColor: screenManager.currentScreen.runtimeType == EmpleadosScreen ? Colors.blue.withOpacity(0.2) : null,
                ),
                ListTile(
                  leading: const Icon(Icons.credit_card_outlined),
                  title: const Text('PAGOS'),
                  onTap: () {
                    _changeScreen(context, const PagosScreen());
                  },
                  tileColor: screenManager.currentScreen.runtimeType == PagosScreen ? Colors.blue.withOpacity(0.2) : null,
                ),
                ListTile(
                  leading: const Icon(Icons.category_outlined),
                  title: const Text('CATEGORÍAS'),
                  onTap: () {
                    _changeScreen(context, const CategoriasScreen());
                  },
                  tileColor: screenManager.currentScreen.runtimeType == CategoriasScreen ? Colors.blue.withOpacity(0.2) : null,
                ),
                ListTile(
                  leading: const Icon(Icons.assignment_ind_outlined),
                  title: const Text('PROVEEDORES'),
                  onTap: () {
                    _changeScreen(context, const ProveedoresScreen());
                  },
                  tileColor: screenManager.currentScreen.runtimeType == ProveedoresScreen ? Colors.blue.withOpacity(0.2) : null,
                ),
              ],
            ),
            ),
          }
        ],
      ),
    );
  }

  void _changeScreen(BuildContext context, Widget screen) {
    Navigator.of(context).pop();
    final screenManager = context.read<ScreenProvider>();
    screenManager.updateScreen(screen);
  }
}