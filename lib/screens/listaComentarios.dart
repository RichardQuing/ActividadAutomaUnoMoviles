import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/screens/EditarComentario.dart';

class ListaComentarios extends StatefulWidget {
  const ListaComentarios({super.key});

  @override
  _ListaComentariosState createState() => _ListaComentariosState();
}

class _ListaComentariosState extends State<ListaComentarios> {
  final DatabaseReference _comentariosRef = FirebaseDatabase.instance.ref("comentarios");
  List<Map<String, dynamic>> _comentarios = [];

  @override
  void initState() {
    super.initState();
    _cargarComentarios();
  }

  Future<void> _cargarComentarios() async {
    _comentariosRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
      setState(() {
        _comentarios = data.entries.map((e) {
          final value = Map<String, dynamic>.from(e.value as Map);
          return {'idComentario': e.key, ...value};
        }).toList();
      });
    });
  }

  Future<void> _eliminarComentario(String id) async {
    await _comentariosRef.child(id).remove();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Comentario eliminado")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Comentarios"),
        backgroundColor: Colors.teal,
      ),
      body: _comentarios.isEmpty
          ? const Center(child: Text("No hay comentarios disponibles"))
          : ListView.builder(
              itemCount: _comentarios.length,
              itemBuilder: (context, index) {
                final comentario = _comentarios[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Redondeo de bordes
                  ),
                  elevation: 5, // Sombra para destacar las tarjetas
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16), // Espaciado interno
                    title: Text(
                      comentario['serie'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comentario['comentario'],
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Precio: ${comentario['precio']}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.teal),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditarComentario(
                                  idComentario: comentario['idComentario'],
                                  serie: comentario['serie'],
                                  comentario: comentario['comentario'],
                                  precio: comentario['precio'], // Se pasa el precio al editar
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _eliminarComentario(comentario['idComentario']),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
