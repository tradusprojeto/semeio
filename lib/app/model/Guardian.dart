// ignore: file_names
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Guardian extends Equatable {
  String? id;
  String fullName;
  String birthDate;
  String rg;
  String cpf;
  String email;

  Guardian(
      {this.id,
      required this.fullName,
      required this.birthDate,
      required this.rg,
      required this.cpf,
      required this.email});

  factory Guardian.fromJson(Map<String, dynamic> json) {
    return Guardian(
      id: json["id"],
      fullName: json["full_name"],
      birthDate: json["birth_date"],
      rg: json["rg"],
      cpf: json["cpf"],
      email: json["email"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "full_name": fullName,
      "birth_date": birthDate,
      "rg": rg,
      "cpf": cpf,
      "email": email,
    };
  }

  @override
  List<Object?> get props => [id, fullName, birthDate, rg, cpf, email];
}
