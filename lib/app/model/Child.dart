import 'package:equatable/equatable.dart';

class Child extends Equatable {
  final String? id;
  final String firstName;
  final String surname;
  final String birthDate;
  final String rg;
  final String cpf;
  final String email;
  final String sex;

  const Child(
      {this.id,
      required this.firstName,
      required this.surname,
      required this.birthDate,
      required this.rg,
      required this.cpf,
      required this.email,
      required this.sex});

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      id: json["id"],
      firstName: json["first_name"],
      birthDate: json["birth_date"],
      surname: json["surname"],
      rg: json["rg"],
      cpf: json["cpf"],
      email: json["email"],
      sex: json["sex"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "first_name": firstName,
      "surname": surname,
      "birth_date": birthDate,
      "rg": rg,
      "cpf": cpf,
      "email": email,
      "sex": sex,
    };
  }

  @override
  List<Object?> get props =>
      [id, firstName, surname, birthDate, rg, cpf, email, sex];
}
