//Clase de comentarios en donde se guarda la clase de Jsons obtenida al convertirla de Json a class
// Pero es mejor usarlo todo junto como el ejemplo de coments_detail que ahi esta ya la clase con la clase de json
// sin estar separado.
// Funcionaria con post_detail pero no es la correcta, la correcta es coments_detail
// NO se usa para el proyecto! Pero puede servir como opcion B

class Comments {
  List<Comment> comment;

  Comments({this.comment});

  Comments.fromJson(Map<String, dynamic> json) {
    if (json['comments'] != null) {
      comment = new List<Comment>();
      json['comments'].forEach((v) {
        comment.add(new Comment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.comment != null) {
      data['comments'] = this.comment.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comment {
  int postId;
  int id;
  String name;
  String email;
  String body;

  Comment({this.postId, this.id, this.name, this.email, this.body});

  Comment.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['postId'] = this.postId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['body'] = this.body;

    return data;
  }
}