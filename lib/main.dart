import 'package:flutter/material.dart';

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

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      
      body:
        Column(
          children: <Widget>[
            Image.asset('assets/login.png'),
            Expanded(
              child: Align(
                alignment: Alignment(-0.7, -2.3),
                child: Image.asset('assets/logo.png', width: 160, height: 160),
              ),
            ),
            ElevatedButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (_) => SwipeScreen()));}, 
            child: Text('Navigate'),
            ),
          ],
        ),
    );
  }
}

class SwipeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Swipe Screen')),
      body: Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => InicioScreen()));
          },
          child: Text('Navigate'),
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

