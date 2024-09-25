import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_delta_from_html/flutter_quill_delta_from_html.dart';
import 'package:gap/gap.dart';
import 'package:quill_json_to_html/json_to_html.dart';
import 'package:school_of_future/core/translations/local_keys.dart';
import 'package:school_of_future/core/utils/asset_image.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/enums.dart';
import 'package:school_of_future/core/widgets/app_bar.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/button.dart';
import 'package:school_of_future/core/widgets/dotted_button.dart';
import 'package:school_of_future/core/widgets/dropdown_field.dart';
import 'package:school_of_future/core/widgets/show_file_name.dart';
import 'package:school_of_future/core/widgets/text.dart';
import 'package:school_of_future/core/widgets/text_field.dart';
import 'package:school_of_future/features/presentation/resources/teacher_resources_create/bloc/resources_create_bloc.dart';

class ResourcesCreateScreen extends StatelessWidget {
  const ResourcesCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ResourcesCreateBloc>();
    final titleFocusnode = FocusNode();
    final videoFocusnode = FocusNode();

    final titleController = TextEditingController();
    final videoController = TextEditingController();

    QuillController qcontroller = QuillController.basic();

    return BlocBuilder<ResourcesCreateBloc, ResourcesCreateState>(
      builder: (context, state) {
        if (state.isFirstTime) {
          if (state.resourceDtls.data != null && state.chapterList.length > 1) {
            final data = state.resourceDtls.data!;

            var delta = HtmlToDelta().convert(data.content!);
            qcontroller.document = Document.fromDelta(delta);

            //here data.resourceType == 1 is means video

            bloc.add(
              AddData(
                  title: data.title!,
                  videoLink:
                      data.resourceType == 1 ? data.videos![0].embedUrl! : '',
                  selectedVersionId: data.subject!.versionId!,
                  selectedClassId: data.subject!.classId!,
                  selectedSubjectId: data.subject!.id!,
                  selectedChapterId: data.chapter!.id ?? -1,
                  selectedResourceType:
                      data.resourceType == 1 ? "Video" : "Article"),
            );
          } else if (state.resourceDtls.data == null &&
              state.resourceId != -1) {
            return Body(
              isFullScreen: true,
              appBar: FutureAppBar(
                actions: const [SizedBox()],
                title: LocaleKeys.createResource.tr(),
                isLoading: state.loading,
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }

        titleController.text = state.title;
        videoController.text = state.videoLink;

        return Body(
          isFullScreen: true,
          appBar: FutureAppBar(
            actions: const [SizedBox()],
            title: LocaleKeys.createResource.tr(),
            isLoading: state.loading,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
            color: bInnerBg,
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownFieldB(
                      dropdownHeight: 50,
                      label: LocaleKeys.version.tr(),
                      labelColor: bBlack,
                      dropDownValue: state.selectedVersionId,
                      selected: (dynamic type) {
                        bloc.add(SelectVersionId(id: type));
                      },
                      items: state.versionList,
                    ),
                    if (state.forms == Forms.invalid &&
                        state.selectedVersionId == -1)
                      TextB(
                          text: LocaleKeys.selectVersion.tr(), fontColor: bRed),
                    const Gap(10),
                    DropdownFieldB(
                      dropdownHeight: 50,
                      setState: state.setClass,
                      label: LocaleKeys.classStr.tr(),
                      labelColor: bBlack,
                      dropDownValue: state.selectedClassId,
                      selected: (dynamic type) {
                        bloc.add(SelectClassId(id: type));
                      },
                      items: state.classList,
                    ),
                    if (state.forms == Forms.invalid &&
                        state.selectedClassId == -1)
                      TextB(text: LocaleKeys.selectClass.tr(), fontColor: bRed),
                    const Gap(10),
                    DropdownFieldB(
                      dropdownHeight: 50,
                      label: LocaleKeys.subject.tr(),
                      labelColor: bBlack,
                      setState: state.setSubject,
                      dropDownValue: state.selectedSubjectId,
                      selected: (dynamic type) {
                        bloc.add(SelectSubjectId(id: type));
                      },
                      items: state.subjectList,
                    ),
                    if (state.forms == Forms.invalid &&
                        state.selectedSubjectId == -1)
                      TextB(
                          text: LocaleKeys.selectSubject.tr(), fontColor: bRed),
                    const Gap(20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: DropdownFieldB(
                            dropdownHeight: 50,
                            label: LocaleKeys.chapter.tr(),
                            labelColor: bBlack,
                            setState: state.setChapter,
                            dropDownValue: state.selectedChapterId,
                            selected: (dynamic type) {
                              bloc.add(SelectChapterId(id: type));
                            },
                            items: state.chapterList,
                          ),
                        ),
                        if (state.selectedSubjectId != -1)
                          Row(
                            children: [
                              const Gap(20),
                              InkWell(
                                onTap: () {},
                                child: ButtonB(
                                  heigh: 50,
                                  text: "+",
                                  press: () {
                                    bloc.add(CreateChapter());
                                  },
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                    if (state.forms == Forms.invalid &&
                        state.selectedChapterId == -1)
                      TextB(
                          text: LocaleKeys.plsSelectChapter.tr(),
                          fontColor: bRed),
                    const Gap(20),
                    DropdownFieldB(
                      dropdownHeight: 50,
                      label: LocaleKeys.resourceType.tr(),
                      labelColor: bBlack,
                      dropDownValue: state.selectedResourceType,
                      selected: (dynamic type) {
                        bloc.add(SelectResourceType(type: type));
                      },
                      items: state.resourceTypeList,
                    ),
                    const Gap(20),
                    //resourctype Article==========================================
                    if (state.selectedResourceType == "Article")
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFieldB(
                            isMandatory: true,
                            fieldTitle: LocaleKeys.title.tr(),
                            hintText: LocaleKeys.enterTitle.tr(),
                            borderColor: bGray12,
                            focusNode: titleFocusnode,
                            controller: titleController,
                            onChanged: (String value) {
                              bloc.add(ChangeTitle(title: value));
                            },
                            errorText: state.forms == Forms.invalid &&
                                    state.title.isEmpty
                                ? LocaleKeys.enterTitle.tr()
                                : '',
                          ),
                          const Gap(20),
                          TextB(
                            text: LocaleKeys.description.tr(),
                            textStyle: const TextStyle(fontSize: 16),
                            fontColor: bGray100,
                          ),
                          const Gap(5),
                          Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: bWhite,
                              border: Border.all(color: bGray12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 240,
                            child: Column(
                              children: [
                                QuillSimpleToolbar(
                                  controller: qcontroller,
                                  configurations:
                                      const QuillSimpleToolbarConfigurations(
                                    multiRowsDisplay: false,
                                    toolbarSize: 45,
                                  ),
                                ),
                                Expanded(
                                  child: QuillEditor.basic(
                                    controller: qcontroller,
                                    configurations: QuillEditorConfigurations(
                                      placeholder:
                                          LocaleKeys.enterDescription.tr(),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //Attechments==========================
                          Column(
                            children: [
                              const Gap(15),
                              ShowFileName(
                                selectedFile: state.fileList,
                                press: (int index) {
                                  bloc.add(
                                      RemoveFile(index: index, isThumb: false));
                                },
                              ),
                            ],
                          ),
                          const Gap(10),
                          DottedButtonB(
                            title: LocaleKeys.attachment.tr(),
                            verticalPadding: 20,
                            bgColor: kPrimaryColor,
                            borderColor: kPrimaryColor,
                            textColor: bWhite,
                            svgIcon: fileAttachSvg,
                            svgColor: bWhite,
                            svgHeight: 30,
                            press: () {
                              bloc.add(const GetFile(isThumb: false));
                            },
                          ),
                          if (state.forms == Forms.invalid &&
                              state.fileList.isEmpty)
                            TextB(
                                text:
                                    LocaleKeys.pleaseSelectAtLeastOneFile.tr(),
                                fontColor: bRed),
                          //End Attechments==========================

                          //Add Thumbnail==========================
                          Column(
                            children: [
                              const Gap(15),
                              ShowFileName(
                                selectedFile: state.thumbList,
                                press: (int index) {
                                  bloc.add(
                                      RemoveFile(index: index, isThumb: true));
                                },
                              ),
                            ],
                          ),
                          const Gap(10),
                          SizedBox(
                            height: 55,
                            width: 250,
                            child: ButtonB(
                              text: LocaleKeys.addThumb.tr(),
                              borderColor: bJungleGreen,
                              textColor: bJungleGreen,
                              bgColor: bWhite,
                              svgIcon: fileAttachSvg,
                              press: () {
                                bloc.add(const GetFile(isThumb: true));
                              },
                            ),
                          ),
                          if (state.forms == Forms.invalid &&
                              state.thumbList.isEmpty)
                            TextB(
                                text: LocaleKeys.addThumb.tr(),
                                fontColor: bRed),
                        ],
                      ),

                    //resourctype video==========================================
                    if (state.selectedResourceType == "Video")
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFieldB(
                            isMandatory: true,
                            fieldTitle: LocaleKeys.title.tr(),
                            hintText: LocaleKeys.enterTitle.tr(),
                            borderColor: bGray12,
                            focusNode: titleFocusnode,
                            controller: titleController,
                            onChanged: (String value) {
                              bloc.add(ChangeTitle(title: value));
                            },
                            errorText: state.forms == Forms.invalid &&
                                    state.title.isEmpty
                                ? LocaleKeys.enterTitle.tr()
                                : '',
                          ),
                          const Gap(20),
                          TextFieldB(
                            isMandatory: true,
                            fieldTitle: LocaleKeys.videoLink.tr(),
                            hintText: "Enter video link",
                            borderColor: bGray12,
                            focusNode: videoFocusnode,
                            controller: videoController,
                            onChanged: (String value) {
                              bloc.add(ChangeVideoLink(link: value));
                            },
                            errorText: state.forms == Forms.invalid &&
                                    state.videoLink.isEmpty
                                ? LocaleKeys.videoLink.tr()
                                : '',
                          ),

                          //Add Thumbnail==========================
                          Column(
                            children: [
                              const Gap(15),
                              ShowFileName(
                                selectedFile: state.thumbList,
                                press: (int index) {
                                  bloc.add(
                                      RemoveFile(index: index, isThumb: true));
                                },
                              ),
                            ],
                          ),
                          const Gap(10),
                          if (state.resourceId == -1)
                            SizedBox(
                              height: 55,
                              width: 250,
                              child: ButtonB(
                                text: LocaleKeys.addThumb.tr(),
                                borderColor: bJungleGreen,
                                textColor: bJungleGreen,
                                bgColor: bWhite,
                                svgIcon: fileAttachSvg,
                                press: () {
                                  bloc.add(const GetFile(isThumb: true));
                                },
                              ),
                            ),
                          if (state.forms == Forms.invalid &&
                              state.thumbList.isEmpty)
                            TextB(
                                text: LocaleKeys.addThumb.tr(),
                                fontColor: bRed),
                        ],
                      ),
                    const Gap(20),
                    ButtonB(
                      heigh: 60,
                      text: state.resourceId == -1
                          ? LocaleKeys.create.tr()
                          : LocaleKeys.save.tr(),
                      press: () {
                        List jsonContent =
                            qcontroller.document.toDelta().toJson();

                        final htmlContent =
                            QuillJsonToHTML.encodeJson(jsonContent);

                        bloc.add(
                          PressToCreate(
                            isDraft: false,
                            content: htmlContent,
                            titleFocusnode: titleFocusnode,
                          ),
                        );
                      },
                    ),
                    const Gap(20),
                    Row(
                      children: [
                        Expanded(
                          child: ButtonB(
                            heigh: 60,
                            fontSize: 15,
                            bgColor: kSecondaryColor,
                            horizontalPadding: 5,
                            text: LocaleKeys.saveAsDraft.tr(),
                            press: () {
                              List jsonContent =
                                  qcontroller.document.toDelta().toJson();

                              final htmlContent =
                                  QuillJsonToHTML.encodeJson(jsonContent);
                              bloc.add(
                                PressToCreate(
                                  isDraft: true,
                                  content: htmlContent,
                                  titleFocusnode: titleFocusnode,
                                ),
                              );
                            },
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: ButtonB(
                            heigh: 60,
                            bgColor: kTextDefaultColor.withOpacity(0.2),
                            textColor: kTextAnotherColor,
                            text: LocaleKeys.cancel.tr(),
                            press: () {
                              bloc.add(PressToCancel());
                            },
                          ),
                        ),
                      ],
                    ),
                    const Gap(20),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
