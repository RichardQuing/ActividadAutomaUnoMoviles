import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/navegadores/drawer.dart';
import 'package:flutter_application_1/screens/listaComentarios.dart';

class Comentarios extends StatelessWidget {
  const Comentarios({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _serieController = TextEditingController();
    final TextEditingController _comentarioController = TextEditingController();
    final TextEditingController _precioController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Comentarios",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      drawer: MiDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              "Escribe tu comentario",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _serieController,
              decoration: InputDecoration(
                label: const Text("Titulo"),
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
              onPressed: () => guardarComentario(context, _serieController.text, _comentarioController.text, _precioController.text),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: const TextStyle(fontSize: 18),
                backgroundColor: Colors.teal,
              ),
              child: const Text("Guardar Comentario", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
    );
  }

  Future<void> guardarComentario(BuildContext context, String serie, String comentario, String precio) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("comentarios");

    String idComentario = ref.push().key ?? "id_único";

    Comentario nuevoComentario = Comentario(
      idComentario: idComentario,
      serie: serie,
      comentario: comentario,
      precio: precio,
    );

    await ref.child(idComentario).set(nuevoComentario.toMap());

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Comentario guardado")));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ListaComentarios()),
    );
  }
}

class Comentario {
  final String idComentario;
  final String serie;
  final String comentario;
  final String precio;

  Comentario({
    required this.idComentario,
    required this.serie,
    required this.comentario,
    required this.precio,
  });

  Map<String, dynamic> toMap() {
    return {
      'idComentario': idComentario,
      'serie': serie,
      'comentario': comentario,
      'precio': precio,
    };
  }
}
