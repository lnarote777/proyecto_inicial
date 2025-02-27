import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//Clase principal
class LoginScreen extends StatefulWidget {

  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const LoginScreen({super.key, required this.toggleTheme, required this.isDarkMode});


  @override
  State<LoginScreen> createState() => _LoginScreenState();
  
}


class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Campos vacíos'),
          content: const Text('Por favor, ingresa tu Email y Password para continuar.'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Moodia Login'),
          actions: [
            IconButton(
              icon: const Icon(Icons.brightness_4_rounded),
              onPressed: widget.toggleTheme,
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Bienvenido a Moodia',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 10),
              const Text(
                'Conecta con tus emociones cada día.',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 25),
              Image.asset(
                Theme.of(context).brightness == Brightness.light
                  ? "assets/moodiaLight.png" // Imagen para tema claro
                  : "assets/moodiaBlack.png",  // Imagen para tema oscuro
                width: 250,
                height: 250,
              ),
              SizedBox(height: 25),
              SizedBox(
                width: 350,
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email"
                  )
                )
              ),
              SizedBox(height: 25),
              SizedBox(
                width: 350,
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password"
                  )
                )
              ),
              SizedBox(height: 25),
              ElevatedButton(
                //desactivado hasta que se añada algo a los dos textfields
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 92, 196, 121),
                  fixedSize: Size(250, 45)),
                onPressed: (){
                  if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                    // Muestra el diálogo de alerta
                    _showAlertDialog();
                  } else {
                    Navigator.pushNamed(context, '/home_screen');
                  }
                }, 
                child: Text("Login")
              ),
            ],
          ),
        ),
      );
    }
}

