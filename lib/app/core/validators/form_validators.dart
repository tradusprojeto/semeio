import 'package:get/get.dart';
import 'package:intl/intl.dart';

String? validateEmail(String? fieldValue) {
  if (fieldValue == null || fieldValue.isEmpty) {
    return "E-mail é obrigatório";
  }

  if (!fieldValue.isEmail) return "E-mail inválido";

  return null;
}

String? validateCpf(String? fieldValue) {
  if (fieldValue == null || fieldValue.isEmpty) return "Cpf é obrigatório";
  if (!fieldValue.isCpf) return "Cpf inválido";
  return null;
}

String? validateBirthDate(String? fieldValue) {
  if (fieldValue == null || fieldValue.isEmpty) {
    return "Data de nascimento é obrigatória";
  }

  try {
    DateFormat("dd/MM/yyyy").parseStrict(fieldValue);
    return null;
  } catch (e) {
    return "Data de nascimento inválida";
  }
}

String? validatePhoneNumber(String? fieldValue) {
  if (fieldValue == null || fieldValue.isEmpty) {
    return "Telefone é obrigatório";
  }

  if (!fieldValue.isPhoneNumber) return "Telefone fornecido é inválido";

  return null;
}

String? validateCep(String? fieldValue) {
  if (fieldValue == null || fieldValue.isEmpty) {
    return "Cep é obrigatório";
  }

  if (fieldValue.length != 10) return "Cep inválido";

  return null;
}

String? validateRg(String? fieldValue) {
  if (fieldValue == null || fieldValue.isEmpty) {
    return "RG é obrigatório";
  }

  if (!fieldValue.isNumericOnly) return "RG é somente números";
  return null;
}

String? validateCity(String? fieldValue) {
  if (fieldValue == null || fieldValue.isEmpty) {
    return "Cidade é obrigatório";
  }
  return null;
}

String? validateBairro(String? fieldValue) {
  if (fieldValue == null || fieldValue.isEmpty) {
    return "Bairro é obrigatório";
  }
  return null;
}

String? validateName(String? fieldValue) {
  if (fieldValue == null || fieldValue.isEmpty) {
    return "Nome é obrigatório";
  }
  return null;
}

String? validatePassword(String? fieldValue) {
  if (fieldValue == null || fieldValue.isEmpty) {
    return "Senha é obrigatória";
  }
  if (fieldValue.length < 5) {
    return "Senha deve ter no mínimo 5 caracteres";
  }
  return null;
}

String? validateState(String? fieldValue) {
  if (fieldValue == null || fieldValue.isEmpty) {
    return "Estado é obrigatório";
  }
  return null;
}

String? validateSex(String? fieldValue) {
  if (fieldValue == null || fieldValue.isEmpty) {
    return "Sexo é obrigatório";
  }
  return null;
}
