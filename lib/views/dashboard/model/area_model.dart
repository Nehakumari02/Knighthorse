class AreaModel {
  Message message;
  Data data;
  String type;

  AreaModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory AreaModel.fromJson(Map<String, dynamic> json) => AreaModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
        type: json["type"],
      );
}

class Data {
  List<Area> area;

  Data({
    required this.area,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        area: List<Area>.from(json["area"].map((x) => Area.fromJson(x))),
      );
}

class Area {
  int id;
  String name;

  Area({
    required this.id,
    required this.name,
  });

  factory Area.fromJson(Map<String, dynamic> json) => Area(
        id: json["id"],
        name: json["name"],
      );
}

class Message {
  List<String> success;

  Message({
    required this.success,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        success: List<String>.from(json["success"].map((x) => x)),
      );
}
