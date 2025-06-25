import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final String? id;
  final String name;

  const Profile({this.id, required this.name});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(id: json["id"], name: json["name"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name};
  }

  @override
  List<Object?> get props => [id, name];
}
