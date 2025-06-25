// import 'package:brasil_fields/brasil_fields.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:semeio_app/app/core/constants/color_constants.dart';
// import 'package:semeio_app/app/core/validators/form_validators.dart';
// import 'package:semeio_app/app/ui/components/form_field.dart';
// import 'package:semeio_app/app/controllers/send_audio_controller.dart';

// class SemeioFormMobile extends GetView {
//   const SemeioFormMobile({super.key});

//   @override
//   Widget build(BuildContext context) {
//     double totalWidth = Get.width;
//     return SingleChildScrollView(
//       child: Form(
//         key: controller.formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Envie o seu áudio e participe!",
//               style: TextStyle(
//                   color: formsCyan, fontWeight: FontWeight.bold, fontSize: 20),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             const Text(
//               "Preencha os seus dados corretamente:",
//               style: TextStyle(color: formsCyan, fontSize: 12),
//             ),
//             const SizedBox(
//               height: 5,
//             ),
//             Field(
//               controller: controller.childName,
//               validator: validateName,
//               hintText: "Nome completo da criança",
//               width: totalWidth,
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Row(
//               children: [
//                 Field(
//                   controller: controller.childBirthDate,
//                   hintText: "Data de nascimento",
//                   validator: validateBirthDate,
//                   formatter: [
//                     FilteringTextInputFormatter.digitsOnly,
//                     DataInputFormatter(),
//                   ],
//                   width: totalWidth * 0.5,
//                 ),
//                 const Expanded(
//                   child: SizedBox(),
//                 ),
//                 Field(
//                     controller: controller.childRg,
//                     validator: validateRg,
//                     formatter: [FilteringTextInputFormatter.digitsOnly],
//                     hintText: "RG",
//                     width: totalWidth * 0.38)
//               ],
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Row(
//               children: [
//                 Field(
//                   controller: controller.childCpf,
//                   validator: validateCpf,
//                   hintText: "CPF",
//                   width: totalWidth * 0.41,
//                   formatter: [
//                     FilteringTextInputFormatter.digitsOnly,
//                     CpfInputFormatter()
//                   ],
//                 ),
//                 const Expanded(
//                   child: SizedBox(),
//                 ),
//                 Field(
//                   controller: controller.childPhoneNumber,
//                   validator: validatePhoneNumber,
//                   hintText: "Telefone/WhatsApp",
//                   width: totalWidth * 0.47,
//                   formatter: [
//                     FilteringTextInputFormatter.digitsOnly,
//                     TelefoneInputFormatter()
//                   ],
//                 )
//               ],
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Field(
//               controller: controller.childEmail,
//               hintText: "E-mail",
//               width: totalWidth * 0.9,
//               validator: validateEmail,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             const Text(
//               "Preencha os seus dados residenciais:",
//               style: TextStyle(color: formsCyan, fontSize: 12),
//             ),
//             const SizedBox(
//               height: 5,
//             ),
//             Row(
//               children: [
//                 Field(
//                   focusNode: controller.cepFocusNode,
//                   controller: controller.cep,
//                   hintText: "CEP",
//                   width: totalWidth * 0.28,
//                   validator: validateCep,
//                   formatter: [
//                     FilteringTextInputFormatter.digitsOnly,
//                     CepInputFormatter()
//                   ],
//                 ),
//                 const Expanded(
//                   child: SizedBox(),
//                 ),
//                 Field(
//                     readOnly: true,
//                     controller: controller.city,
//                     validator: validateCity,
//                     hintText: "Cidade",
//                     width: totalWidth * 0.28),
//                 const Expanded(
//                   child: SizedBox(),
//                 ),
//                 Field(
//                     readOnly: true,
//                     controller: controller.district,
//                     validator: validateBairro,
//                     hintText: "Bairro",
//                     width: totalWidth * 0.28),
//               ],
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             const Text(
//               "Preencha os dados do responsável:",
//               style: TextStyle(color: formsCyan, fontSize: 12),
//             ),
//             const SizedBox(
//               height: 5,
//             ),
//             Field(
//                 controller: controller.responsibleName,
//                 hintText: "Nome completo",
//                 validator: validateName,
//                 width: totalWidth),
//             const SizedBox(
//               height: 15,
//             ),
//             Row(
//               children: [
//                 Field(
//                   controller: controller.responsibleBirthDate,
//                   hintText: "Data de nascimento",
//                   width: totalWidth * 0.5,
//                   validator: validateBirthDate,
//                   formatter: [
//                     FilteringTextInputFormatter.digitsOnly,
//                     DataInputFormatter()
//                   ],
//                 ),
//                 const Expanded(child: SizedBox()),
//                 Field(
//                     controller: controller.responsibleRg,
//                     validator: validateRg,
//                     formatter: [FilteringTextInputFormatter.digitsOnly],
//                     hintText: "RG",
//                     width: totalWidth * 0.38),
//               ],
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Row(
//               children: [
//                 Field(
//                   controller: controller.responsibleCpf,
//                   validator: validateCpf,
//                   hintText: "CPF",
//                   width: totalWidth * 0.41,
//                   formatter: [
//                     FilteringTextInputFormatter.digitsOnly,
//                     CpfInputFormatter()
//                   ],
//                 ),
//                 const Expanded(
//                   child: SizedBox(),
//                 ),
//                 Field(
//                   controller: controller.responsiblePhoneNumber,
//                   validator: validatePhoneNumber,
//                   hintText: "Telefone/WhatsApp",
//                   width: totalWidth * 0.47,
//                   formatter: [
//                     FilteringTextInputFormatter.digitsOnly,
//                     TelefoneInputFormatter()
//                   ],
//                 )
//               ],
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Field(
//               controller: controller.responsibleEmail,
//               hintText: "E-mail",
//               width: totalWidth * 0.9,
//               validator: validateEmail,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             const Text(
//               "Faça o Upload do aúdio:",
//               style: TextStyle(color: formsCyan, fontSize: 12),
//             ),
//             const SizedBox(
//               height: 5,
//             ),
//             Obx(() => TextButton(
//                 onPressed: controller.useFilePicker,
//                 style: ButtonStyle(
//                     maximumSize: WidgetStatePropertyAll(
//                         Size.fromWidth(totalWidth * 0.5)),
//                     backgroundColor: const WidgetStatePropertyAll(Colors.white),
//                     foregroundColor: WidgetStatePropertyAll(
//                         (controller.formSubmited.value &&
//                                 controller.selectedFileName.value.isEmpty)
//                             ? Colors.red
//                             : hintTextColor),
//                     shape: WidgetStatePropertyAll(RoundedRectangleBorder(
//                       side: (controller.formSubmited.value &&
//                               controller.selectedFileName.value.isEmpty)
//                           ? const BorderSide(color: Colors.red)
//                           : BorderSide.none,
//                       borderRadius:
//                           BorderRadius.circular(8), // Borda arredondada
//                     ))),
//                 child: Row(
//                   children: [
//                     const Icon(Icons.upload),
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     if (controller.selectedFileName.value == "")
//                       const Text("Selecionar arquivo")
//                     else
//                       Expanded(
//                         child: Text(
//                           controller.selectedFileName.value,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                   ],
//                 ))),
//             Row(
//               children: [
//                 Transform.scale(
//                   scale: 0.8,
//                   child: Obx(() => Checkbox(
//                       side: BorderSide(
//                           color: (controller.formSubmited.value &&
//                                   !controller.checkBoxTruly.value)
//                               ? Colors.red
//                               : checkboxStroke,
//                           width: 1),
//                       visualDensity: VisualDensity.compact,
//                       value: controller.checkBoxTruly.value,
//                       onChanged: (bool? newValue) {
//                         controller.checkBoxTruly.value = newValue!;
//                       },
//                       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap)),
//                 ),
//                 Obx(() => Expanded(
//                       child: Text(
//                         "Declaro que todas as informações prestadas no ato do envio são verídicas.",
//                         style: TextStyle(
//                             color: (controller.formSubmited.value &&
//                                     !controller.checkBoxTruly.value)
//                                 ? Colors.red
//                                 : formsCyan,
//                             fontSize: 8),
//                       ),
//                     ))
//               ],
//             ),
//             Row(
//               children: [
//                 Transform.scale(
//                   scale: 0.8,
//                   child: Obx(() => Checkbox(
//                       side: BorderSide(
//                           color: (controller.formSubmited.value &&
//                                   !controller.checkBoxTruly.value)
//                               ? Colors.red
//                               : checkboxStroke,
//                           width: 1),
//                       visualDensity: VisualDensity.compact,
//                       value: controller.checkBoxShare.value,
//                       onChanged: (bool? newValue) {
//                         controller.checkBoxShare.value = newValue!;
//                       },
//                       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap)),
//                 ),
//                 Obx(() => Expanded(
//                       child: Text(
//                         "Declaro concordar com o compartilhamento do material enviado.",
//                         style: TextStyle(
//                             color: (controller.formSubmited.value &&
//                                     !controller.checkBoxTruly.value)
//                                 ? Colors.red
//                                 : formsCyan,
//                             fontSize: 8),
//                       ),
//                     ))
//               ],
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             TextButton(
//                 style: TextButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(horizontal: 0),
//                     visualDensity: VisualDensity.compact,
//                     tapTargetSize: MaterialTapTargetSize.shrinkWrap),
//                 onPressed: controller.submitForms,
//                 child: Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage('assets/images/bgSendBtn.png'),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   child: const Text(
//                     "Enviar",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 )),
//             const SizedBox(
//               height: 15,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
