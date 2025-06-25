import 'package:equatable/equatable.dart';
import 'package:semeio_app/app/model/Child.dart';
import 'package:semeio_app/app/model/Guardian.dart';
import 'package:semeio_app/app/model/Profile.dart';

class Audio extends Equatable {
  final String? id;
  final String? cep;
  final String? state;
  final String? city;
  final String? district;
  final Child? child;
  final Guardian? guardian;
  final String? urlToAudio;
  final double? latitude;
  final double? longitude;
  final String? transcription;
  final String? created_by;
  final DateTime? created_at;
  final DateTime? validated_at;
  final DateTime? deleted_at;
  final DateTime? modified_at;
  final Profile? edited_by;
  final Profile? removed_by;
  final Profile? appraiser;
  const Audio(
      {this.id,
      required this.cep,
      required this.child,
      required this.guardian,
      required this.urlToAudio,
      required this.latitude,
      required this.longitude,
      required this.city,
      required this.district,
      this.removed_by,
      this.edited_by,
      this.state,
      this.created_by,
      this.appraiser,
      this.transcription,
      this.created_at,
      this.validated_at,
      this.deleted_at,
      this.modified_at});

  const Audio.empty(
      this.id,
      this.cep,
      this.state,
      this.city,
      this.district,
      this.child,
      this.guardian,
      this.urlToAudio,
      this.latitude,
      this.longitude,
      this.created_by,
      this.transcription,
      this.created_at,
      this.validated_at,
      this.deleted_at,
      this.modified_at,
      this.appraiser,
      this.edited_by,
      this.removed_by);
  factory Audio.fromJson(Map<String, dynamic> json) {
    return Audio(
        id: json["id"],
        appraiser: json["appraiser"] == null
            ? null
            : Profile.fromJson(json["appraiser"]),
        edited_by: json["edited_by"] == null
            ? null
            : Profile.fromJson(json["edited_by"]),
        removed_by: json["removed_by"] == null
            ? null
            : Profile.fromJson(json["removed_by"]),
        cep: json["cep"],
        state: json["state"],
        city: json["city"],
        district: json["district"],
        child: Child.fromJson(json["child"]),
        guardian: Guardian.fromJson(json["guardian"]),
        urlToAudio: json["url_to_audio"],
        transcription: json["audio_transcription"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        created_by: json["created_by"],
        validated_at: json["validated_at"] == null
            ? null
            : DateTime.parse(json["validated_at"]),
        deleted_at: json["deleted_at"] == null
            ? null
            : DateTime.parse(json["deleted_at"]),
        modified_at: json["modified_at"] == null
            ? null
            : DateTime.parse(json["modified_at"]),
        created_at: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]));
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "cep": cep,
      "state": state,
      "city": city,
      "district": district,
      "child_id": child!.id,
      "guardian_id": guardian!.id,
      "url_to_audio": urlToAudio,
      "longitude": longitude,
      "created_by": created_by,
      "latitude": latitude,
      "appraiser_id": appraiser?.id,
      "validated_at": validated_at?.toString(),
      "created_at": created_at?.toString(),
      "modified_at": modified_at?.toString(),
      "deleted_at": deleted_at?.toString(),
      "edited_by": edited_by?.id,
      "removed_by": removed_by?.id,
      "audio_transcription": transcription
    };
  }

  @override
  List<Object?> get props => [
        id,
        cep,
        state,
        city,
        district,
        child,
        guardian,
        urlToAudio,
        longitude,
        latitude,
        created_by,
        validated_at,
        created_at,
        modified_at,
        deleted_at,
        transcription,
        removed_by,
        edited_by,
        appraiser
      ];
}
