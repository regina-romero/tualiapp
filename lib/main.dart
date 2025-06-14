import 'package:flutter/material.dart';
//import 'api_service.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // evita error de overflow
      body: Column(
        children: <Widget>[
          Image.asset('assets/login.png'),
          Expanded(
            child: Align(
              alignment: Alignment(-0.7, -2.6),
              child: Image.asset('assets/logo.png', width: 175, height: 175),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment(-0.7, -0.1),
              child: Text(
                'Inicio de sesión',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment(-0.9, -3), 
                child: SizedBox(
                  width: double.infinity,
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Correo Electrónico',
                      filled: true,
                      fillColor: Color(0xFFF2ECF2),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.arrow_circle_right_outlined,
                          color: Color(0xFFC8102E),
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => SwipeScreen()),
                          );
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment(-0.75, -1),
              child: Text(
                'Quiero Registrarme!',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,
                color: Colors.red, 
                decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class SwipeScreen extends StatefulWidget {
  @override
  _SwipeScreenState createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  Offset position = Offset(150, 300);
  Offset? _startPosition;
  DateTime? _startTime;

  Timer? _timer;
  int _seconds = 0;

  void _startTimer() {
    _timer?.cancel();
    _seconds = 0;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _seconds++;
      if (_seconds >= 5) {
        _timer?.cancel();
        _handleSwipeComplete();
      }
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    _seconds = 0;
  }

  void _handleSwipeComplete() {
    if (_startTime != null && _startPosition != null) {
      final duration = DateTime.now().difference(_startTime!).inMilliseconds / 1000.0;
      final delta = position - _startPosition!;
      final distance = delta.distance;
      final speed = distance / duration; // px/sec
      final angle = atan2(delta.dy, delta.dx) * (180 / pi); // in degrees

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("¡Éxito!"),
          content: Text(
            "Tiempo: ${duration.toStringAsFixed(2)} s\n"
            "Distancia: ${distance.toStringAsFixed(1)} px\n"
            "Velocidad: ${speed.toStringAsFixed(2)} px/s\n"
            "Ángulo: ${angle.toStringAsFixed(1)}°",
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text("OK")),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // AppBar
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
                ),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back, color: Colors.red),
                    SizedBox(width: 10),
                    Text(
                      "Regresar",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),
              Text(
                "Arrastra el objeto durante\n5 segundos",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 24),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: position.dx,
                        top: position.dy,
                        child: GestureDetector(
                          onPanStart: (details) {
                            _startTime = DateTime.now();
                            _startPosition = position;
                            _startTimer();
                          },
                          onPanUpdate: (details) {
                            setState(() {
                              position += details.delta;
                            });
                          },
                          onPanEnd: (_) {
                            _resetTimer();
                          },
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.red[700],
                              border: Border.all(color: Colors.red[900]!, width: 2),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              SizedBox(height: 30),
              Text("¿Teniendo Problemas?", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 6),
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Haz click aquí para recibir tu acceso por\ncorreo electrónico",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Términos de Privacidad",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}


class InicioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inicio Screen')),
      body: Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => CarritoScreen()));
          },
          child: Text('Navigate'),
  ),
),

    );
  }
}

class CarritoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(  //Allows to build screen with the UI elements, kinda like a div
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text(
          'Carrito', 
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            fontSize: 28,
          ),
          ),
          toolbarHeight: 80,
      ),
body: Container(
  decoration: BoxDecoration(
    color: const Color.fromARGB(255, 209, 204, 204),
  ),
  child: Stack(
    children: [
      Align(
        alignment: Alignment.topCenter,
        child: Container(
          alignment: Alignment.topRight,
          margin: const EdgeInsets.all(50),
          padding: const EdgeInsets.all(50),
          height: 250,
          width: 1500,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
          child: const Text('Fuze Tea de frutos rojos,Botella Pet 600 mL, 6 piezas'),
        ),
      ),
    ],
  ),
),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined), 
            label: 'Productos'
            ), 
          BottomNavigationBarItem(
            icon: Icon(Icons.star_border_outlined), 
            label: 'Gana'
            ), 
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined), 
            label: 'Inicio'
            ), 
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border), 
            label: 'Pedidios'
            ), 
          BottomNavigationBarItem(
            icon: Icon(Icons.menu), 
            label: 'Menu'
            ), 
          ], 
    ),
    );
  }
}

