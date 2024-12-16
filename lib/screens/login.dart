import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/screens/comentarios.dart';
import 'package:flutter_application_1/navegadores/drawer.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
      ),
      drawer: MiDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: formularioLogin(context),
      ),
      backgroundColor: Colors.grey[850],
    );
  }
}

Widget formularioLogin(BuildContext context) {
  final TextEditingController _correo = TextEditingController();
  final TextEditingController _contrasena = TextEditingController();

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const Text(
        "Inicia sesión para continuar",
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
        onPressed: () => iniciarSesion(context, _correo.text, _contrasena.text),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.blueGrey[700],
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        child: const Text("Iniciar Sesión", style: TextStyle(color: Colors.white)),
      ),
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "¿No tienes una cuenta? ",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              "Regístrate",
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
          ),
        ],
      ),
    ],
  );
}

Future<void> iniciarSesion(BuildContext context, String correo, String contrasena) async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("usuarios");

  final snapshot = await ref.get();
  if (snapshot.exists) {
    Map<dynamic, dynamic> usuarios = snapshot.value as Map<dynamic, dynamic>;

    bool encontrado = usuarios.values.any((usuario) {
      return usuario['correo'] == correo && usuario['contrasena'] == contrasena;
    });

    if (encontrado) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Inicio de sesión exitoso"),
            content: const Text("Bienvenido, has iniciado sesión correctamente."),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Comentarios()),
                  );
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text("Correo o contraseña incorrectos."),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: const Text("No se encontraron usuarios registrados."),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
