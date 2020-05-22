import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:red_social/globales.dart';
import 'package:red_social/globales.dart';
import 'package:red_social/posts_detail.dart';

class ComentsDetail extends StatefulWidget {  //Es una clase dinamica para poder llamar los comentarios la necesito
  @override
  _ComentsDetailState createState() => _ComentsDetailState(); // Creamos que sea State de stateful para poder mandar a llamar
}

class _ComentsDetailState extends State<ComentsDetail > { //Aqui en la clase privada Que ya creamos que extiende de la clase anterior
  bool loading = true; //Para verificar que si corresponda y baje informacion
  final String url = "https://jsonplaceholder.typicode.com/posts/" + p_idLiz + "/comments"; //Con esta usamos el url y la variable global donde tenemos los comentarios
  var client = http.Client(); // Cliente http del url para verificar que exista
  List<Comment> comment = List<Comment>(); //Creamos objetos y listas de tipo Comment y que se llaman coment

  @override
  void initState() { //Para mandar a llamar objetos de cada clase
    fetchData(); // Para mandar a llamar las apis y los objetos desde internet
    super.initState();
  }

  Future<void> fetchData() async { // lLAMA A OTRO MEtodo para predecir el valor que se generara
    http.Response response = await client.get(url); //Aqui nos ayuda a saber si tenemos respuesta de conecxion con el url
    if (response.statusCode == 200) {
      // Connection Ok
      List responseJson = json.decode(response.body); //Tambien para realizar una solicitud a los jsons
      responseJson.map((m) => comment.add(new Comment.fromJson(m))).toList(); //Aqui vamos a extraer o añadir elementos del json
      setState(() { // Para podr añadir widgets y objetos
        loading = false;
      });
    } else { //Y si no se puede establecer la conexion y enviar datos entonces envia un error
      throw ('error');
    }
  }

  @override
  Widget build(BuildContext context) { //Metodo para construir la app
    Widget nombrePost = Padding( //Aqui es donde vamos a mandar a llamar la publicacion
      padding: EdgeInsets.all(2.0),
      child: Card(color: Colors.white, elevation: 3.0, shape: new RoundedRectangleBorder( //Lo vamos a poner en una tarjeta
          borderRadius: new BorderRadius.circular(5.0)),
          child: ListTile( // Le damos formato y aqui un diseño al post qye sera fijo
            title: Text("POST: " + publicacion, style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          )),
    );

    Widget comments = Expanded( // Tenemos que hacer un expanded para que el post se quede fijo y los comentarios salgan a partir de ese post
        child: loading
            ? Container(
          child: Center(child: CircularProgressIndicator(), // Ponemos el circulo para indicar que esta cargando
          ),
        )
            : ListView.builder( // En el list view para poder poner los comentarios.
          itemCount: comment.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(margin: EdgeInsets.all(5.0), elevation: 3.0, shape: new RoundedRectangleBorder( //Igual le asignamos medidas
                  borderRadius: new BorderRadius.circular(5.0)),  //Y diseños a cada una
              child: ListTile( // Aqui es donde va el contenido
                title: Text(comment[index].body), //LLeva el cuerpo del comentario
                subtitle: Text("User: " + comment[index].email), //Agregue el email para ponerlo como user
                trailing: Icon(Icons.add), // Y un icono de agregar para que el usuario pueda responder a ese comentario
              ),
            );
          },
        ));
    return Scaffold( // En scafoold para la barra
        appBar: AppBar( //Agregamos la barra
          title: Text("Comments"), //tiene este nombre
          backgroundColor: Colors.pink, // de este color
        ),
        backgroundColor: Colors.pinkAccent, // Y el background que sea de este color
        body: Column( // Y en toda el column llevara el nombre del post y los comentarios
          children: <Widget>[nombrePost, comments],
        ));
  }
}

// Clase coment que puede ser como la misma de comments.dart pero aqui mismo para hacerlo mas facil
// Aqui es la clase de donde viene el json y se convierte a clase
class Comment {
  int postId;
  int id;
  String name;
  String email;
  String body;

  Comment({this.postId, this.id, this.name, this.email, this.body});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        postId: json['postId'],
        name: json['name'],
        email: json['email'],
        body: json['body']);
  }
}