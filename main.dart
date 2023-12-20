import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


var ResultadosArray = [];
var Temporal = "";
void main() {
  runApp(MyMemoryGame());
  
}

class Apiclient {
  final String apiUrl = 'https://bytunzjrnerlmnzuhkjj.supabase.co/rest/v1/Juego';
  Future<void> postScore(int puntuacion, String fecha) async {
    final Uri uri = Uri.parse(apiUrl);
    
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'apikey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ5dHVuempybmVybG1uenVoa2pqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDMwNjUxMTEsImV4cCI6MjAxODY0MTExMX0.RoI8CfNWr8vy0DtgZYP5nKnzqXVHshaEvBi9PVSgwu4',
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ5dHVuempybmVybG1uenVoa2pqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDMwNjUxMTEsImV4cCI6MjAxODY0MTExMX0.RoI8CfNWr8vy0DtgZYP5nKnzqXVHshaEvBi9PVSgwu4',
    };
    
    // Cuerpo  POST
    final Map<String, dynamic> body = {
      'Puntos': puntuacion,
      'Fecha': fecha,
    };

    final http.Response response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );


    print('Respuesta POST: ${response.statusCode}');
  }

  Future<void> printAllScores() async {
    final Uri uri = Uri.parse('$apiUrl?select=*');
    final Map<String, String> headers = {
      'apikey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ5dHVuempybmVybG1uenVoa2pqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDMwNjUxMTEsImV4cCI6MjAxODY0MTExMX0.RoI8CfNWr8vy0DtgZYP5nKnzqXVHshaEvBi9PVSgwu4', 
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ5dHVuempybmVybG1uenVoa2pqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDMwNjUxMTEsImV4cCI6MjAxODY0MTExMX0.RoI8CfNWr8vy0DtgZYP5nKnzqXVHshaEvBi9PVSgwu4',
    };

    final http.Response response = await http.get(
      uri,
      headers: headers,
    );

    print('Respuesta GET: ${response.statusCode}');

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      for (var record in data) {
        ResultadosArray.add(record);
        print(record);
      }
    } else {
      print('Error al obtener los datos.');
    }
  }

  Future<List<Map<String, dynamic>>> getScores() async {
    final Uri uri = Uri.parse('$apiUrl?select=*');
    
    final Map<String, String> headers = {
      'apikey': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ5dHVuempybmVybG1uenVoa2pqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDMwNjUxMTEsImV4cCI6MjAxODY0MTExMX0.RoI8CfNWr8vy0DtgZYP5nKnzqXVHshaEvBi9PVSgwu4',
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ5dHVuempybmVybG1uenVoa2pqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDMwNjUxMTEsImV4cCI6MjAxODY0MTExMX0.RoI8CfNWr8vy0DtgZYP5nKnzqXVHshaEvBi9PVSgwu4', 
    };

    final http.Response response = await http.get(
      uri,
      headers: headers,
    );

 
    print('Respuesta GET: ${response.statusCode}');

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {

      return [];
    }
  }
}

class MyMemoryGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyMemoryGamePage(),
    );
  }
}

class MyMemoryGamePage extends StatefulWidget {
  @override
  _MyMemoryGamePageState createState() => _MyMemoryGamePageState();
}

class CalculatePuntuacion {

  

}

class _MyMemoryGamePageState extends State<MyMemoryGamePage> {
  

