import 'dart:convert';

TwoFaModel twoFaModelFromJson(String str) =>
    TwoFaModel.fromJson(json.decode(str));

String twoFaModelToJson(TwoFaModel data) => json.encode(data.toJson());

class TwoFaModel {
  Message message;
  Data data;
  String type;

  TwoFaModel({
    required this.message,
    required this.data,
    required this.type,
  });

  factory TwoFaModel.fromJson(Map<String, dynamic> json) => TwoFaModel(
        message: Message.fromJson(json["message"]),
        data: Data.fromJson(json["data"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "message": message.toJson(),
        "data": data.toJson(),
        "type": type,
      };
}

class Data {
  String qrCode;
  String qrSecrete;
  int qrStatus;
  String alert;

  Data({
    required this.qrCode,
    required this.qrSecrete,
    required this.qrStatus,
    required this.alert,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        qrCode: json["qr_code"],
        qrSecrete: json["qr_secrete"],
        qrStatus: json["qr_status"],
        alert: json["alert"],
      );

  Map<String, dynamic> toJson() => {
        "qr_code": qrCode,
        "qr_secrete": qrSecrete,
        "qr_status": qrStatus,
        "alert": alert,
      };
}

class Message {
  List<String> success;

  Message({
    required this.success,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        success: List<String>.from(json["success"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": List<dynamic>.from(success.map((x) => x)),
      };
}
