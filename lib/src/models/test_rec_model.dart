// To parse this JSON data, do
//
//     final textRecModel = textRecModelFromJson(jsonString);

import 'dart:convert';

TextRecModel textRecModelFromJson(String str) => TextRecModel.fromJson(json.decode(str));

String textRecModelToJson(TextRecModel data) => json.encode(data.toJson());
  var des="";

class TextRecModel {
    TextRecModel({
        this.responses,
    });

    List<Response> responses;

  
    factory TextRecModel.fromJson(Map<String, dynamic> json) => TextRecModel(
        responses: List<Response>.from(json["responses"].map((x) => Response.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "responses": List<dynamic>.from(responses.map((x) => x.toJson())),
    };
}

class Response {
    Response({
        this.textAnnotations,
    });

    List<TextAnnotation> textAnnotations;

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        textAnnotations: List<TextAnnotation>.from(json["textAnnotations"].map((x) => TextAnnotation.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "textAnnotations": List<dynamic>.from(textAnnotations.map((x) => x.toJson())),
    };
}

class TextAnnotation {
    TextAnnotation({
        this.locale,
        this.description,
        this.boundingPoly,
    });

    String locale;
    String description;
    BoundingPoly boundingPoly;
    

    factory TextAnnotation.fromJson(Map<String, dynamic> json) => TextAnnotation(
        locale: json["locale"],
        description: json["description"],
        boundingPoly: BoundingPoly.fromJson(json["boundingPoly"]),
    );

  // final des=description;




    Map<String, dynamic> toJson() => {
        "locale": locale,
        "description": description,
        "boundingPoly": boundingPoly.toJson(),
    };
}

class BoundingPoly {
    BoundingPoly({
        this.vertices,
    });

    List<Vertex> vertices;

    factory BoundingPoly.fromJson(Map<String, dynamic> json) => BoundingPoly(
        vertices: List<Vertex>.from(json["vertices"].map((x) => Vertex.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "vertices": List<dynamic>.from(vertices.map((x) => x.toJson())),
    };
}

class Vertex {
    Vertex({
        this.x,
        this.y,
    });

    int x;
    int y;

    factory Vertex.fromJson(Map<String, dynamic> json) => Vertex(
        x: json["x"],
        y: json["y"],
    );

    Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
    };
}