  TextEditingController textEditingController1 = TextEditingController();
  bool MostarImagenes = true;
  bool MostrarPuntuacion = true;
  String Titulo1 = 'Bienvenido a tu juego de memoria de coches\n Acuerdate del ordenes de estas imagenes...';
  String Titulo2 = 'No quedan intentos';
  String HoraFinal = "";
  int contador = 0;
  int contador2 = 0;
  int Puntuacion= 0;
  var Hora;
  var ListaCorrecta = [1,2,3,4];
  var ListaUsuario = [];

void bucle(){

  var y = ResultadosArray.length-5;
  for(var x  = y; x < ResultadosArray.length; x++){
    Temporal = Temporal+ ResultadosArray[x].toString()+'\n';
  }
}

void CalculoDePuntos(){
  Puntuacion = 0;
  if(ListaUsuario.length >3)
    for(var i = 0; i < 4; i++){
    if (ListaCorrecta[i] == ListaUsuario [i])
      Puntuacion++;  
    }
  Date();
  if(contador2 == 4 && HoraFinal != "")
    guardar();
}

void Date(){
  Hora = DateTime.now();
  HoraFinal = Hora.toString();
}

void guardar (){
  final Apiclient apiClient = Apiclient();
  apiClient.postScore(Puntuacion,HoraFinal);
  final Future<List<Map<String, dynamic>>> puntuacion =  apiClient.getScores();
  apiClient.printAllScores();
}



  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Juego Tarea Flutter'),
        
        
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            if(contador == 2)
              Text(
                'Tu puntuacion es: $Puntuacion \n La fecha de la partida es: $Hora',
                style: TextStyle(fontSize: 50.0),
                ),
            if((contador <2) & (contador2 < 4))
              Text(
                '$Titulo1',
                style: TextStyle(fontSize: 30.0),
                ),
            if((contador2 >= 4) & (contador <2)) 
              Text(
                '$Titulo2',
                style: TextStyle(fontSize: 30.0),
                ), 
            SizedBox(height: 70.0),
            if (MostarImagenes & MostrarPuntuacion == true)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Image.asset('imagenes/imagen2.jpg', width: 80.0, height: 80.0),
                SizedBox(width: 30.0),
                Image.asset('imagenes/imagen1.jpg', width: 80.0, height: 80.0),
                SizedBox(width: 30.0),
                Image.asset('imagenes/imagen3.jpg', width: 80.0, height: 80.0),
                SizedBox(width: 30.0),
                Image.asset('imagenes/imagen4.jpg', width: 80.0, height: 80.0),
              ],
              
              )
              
            else
            if(MostarImagenes==false & (MostrarPuntuacion==false))
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                
                children: [
                Image.asset('imagenes/imagen1.jpg', width: 120.0, height: 80.0),
               
                Image.asset('imagenes/imagen4.jpg', width: 130.0, height: 80.0),
                SizedBox(height: 120.0),
                
                Image.asset('imagenes/imagen2.jpg', width: 130.0, height: 80.0),
                
  
                Image.asset('imagenes/imagen3.jpg', width: 120.0, height: 80.0),
                ]
              ),
            if(MostarImagenes==false & (MostrarPuntuacion==false))
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                
                children: [
                  if(contador2 < 4)
                    ElevatedButton(
                      onPressed: () => setState(() {
                        ListaUsuario.add(2);
                        contador2++;
                        print(contador2);
                        print(ListaUsuario);
                     }),
                      child: Text('1'),
                    ),
                  SizedBox(width: 70.0),
                  
                  if(contador2 < 4)
                    ElevatedButton(
                      onPressed: () => setState(() {
                        ListaUsuario.add(4);
                        contador2++;
                        print(ListaUsuario);
                      }),
                      child: Text('2'),
                    ),
                    SizedBox(width: 70.0),

                  if(contador2 < 4)
                    ElevatedButton(
                      onPressed: () => setState(() {
                        ListaUsuario.add(1);
                        contador2++;
                        print(ListaUsuario);
                      }),
                      child: Text('3'),
                    ),
                    SizedBox(width: 70.0),
                  if(contador2 < 4)
                    ElevatedButton(
                      onPressed: () => setState(() {
                        ListaUsuario.add(3);
                        contador2++;
                        print(ListaUsuario);
                      }),
                      child: Text('4'), 
                    ),
                  
                ],
              ),
            
            if(contador == 3)
              
              Text(
                  '$Temporal',
                style: TextStyle(fontSize: 50.0),
                ),
            if(contador ==2)
              ElevatedButton(
                      onPressed: () => setState(() {
                        contador++;
                        bucle();
                      }),
                      child: Text('Guardar'),
                    ),
                    SizedBox(width: 70.0),
            if(contador == 3)
              ElevatedButton(
                    onPressed: () => setState(() {
                      contador = 0;
                      contador2 = 0;
                      MostarImagenes = true;
                      MostrarPuntuacion = true;
                      Titulo1 = 'Bienvenido al juego, pulse jugar para empezar.\n Acuerdate del ordenes de estas imagenes...';
                    }),
                    child: Text('Guardar'),
                  ),
                    SizedBox(width: 70.0),
            
            SizedBox(height: 20.0),
            if(contador <2)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    CalculoDePuntos();
                    MostarImagenes =  !MostarImagenes;
                    MostrarPuntuacion = false;
                    Titulo1 = 'Adivina el orden de las imagenes';
                    contador ++;
                  });
                },
                child: Text(MostarImagenes ? 'Jugar' : 'Siguiente'),
              ),
            
            
          ],
        ),
      ),
    );
  }
}