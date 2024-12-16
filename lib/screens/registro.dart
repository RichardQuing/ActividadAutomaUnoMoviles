import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Registro extends StatelessWidget {
  const Registro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900], // Color similar al del login
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: formularioRegistro(),
      ),
      backgroundColor: Colors.grey[850], // Fondo oscuro similar al login
    );
  }
}

Widget formularioRegistro() {
  final TextEditingController _correo = TextEditingController();
  final TextEditingController _contrasena = TextEditingController();

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const Text(
        "Crea tu cuenta",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 40),
      TextField(
        controller: _correo,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: "Correo Electrónico",
          labelStyle: const TextStyle(color: Colors.blueGrey),
          prefixIcon: const Icon(Icons.email, color: Colors.blue),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
          filled: true,
          fillColor: Colors.grey[800],
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        ),
      ),
      const SizedBox(height: 16),
      TextField(
        controller: _contrasena,
        obscureText: true,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: "Contraseña",
          labelStyle: const TextStyle(color: Colors.blueGrey),
          prefixIcon: const Icon(Icons.lock, color: Colors.blue),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.blue, width: 2),
          ),
          filled: true,
          fillColor: Colors.grey[800],
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        ),
      ),
      const SizedBox(height: 24),
      ElevatedButton(
        onPressed: () => guardar(_correo.text, _contrasena.text),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.blueGrey[700],
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        child: const Text("Registrar", style: TextStyle(color: Colors.white)),
      ),
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "¿Ya tienes una cuenta? ",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              "Inicia sesión",
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
          ),
        ],
      ),
    ],
  );
}

Future<void> guardar(String correo, String contrasena) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("usuarios/");

  DatabaseReference newRef = ref.push();

  await newRef.set({
    "correo": correo,
    "contrasena": contrasena,
  });
}
