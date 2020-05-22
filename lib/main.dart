import 'package:flutter/material.dart';
import 'package:red_social/postss.dart';
import 'package:red_social/posts_list.dart';
import 'package:red_social/coments_detail.dart';

//Proyecto Dispositivos Moviles
// De Lizbeth Garcia Requenes.
//Ingeniero: Alejandro Soto.
// Instituto Tecnologico de Saltillo.

void main(){ //Metodo main
  runApp(MaterialApp( //Usamos material App para el diseño y funcionamiento de la app
    title: "Red Social", // titulo para la app
    home: PostList(), // El nombre de la clase en donde iniciara nuestra app
    debugShowCheckedModeBanner: false,
  ));
}
