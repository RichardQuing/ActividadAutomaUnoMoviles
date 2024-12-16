import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/comentarios.dart';
import 'package:flutter_application_1/screens/listaComentarios.dart';

class MiDrawer extends StatelessWidget {
  const MiDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: const Text("Comentarios"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Comentarios()),
            ),
          ),
          ListTile(
            title: const Text("Lista de comentarios"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ListaComentarios()),
            ),
          ),
        ],
      ),
    );
  }
}
