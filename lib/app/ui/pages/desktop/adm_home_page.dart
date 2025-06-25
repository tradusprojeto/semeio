import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semeio_app/app/controllers/adm_home_controller.dart';
import 'package:semeio_app/app/core/constants/color_constants.dart';
import 'package:semeio_app/app/core/utils.dart';
import 'package:semeio_app/app/model/Audio.dart';
import 'package:semeio_app/app/ui/components/footer.dart';
import 'package:semeio_app/app/ui/components/header.dart';

class AdmHomePage extends GetView<AdmHomeController> {
  const AdmHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: LayoutBuilder(builder: (context, constraints) {
        double baseFontSize = constraints.maxWidth * 0.009;
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;
        return Obx(() => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.04, vertical: height * 0.025),
                child: Row(
                  children: [
                    Expanded(
                      child: buildListAuditAudios(baseFontSize, height, width),
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    Expanded(
                        child: buildContentManager(baseFontSize, height, width))
                  ],
                ),
              ));
      }),
      floatingActionButton: Obx(() {
        if (controller.shouldShowDialog.value) {
          Future.delayed(Duration.zero,
              () => _showCustomDialog(context, Get.width * 0.009));
        }
        return const SizedBox(); // Retorna um widget vazio
      }),
      bottomNavigationBar: const Footer(),
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
                          "PARA REMOVER OU EXIBIR ÁUDIOS NA PLATAFORMA É NECESSÁRIO QUE SE IDENTIFIQUE",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: baseFontSize * 2),
                        ),
                        SizedBox(height: Get.height * 0.02),
                        Text(
                          "Seu nome:",
                          style: TextStyle(fontSize: baseFontSize),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: Get.height * 0.005),
                        Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                    width: Get.width * 0.2,
                                    alignment: Alignment.center,
                                    child: TextField(
                                      controller:
                                          controller.appraiserNameController,
                                      decoration: InputDecoration(
                                          enabledBorder:
                                              const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          checkboxStroke), // Cor da borda quando o campo está habilitado
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10))),
                                          isDense: true,
                                          fillColor: orange,
                                          filled: true,
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: baseFontSize),
                                          border: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: checkboxStroke),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          hintText: "Digite..."),
                                    )),
                                SizedBox(
                                  width: Get.width * 0.01,
                                ),
                                OutlinedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            const WidgetStatePropertyAll(
                                                loginBtnColor),
                                        padding: WidgetStatePropertyAll(
                                            EdgeInsets.symmetric(
                                                horizontal: Get.width * 0.02,
                                                vertical: Get.height * 0.015)),
                                        shape: WidgetStatePropertyAll(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8))),
                                        side: const WidgetStatePropertyAll(
                                            BorderSide.none)),
                                    onPressed: () async {
                                      await controller.setAppraiserName();
                                      Get.back();
                                    },
                                    child: Text(
                                      "Aplicar",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: baseFontSize),
                                    ))
                              ],
                            )
                          ],
                        )
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
                        fontFamily: GoogleFonts.kalam().fontFamily,
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
                      onTap: () => Get.back(),
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

  buildListAuditAudios(double baseFontSize, double height, double width) {
    return Obx(() => Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text("Curadoria de áudios: ",
                    style: TextStyle(
                      color: defaultCyan,
                      fontWeight: FontWeight.bold,
                      fontSize: baseFontSize * 2,
                    )),
                const SizedBox(
                  width: 10,
                ),
                Row(
                  children: [
                    Obx(() => Text(
                          "${controller.auditAudios.value} áudios a serem avaliados",
                          style: TextStyle(
                              color: defaultRed, fontSize: baseFontSize),
                          textAlign: TextAlign.center,
                        )),
                    const Icon(
                      size: 30,
                      Icons.timer,
                      fill: 1,
                      weight: 1,
                      color: defaultRed,
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
                child: Obx(() => controller.isLoadingPageOfAudios.value
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        itemCount: controller.actualPageItemsToAudit.length,
                        itemBuilder: (context, index) {
                          Audio item = controller.actualPageItemsToAudit[index];
                          return Container(
                              padding: const EdgeInsets.all(4),
                              height: height * 0.11,
                              decoration: BoxDecoration(
                                  color: defaultLightCyan,
                                  border: Border.all(color: checkboxStroke),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.35,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Submissão ${index + 1 + (controller.perPageAudit.value * controller.currentPageAudit.value)}",
                                          style: TextStyle(
                                              color: defaultCyan,
                                              fontWeight: FontWeight.bold,
                                              fontSize: baseFontSize),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "${item.child!.firstName}, ${item.city}, ${item.district}, enviado dia ${item.created_at!.day} de ${Utils.getMonthName(item.created_at!.month)}",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: defaultCyan,
                                              fontSize: baseFontSize),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    height: height * 0.07,
                                    child: TextButton(
                                        style: const ButtonStyle(
                                            backgroundColor:
                                                WidgetStatePropertyAll(
                                                    loginBtnColor),
                                            shape: WidgetStatePropertyAll(
                                                RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))))),
                                        onPressed: () async {
                                          await controller.validate(item);
                                          await controller
                                              .reloadItemsAlreadyAudited();
                                          await controller.reloadItemsAudited();
                                        },
                                        child: Text(
                                          "AVALIAR",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: baseFontSize,
                                              color: Colors.white),
                                        )),
                                  )
                                ],
                              ));
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: height * 0.025,
                          );
                        },
                      ))),
            buildPaginationAudit()
          ],
        ));
  }

  buildContentManager(double baseFontSize, double height, double width) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Gerenciamento de conteúdo:",
              style: TextStyle(
                  color: defaultCyan,
                  fontWeight: FontWeight.bold,
                  fontSize: baseFontSize * 2),
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
                                controller.verifyCheckboxes("cpf", newValue);
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
                                controller.verifyCheckboxes("city", newValue);
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
                                controller.verifyCheckboxes(
                                    "created_at", newValue);
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
                                controller.verifyCheckboxes(
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
                    child: TextField(
                      controller: controller.searchController,
                      decoration: InputDecoration(
                          suffixIcon: controller.isFiltered.value
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    controller.clearFilters();
                                  },
                                )
                              : null,
                          hintText: "Digite...",
                          border: const OutlineInputBorder(
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
                  width: Get.width * 0.1,
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
                                fontSize: baseFontSize,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.search,
                            size: 35,
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
              child: Obx(() => controller.isLoadingPageOfAuditedAudios.value
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        Audio actualItem = controller.actualPageItems[index];
                        return GestureDetector(
                          onTap: () async {
                            await controller.edit(actualItem);
                            await controller.reloadItemsAudited();
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
                                                  fontSize: baseFontSize),
                                            ),
                                            SizedBox(
                                              width: width * 0.3,
                                              child: Text(
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                "${actualItem.child!.firstName}, ${Utils.calcAge(actualItem.child!.birthDate)} anos, ${actualItem.city}, ${actualItem.district}, enviado dia ${actualItem.created_at!.day} de ${Utils.getMonthName(actualItem.created_at!.month)} de ${actualItem.created_at!.year}",
                                                style: TextStyle(
                                                    color: defaultCyan,
                                                    fontSize:
                                                        baseFontSize * 0.8),
                                              ),
                                            ),
                                            if (actualItem.validated_at != null)
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
                                                        "${actualItem.removed_by?.name} no dia ${Utils.formatDate(actualItem.deleted_at!)}",
                                                    style: TextStyle(
                                                        color: defaultCyan,
                                                        fontSize: baseFontSize *
                                                            0.8)),
                                              ])),
                                            if (actualItem.modified_at != null)
                                              RichText(
                                                  text: TextSpan(children: [
                                                TextSpan(
                                                    text: "Editado por: ",
                                                    style: TextStyle(
                                                        color: defaultCyan,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            baseFontSize)),
                                                TextSpan(
                                                    text:
                                                        "${actualItem.edited_by?.name} no dia ${Utils.formatDate(actualItem.modified_at!)}",
                                                    style: TextStyle(
                                                        color: defaultCyan,
                                                        fontSize: baseFontSize *
                                                            0.8)),
                                              ]))
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
                                            SizedBox(
                                              width: width * 0.045,
                                              height: width * 0.045,
                                              child: OutlinedButton(
                                                  onPressed: () async {
                                                    await controller
                                                        .edit(actualItem);
                                                    await controller
                                                        .reloadItemsAlreadyAudited();
                                                  },
                                                  style: const ButtonStyle(
                                                      padding:
                                                          WidgetStatePropertyAll(
                                                              EdgeInsets.zero),
                                                      backgroundColor:
                                                          WidgetStatePropertyAll(
                                                              defaultCyan),
                                                      shape: WidgetStatePropertyAll(
                                                          RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10))))),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Icon(
                                                        Icons.edit,
                                                        color: Colors.white,
                                                        size: 35,
                                                      ),
                                                      Text(
                                                        "EDITAR",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                baseFontSize *
                                                                    0.9),
                                                      )
                                                    ],
                                                  )),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            SizedBox(
                                              width: width * 0.045,
                                              height: width * 0.045,
                                              child: OutlinedButton(
                                                  onPressed:
                                                      actualItem.deleted_at ==
                                                              null
                                                          ? () async {
                                                              await controller
                                                                  .removeAudio(
                                                                      index);
                                                            }
                                                          : () async {
                                                              await controller
                                                                  .exposeAudio(
                                                                      index);
                                                            },
                                                  style: ButtonStyle(
                                                      padding:
                                                          const WidgetStatePropertyAll(
                                                              EdgeInsets.zero),
                                                      backgroundColor:
                                                          WidgetStatePropertyAll(
                                                              actualItem.deleted_at == null
                                                                  ? Colors.red
                                                                  : Colors
                                                                      .green),
                                                      shape: const WidgetStatePropertyAll(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.all(
                                                                      Radius.circular(
                                                                          10))))),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Icon(
                                                        Icons.edit,
                                                        color: Colors.white,
                                                        size: 35,
                                                      ),
                                                      Text(
                                                        actualItem.deleted_at ==
                                                                null
                                                            ? "REMOVER"
                                                            : "EXIBIR",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize:
                                                                baseFontSize *
                                                                    0.9),
                                                      )
                                                    ],
                                                  )),
                                            )
                                          ],
                                        )),
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
                    )),
            ),
            buildPaginationContentManager()
          ],
        ));
  }

  buildPaginationAudit() {
    return SizedBox(
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (controller.actualPageItemsToAudit.isNotEmpty)
            SizedBox(
              width: Get.width * 0.015,
              child: TextButton(
                style: const ButtonStyle(
                    padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 1))),
                onPressed: controller.currentPageAudit.value == 0
                    ? () {}
                    : () {
                        controller.goToPageAudit(
                            controller.currentPageAudit.value - 1);
                      },
                child: const Text("<"),
              ),
            ),
          for (int i = controller.paginationInitAudit.value;
              i < controller.paginationEndAudit.value;
              i++)
            SizedBox(
              width: Get.width * 0.015,
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: i == controller.currentPageAudit.value
                        ? const WidgetStatePropertyAll(Colors.yellow)
                        : null,
                    padding: const WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 2))),
                child: Text(
                  "${i + 1}",
                  style: i == controller.currentPageAudit.value
                      ? const TextStyle(fontWeight: FontWeight.bold)
                      : const TextStyle(),
                ),
                onPressed: () {
                  controller.goToPageAudit(i);
                },
              ),
            ),
          if (controller.pagesAudit.value > 5)
            SizedBox(
              width: Get.width * 0.015,
              child: TextButton(
                style: const ButtonStyle(
                    padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 1))),
                onPressed: controller.currentPageAudit.value + 1 ==
                        controller.pagesAudit.value
                    ? () {}
                    : () {
                        controller
                            .goToPageAudit(controller.pagesAudit.value - 1);
                      },
                child: const Text("..."),
              ),
            ),
          if (controller.actualPageItemsToAudit.isNotEmpty)
            SizedBox(
              width: Get.width * 0.015,
              child: TextButton(
                style: const ButtonStyle(
                    padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 1))),
                onPressed: controller.currentPageAudit.value ==
                        controller.pagesAudit.value - 1
                    ? () {}
                    : () {
                        controller.goToPageAudit(
                            controller.currentPageAudit.value + 1);
                      },
                child: const Text(">"),
              ),
            ),
        ],
      ),
    );
  }

  buildPaginationContentManager() {
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
