import 'dart:convert';

List<Menu> menuFromJson(String str) =>
    List<Menu>.from(json.decode(str).map((x) => Menu.fromJson(x)));

String menuToJson(List<Menu> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Menu {
  Menu(
      {required this.iconoLeading,
        required this.iconoTrailing,
        required this.opcion,
        this.ruta = "",
        required this.children
        /* this.childrenSecundarios = const [], */
      });

  String iconoLeading;
  String iconoTrailing;
  String opcion;
  String ruta;
  List<Menu>? children;
  /* List<Menu>? childrenSecundarios; */

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
      iconoLeading: json["iconoLeading"],
      iconoTrailing: json["iconoTrailing"],
      opcion: json["opcion"],
      ruta: json["ruta"],
      children: json["children"] == null
          ? []
          : List<Menu>.from(json["children"]!.map((x) => Menu.fromJson(x)))
    /*  childrenSecundarios: json["childrenSecundarios"] == null
            ? []
            : List<Menu>.from(
                json["childrenSecundarios"]!.map((x) => Menu.fromJson(x))), */
  );

  Map<String, dynamic> toJson() => {
    "iconoLeading": iconoLeading,
    "iconoTrailing": iconoTrailing,
    "opcion": opcion,
    "ruta": ruta,
    "children": children == null
        ? []
        : List<dynamic>.from(children!.map((x) => x.toJson()))
    /*  "childrenSecundarios": childrenSecundarios == null
            ? []
            : List<dynamic>.from(childrenSecundarios!.map((x) => x.toJson())), */
  };
}
