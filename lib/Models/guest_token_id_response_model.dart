// To parse this JSON data, do
//
//     final guestTokenIdResponseModel = guestTokenIdResponseModelFromJson(jsonString);

//https://api.themoviedb.org/3/authentication/guest_session/new?api_key=89625f75e903e0e64ec55732960b6610

import 'dart:convert';

GuestTokenIdResponseModel guestTokenIdResponseModelFromJson(String str) =>
    GuestTokenIdResponseModel.fromJson(json.decode(str));

String guestTokenIdResponseModelToJson(GuestTokenIdResponseModel data) =>
    json.encode(data.toJson());

class GuestTokenIdResponseModel {
  GuestTokenIdResponseModel({
    this.success,
    this.guestSessionId,
    this.expiresAt,
  });

  bool? success;
  String? guestSessionId;
  String? expiresAt;

  factory GuestTokenIdResponseModel.fromJson(Map<String, dynamic> json) =>
      GuestTokenIdResponseModel(
        success: json["success"],
        guestSessionId: json["guest_session_id"],
        expiresAt: json["expires_at"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "guest_session_id": guestSessionId,
        "expires_at": expiresAt,
      };
}
