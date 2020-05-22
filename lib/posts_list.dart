import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:red_social/postss.dart';
import 'package:http/http.dart' as http;
import 'package:red_social/globales.dart';
import 'package:red_social/coments_detail.dart';
import 'package:red_social/posts_detail.dart';

// Librerias que vamos a usar y es importante la http
// Pantalla principal


class PostList extends StatefulWidget { // Clase StateFulWidget
  @override
  _PostListState createState() => _PostListState(); //La definimos para crear el State
}

class _PostListState extends State<PostList> { // Creacion de la clase PostListState
  String url = "https://raw.githubusercontent.com/LizbethGarcia1/posts/master/posts.json"; //URL donde estan los Json y seran extraidos
  Postss posts; //Objeto de la clase Postss llamado posts

  @override
  void initState() {  // Se llama cuando el objeto se inserta, exactamente  Este método es muy útil, es similar a onCreate(). Durante este ciclo de vida también podemos verificar algunos aspectos del widget como: ¿está montado actualmente?
    super.initState(); // Necesario cuando se usa el initState
    fetchData(); // Obtener datos de internet
  }

  void fetchData() async { //Sinconizamos el fetchData
    var response = await http.get(url); //Aqui obtenemos el url donde vamos a leer los json
    var decodedJson = jsonDecode(response.body); // Variable de JsonDecode donde decodifica
    posts = Postss.fromJson(decodedJson); // De aqui los vamos los vamos a estar extrayendo, y leyendo
    setState(() { //Para programaciones actuales en el componente local

    });
  }

  @override
  Widget build(BuildContext context) { //Metodo de compilacion con contexto de compilación describe dónde se encuentra en el árbol de widgets de su aplicación
    return Scaffold( // Regresamos un Scaffold que es el diseño visual de un diseño de estructura
      appBar: AppBar( // AppBar es la barra que va arriba de la app
        title: Text("Liz's Social Network"), // Este es el nombre que le puse a mi app
        backgroundColor: Colors.pink, // Y sera de este color
      ),
      backgroundColor: Colors.pinkAccent, //Este es el color del fondo de pantalla

      body: posts==null ? Center(child: CircularProgressIndicator(),) : // Aqui ponemos el circulo de progreso que se pone mientras se cargan los datos de la app
      ListView( // Usaemos ListView para hacer una lista deslizante de elementos y que // todo se vea en una sola columna
        children: posts.posts.map((p)=> Padding( //Aqui mandamos a llamar los elementos del Json con un padding
          padding: const EdgeInsets.all(3.0), // Aqui con un padding le damos uno de 3 a todo
          child: Container( // con un container hacemos la tarjeta o post el fondo
              width: 300, // que tenga estas medidas
              height: 90,
              padding: EdgeInsets.all(3.0), //Le damos este pading a todo

              child: Hero( // Con un heero de animacion
                  tag: p.id, //con tag cuando con el objeto p leemos el userId del json
                  child: FlatButton( // Ahora lo usaremos como boton para seleccionar e irnos a la siguiente pantalla
                    onPressed: (){ //AL momento de presionarlo

                      Navigator.push(context, MaterialPageRoute(builder: (context) => ComentsDetail ())); //Para dar clic y mandar a llamar esta pantalla correcta de los comentarios

                      // Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetail ())); // Para ir a esta pagina pero no funciona del todo


                      p_idLiz=p.id.toString();
                      publicacion = p.title;// Declarar que la variable global se vincule con la de id del post para que se convierta a string y nos muestre los comentarios
                    },
                    //Decoramos:
                    color: Colors.white, // Que tenga color blanco
                    child: Text( "Post: " + p.title, // Y aqui va el contenido que es la palabra post con el titulo o body del post
                      //Quise poner el titulo del post porque el body era demsiado largo.
                      style: TextStyle(fontWeight: FontWeight.w600, fontStyle: FontStyle.italic, fontSize: 18), //Le damos dicho estilo
                      textAlign: TextAlign.center, // Y que se centre.
                    ),
                  )
              )
          ),
        ))
            .toList(),
      ),
    );
  }
}