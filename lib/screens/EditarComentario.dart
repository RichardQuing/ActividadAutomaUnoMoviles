import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class EditarComentario extends StatefulWidget {
  final String idComentario;
  final String serie;
  final String comentario;
  final String precio; // Se añadió el campo de precio

  const EditarComentario({
    super.key,
    required this.idComentario,
    required this.serie,
    required this.comentario,
    required this.precio, // Se añadió el campo de precio al constructor
  });

  @override
  _EditarComentarioState createState() => _EditarComentarioState();
}

class _EditarComentarioState extends State<EditarComentario> {
  late TextEditingController _serieController;
  late TextEditingController _comentarioController;
  late TextEditingController _precioController; // Se añadió el controlador para el campo de precio

  @override
  void initState() {
    super.initState();
    _serieController = TextEditingController(text: widget.serie);
    _comentarioController = TextEditingController(text: widget.comentario);
    _precioController = TextEditingController(text: widget.precio); // Se inicializa el controlador del precio
  }

  Future<void> _guardarCambios() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("comentarios").child(widget.idComentario);

    await ref.update({
      'serie': _serieController.text,
      'comentario': _comentarioController.text,
      'precio': _precioController.text, // Se añade el campo de precio
    });

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Comentario actualizado")));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Comentario"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _serieController,
              decoration: InputDecoration(
                label: const Text("Título"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _comentarioController,
              decoration: InputDecoration(
                label: const Text("Comentario"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _precioController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: const Text("Precio"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _guardarCambios,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: const TextStyle(fontSize: 18),
                backgroundColor: Colors.teal,
              ),
              child: const Text("Guardar Cambios", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
