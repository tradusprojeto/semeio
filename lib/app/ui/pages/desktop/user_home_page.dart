import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:semeio_app/app/controllers/user_home_controller.dart';
import 'package:semeio_app/app/core/constants/color_constants.dart';
import 'package:semeio_app/app/core/utils.dart';
import 'package:semeio_app/app/model/Audio.dart';
import 'package:semeio_app/app/routes/app_pages.dart';
import 'package:semeio_app/app/ui/components/card_button.dart';
import 'package:semeio_app/app/ui/components/footer.dart';
import 'package:semeio_app/app/ui/components/header.dart';

class UserHomePage extends GetView<UserHomeController> {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: LayoutBuilder(builder: (context, constraints) {
        double baseFontSize = constraints.maxWidth * 0.009;
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.04, vertical: height * 0.01),
          child: Row(
            children: [
              Expanded(
                  flex: 2,
                  child: _buildContentManager(baseFontSize, height, width)),
              SizedBox(
                width: width * 0.03,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildNewAudioButton(baseFontSize, height, width),
                      const SizedBox(
                        height: 16,
                      ),
                      Obx(
                        () => Column(
                          children: [
                            if (controller.isShowAudio.value)
                              SizedBox(
                                width: width * 0.30,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Ouça o áudio",
                                      style: TextStyle(
                                          color: defaultCyan,
                                          fontSize: baseFontSize * 1.4),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () async {
                                              controller.isPlaying.value
                                                  ? await controller
                                                      .pauseAudio()
                                                  : await controller
                                                      .playAudio();
                                            },
                                            icon: Icon(
                                              controller.isAudioLoading.value
                                                  ? Icons.hourglass_empty
                                                  : controller.isPlaying.value
                                                      ? Icons.pause
                                                      : Icons.volume_up,
                                              size: width * 0.025,
                                            )),
                                        Image(
                                          image: const AssetImage(
                                              "assets/images/audioWave.png"),
                                          width: width * 0.15,
                                          height: height * 0.15,
                                          fit: BoxFit.cover,
                                        )
                                      ],
                                    ),
                                    Text(
                                      "Veja a transcrição do áudio:",
                                      style: TextStyle(
                                        color: defaultCyan,
                                        fontSize: baseFontSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        controller
                                            .audioTranscriptionController.text,
                                        style: TextStyle(
                                          fontSize: baseFontSize * 0.9,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
      floatingActionButton: Obx(() {
        if (controller.isOpenDialogConfirmsRemoval.value) {
          Future.delayed(Duration.zero,
              () => _showCustomDialog(context, Get.width * 0.009));
        }
        return const SizedBox(); // Retorna um widget vazio
      }),
      bottomNavigationBar: const Footer(),
    );
  }

  Widget _buildNewAudioButton(
      double baseFontSize, double height, double width) {
    return TextButton(
      onPressed: () async {
        controller.goToCreateAudio();
        await controller.reloadItems();
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        visualDensity: VisualDensity.compact,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.030,
          vertical: height * 0.01,
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bgSendBtnLg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Text(
          "Novo áudio",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: baseFontSize * 1.6,
          ),
        ),
      ),
    );
  }

  _showCustomDialog(BuildContext context, double baseFontSize) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog.fullscreen(
          backgroundColor: Colors.transparent,
          child: SizedBox.expand(
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                  ),
                  width: Get.width * 0.4,
                  height: Get.height * 0.4,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.035,
                      vertical: Get.height * 0.05,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "TEM CERTEZA QUE DESEJA EXCLUIR O ÁUDIO?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: baseFontSize * 2),
                        ),
                        SizedBox(height: Get.height * 0.009),
                        Center(
                          child: OutlinedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    const WidgetStatePropertyAll(Colors.red),
                                padding: WidgetStatePropertyAll(
                                    EdgeInsets.symmetric(
                                        horizontal: Get.width * 0.015,
                                        vertical: Get.height * 0.03)),
                                shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                                side: const WidgetStatePropertyAll(
                                    BorderSide.none)),
                            onPressed: () async {
                              await controller.removeAudio();
                              Get.back();
                            },
                            child: Text(
                              "Remover",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: baseFontSize * 1.2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: Get.height * 0.2,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    width: Get.width * 0.35,
                    height: Get.height * 0.15,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/modal_bg_img.png"),
                      ),
                    ),
                    child: Text(
                      "Atenção!",
                      style: TextStyle(
                        fontSize: baseFontSize * 5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: Get.height * 0.13,
                  right: Get.width * 0.29,
                  child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => {
                        controller.toggleShowDialogRemove(null),
                        Get.back(),
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: closeBtn,
                        ),
                        padding: EdgeInsets.all(Get.width * 0.005),
                        child: Icon(
                          Icons.close,
                          size: Get.width * 0.025,
                          color: closeIconColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildContentManager(
      double baseFontSize, double height, double width) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "GERENCIAR MEUS ÁUDIOS",
              style: TextStyle(
                  color: defaultCyan,
                  fontWeight: FontWeight.bold,
                  fontSize: baseFontSize * 1.8),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: height * 0.005,
            ),
            Row(
              children: [
                Text(
                  "Selecione um filtro:",
                  style: TextStyle(
                      fontSize: baseFontSize,
                      color: defaultCyan,
                      fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              value: controller.checkboxCpf.value,
                              onChanged: (bool? newValue) {
                                controller.verifyCheckBoxes("cpf", newValue);
                              }),
                          Text(
                            "Cpf",
                            style: TextStyle(
                                fontSize: baseFontSize, color: defaultCyan),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: controller.checkboxCity.value,
                              onChanged: (bool? newValue) {
                                controller.verifyCheckBoxes("city", newValue);
                              }),
                          Text(
                            "Cidade",
                            style: TextStyle(
                                fontSize: baseFontSize, color: defaultCyan),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: controller.checkboxSubmissionDate.value,
                              onChanged: (bool? newValue) {
                                controller.verifyCheckBoxes("", newValue);
                              }),
                          Text(
                            "Data de envio",
                            style: TextStyle(
                                fontSize: baseFontSize, color: defaultCyan),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: controller.checkboxAppraiser.value,
                              onChanged: (bool? newValue) {
                                controller.verifyCheckBoxes(
                                    "appraiser", newValue);
                              }),
                          Text(
                            "Avaliador",
                            style: TextStyle(
                                fontSize: baseFontSize, color: defaultCyan),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    width: Get.width * 0.3,
                    height: height * 0.08,
                    child: TextField(
                      controller: controller.searchController,
                      decoration: const InputDecoration(
                          hintText: "Digite...",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: checkboxStroke),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: Get.width * 0.08,
                  height: height * 0.08,
                  // padding: const EdgeInsets.symmetric(vertical: 8),
                  // decoration: const BoxDecoration(color: formsCyan),
                  child: TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              const WidgetStatePropertyAll(formsCyan),
                          padding: WidgetStatePropertyAll(
                              EdgeInsets.symmetric(vertical: width * 0.008)),
                          shape: const WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))))),
                      onPressed: () {
                        controller.filterAudios();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Buscar",
                            style: TextStyle(
                                fontSize: baseFontSize + 4,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.search,
                            size: 20,
                            fill: 1,
                            color: Colors.white,
                          )
                        ],
                      )),
                )
              ],
            ),
            Text(
              "Resultados:",
              style: TextStyle(
                  color: defaultCyan,
                  fontWeight: FontWeight.bold,
                  fontSize: baseFontSize),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Obx(
                () => controller.isLoadingPage.value
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        itemBuilder: (context, index) {
                          Audio actualItem = controller.actualPageItems[index];
                          return GestureDetector(
                            onTap: () async {
                              await controller.edit(actualItem);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: defaultLightCyan,
                                  border: Border.all(color: checkboxStroke),
                                  borderRadius: BorderRadius.circular(10)),
                              width: width * 0.3,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 16),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: width * 0.30,
                                      child: Obx(() => Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Audio ${index + 1 + (controller.currentPage.value * controller.perPage.value)}",
                                                style: TextStyle(
                                                    color: defaultCyan,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        baseFontSize * 1.4),
                                              ),
                                              SizedBox(
                                                width: width * 0.3,
                                                child: Text(
                                                  // maxLines: 1,
                                                  // overflow: TextOverflow.ellipsis,
                                                  "${actualItem.child!.firstName}, ${Utils.calcAge(actualItem.child!.birthDate)} anos, ${actualItem.city}, ${actualItem.district}, \nenviado dia ${actualItem.created_at!.day} de ${Utils.getMonthName(actualItem.created_at!.month)} de ${actualItem.created_at!.year}",
                                                  style: TextStyle(
                                                      color: defaultCyan,
                                                      fontSize:
                                                          baseFontSize * 1.2),
                                                ),
                                              ),
                                              if (actualItem.validated_at ==
                                                  null)
                                                RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                        text:
                                                            "Aguardando avaliação...",
                                                        style: TextStyle(
                                                            color: defaultCyan,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                baseFontSize *
                                                                    1.2)),
                                                  ]),
                                                ),
                                              if (actualItem.validated_at !=
                                                  null)
                                                const SizedBox(height: 5),
                                              if (actualItem.validated_at !=
                                                  null)
                                                RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                        text: "Validado por: ",
                                                        style: TextStyle(
                                                            color: defaultCyan,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                baseFontSize)),
                                                    TextSpan(
                                                        text:
                                                            "${actualItem.appraiser!.name} no dia ${Utils.formatDate(actualItem.validated_at!)}",
                                                        style: TextStyle(
                                                            color: defaultCyan,
                                                            fontSize:
                                                                baseFontSize *
                                                                    0.8))
                                                  ]),
                                                ),
                                              if (actualItem.deleted_at != null)
                                                const SizedBox(height: 5),
                                              if (actualItem.deleted_at != null)
                                                RichText(
                                                    text: TextSpan(children: [
                                                  TextSpan(
                                                      text: "Removido por: ",
                                                      style: TextStyle(
                                                          color: defaultCyan,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize:
                                                              baseFontSize)),
                                                  TextSpan(
                                                      text:
                                                          "${actualItem.appraiser!.name} no dia ${Utils.formatDate(actualItem.deleted_at!)}",
                                                      style: TextStyle(
                                                          color: defaultCyan,
                                                          fontSize:
                                                              baseFontSize *
                                                                  0.8)),
                                                ])),
                                              if (actualItem.modified_at !=
                                                  null)
                                                const SizedBox(height: 5),
                                              if (actualItem.modified_at !=
                                                  null)
                                                RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                          text: "Editado por: ",
                                                          style: TextStyle(
                                                              color:
                                                                  defaultCyan,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize:
                                                                  baseFontSize)),
                                                      TextSpan(
                                                          text:
                                                              "${actualItem.edited_by?.name} no dia ${Utils.formatDate(actualItem.modified_at!)}",
                                                          style: TextStyle(
                                                              color:
                                                                  defaultCyan,
                                                              fontSize:
                                                                  baseFontSize *
                                                                      0.8)),
                                                    ],
                                                  ),
                                                ),
                                            ],
                                          )),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        width: width * 0.01,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Obx(
                                              () => CardButton(
                                                width: width < 940 ? 40 : 60,
                                                height: 60,
                                                backgroundColor: Colors.green,
                                                iconSize: width < 940 ? 20 : 30,
                                                icon: Icons.audio_file,
                                                label: controller.isShowAudio
                                                            .value &&
                                                        controller.audioId
                                                                .value ==
                                                            actualItem.id
                                                    ? "OCULTAR"
                                                    : "EXIBIR",
                                                onPressed: () =>
                                                    controller.toggleShowAudio(
                                                        actualItem.urlToAudio!,
                                                        actualItem
                                                            .transcription!,
                                                        actualItem.id!),
                                                fontSize: width < 940 ? 8 : 10,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            if (actualItem.validated_at == null)
                                              SizedBox(
                                                width: width < 940 ? 40 : 60,
                                                height: 60,
                                                child: OutlinedButton(
                                                  onPressed: () async {
                                                    await controller
                                                        .edit(actualItem);
                                                    await controller
                                                        .reloadItems();
                                                  },
                                                  style: ButtonStyle(
                                                    iconSize:
                                                        WidgetStatePropertyAll(
                                                            width < 940
                                                                ? 20
                                                                : 30),
                                                    padding:
                                                        const WidgetStatePropertyAll(
                                                            EdgeInsets.zero),
                                                    backgroundColor:
                                                        const WidgetStatePropertyAll(
                                                            defaultCyan),
                                                    shape:
                                                        const WidgetStatePropertyAll(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(10),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.edit,
                                                        color: Colors.white,
                                                        size: width < 940
                                                            ? 20
                                                            : 30,
                                                      ),
                                                      Text(
                                                        "EDITAR",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: width < 940
                                                              ? 8
                                                              : 10,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            CardButton(
                                              width: width < 940 ? 40 : 60,
                                              height: 60,
                                              backgroundColor: Colors.red,
                                              iconSize: width < 940 ? 20 : 30,
                                              icon: Icons.delete,
                                              label: "REMOVER",
                                              onPressed: () => controller
                                                  .toggleShowDialogRemove(
                                                      index),
                                              fontSize: width < 940 ? 8 : 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: controller.actualPageItems.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 20,
                          );
                        },
                      ),
              ),
            ),
            _buildPaginationContentManager()
          ],
        ));
  }

  Widget _buildPaginationContentManager() {
    return SizedBox(
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (controller.actualPageItems.isNotEmpty)
            SizedBox(
              width: Get.width * 0.015,
              child: TextButton(
                style: const ButtonStyle(
                    padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 1))),
                onPressed: controller.currentPage.value == 0
                    ? () {}
                    : () {
                        controller.goToPage(controller.currentPage.value - 1);
                      },
                child: const Text("<"),
              ),
            ),
          for (int i = controller.paginationInit.value;
              i < controller.paginationEnd.value;
              i++)
            SizedBox(
              width: Get.width * 0.015,
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: controller.currentPage.value == i
                        ? const WidgetStatePropertyAll(Colors.yellow)
                        : null,
                    padding: const WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 2))),
                child: Text("${i + 1}",
                    style: controller.currentPage.value == i
                        ? const TextStyle(fontWeight: FontWeight.bold)
                        : const TextStyle()),
                onPressed: () {
                  controller.goToPage(i);
                },
              ),
            ),
          if (controller.pages.value > 5)
            SizedBox(
              width: Get.width * 0.015,
              child: TextButton(
                style: const ButtonStyle(
                    padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 1))),
                onPressed:
                    controller.currentPage.value + 1 == controller.pages.value
                        ? () {}
                        : () {
                            controller.goToPage(controller.pages.value - 1);
                          },
                child: const Text("..."),
              ),
            ),
          if (controller.actualPageItems.isNotEmpty)
            SizedBox(
              width: Get.width * 0.015,
              child: TextButton(
                style: const ButtonStyle(
                    padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 1))),
                onPressed: controller.currentPage.value ==
                        controller.pages.value - 1
                    ? () {}
                    : () {
                        controller.goToPage(controller.currentPage.value + 1);
                      },
                child: const Text(">"),
              ),
            ),
        ],
      ),
    );
  }
}
