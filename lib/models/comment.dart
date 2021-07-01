// To parse this JSON data, do
//
//     final Comment = CommentFromJson(jsonString);

import 'dart:convert';

Comment commentFromJson(String str) => Comment.fromJson(json.decode(str));

String commentToJson(Comment data) => json.encode(data.toJson());

class Comment {
    Comment({
        this.id,
        this.content,
        this.name,
        this.image,
    });

    int id;
    String content;
    String name;
    String image;

    factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        content: json["content"],
        name: json["name"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "name": name,
        "image": image,
    };
}
