import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/file_picker/file_picker_service.dart';
import 'package:school_of_future/core/form_validator/validator.dart';
import 'package:school_of_future/core/navigator/iflutter_navigator.dart';
import 'package:school_of_future/core/navigator/navigator_key.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/snackbar/show_snackbar.dart';
import 'package:school_of_future/core/utils/colors.dart';
import 'package:school_of_future/core/utils/enums.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/core/widgets/confirm_cancel_dialog.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/chapter_response.dart';
import 'package:school_of_future/features/domain/entities/default_response.dart';
import 'package:school_of_future/features/domain/entities/get_batch_as_section_response.dart';
import 'package:school_of_future/features/domain/entities/resource_details_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';
import 'package:school_of_future/features/domain/repositories/local_storage_repo.dart';
import 'package:school_of_future/features/presentation/resources/teacher_resources_create/widgets/create_chapter_modal.dart';

part 'resources_create_event.dart';
part 'resources_create_state.dart';

class ResourcesCreateBloc
    extends Bloc<ResourcesCreateEvent, ResourcesCreateState> {
  ResourcesCreateBloc(this._apiRepo, this._iFlutterNavigator,
      this._localStorageRepo, this._filePickerRepo)
      : super(ResourcesCreateInitial()) {
    on<ResourceIdForEdit>(_resourceIdForEdit);
    on<ChangeTitle>(_changeTitle);
    on<ChangeVideoLink>(_changeVideoLink);
    on<GetFile>(_getFile);
    on<RemoveFile>(_removeFile);
    on<GetVersionList>(_getVersionList);
    on<SelectVersionId>(_selectVersionId);
    on<SelectClassId>(_selectClassId);
    on<SelectSubjectId>(_selectSubjectId);
    on<SelectChapterId>(_selectChapterId);
    on<GetChapter>(_getChapter);
    on<CreateChapter>(_createChapter);
    on<SelectResourceType>(_selectResourceType);
    on<PressToCreate>(_pressToCreate);
    on<PressToCancel>(_pressToCancel);
    on<AddData>(_addData);

    add(GetVersionList());
  }

  final ApiRepo _apiRepo;
  final IFlutterNavigator _iFlutterNavigator;
  final LocalStorageRepo _localStorageRepo;
  final FilePickerRepo _filePickerRepo;

  FutureOr<void> _resourceIdForEdit(
      ResourceIdForEdit event, Emitter<ResourcesCreateState> emit) async {
    emit(state.copyWith(resourceId: event.resourceId));

    if (event.resourceId != -1) {
      final details = await _apiRepo.get<ResourceDetails>(
        endpoint: teacherResourcedetailsEndPoint(resourceId: event.resourceId),
      );

      if (details != null) {
        emit(state.copyWith(resourceDtls: details));

        add(SelectVersionId(id: state.resourceDtls.data!.subject!.versionId!));
        add(SelectClassId(id: state.resourceDtls.data!.subject!.classId!));
        add(SelectSubjectId(id: state.resourceDtls.data!.subject!.id!));
      }
    }
  }

  FutureOr<void> _changeTitle(
      ChangeTitle event, Emitter<ResourcesCreateState> emit) {
    emit(state.copyWith(title: event.title));
  }

  FutureOr<void> _changeVideoLink(
      ChangeVideoLink event, Emitter<ResourcesCreateState> emit) {
    emit(state.copyWith(videoLink: event.link));
  }

  FutureOr<void> _getFile(
      GetFile event, Emitter<ResourcesCreateState> emit) async {
    FilePickerResult? result = await _filePickerRepo.filePicker(
        isMultiple: event.isThumb ? false : true);

    List<File> tempFileList = [];

    if (result != null) {
      final files = result.paths
          .map((path) => path != null ? File(path) : File(''))
          .toList();
      tempFileList.clear();
      tempFileList.addAll(files);

      files.map((newFile) {
        state.fileList.map((oldFile) {
          if (newFile.path == oldFile.path) {
            tempFileList.remove(newFile);
          }
        });
      });
      if (event.isThumb) {
        emit(state.copyWith(thumbList: tempFileList));
      } else {
        emit(state.copyWith(fileList: state.fileList + tempFileList));
      }
    } else {}

    if (result != null && event.isThumb) {
      List<String?> validJpgFiles =
          result.paths.where((path) => path!.endsWith('.jpg')).toList();

      if (validJpgFiles.isEmpty) {
        ShowSnackBar(
          message: "Please select a valid jpg file",
          navigator: _iFlutterNavigator,
          color: bRed,
        );
        emit(state.copyWith(thumbList: []));
      }
    }
  }

  FutureOr<void> _removeFile(
      RemoveFile event, Emitter<ResourcesCreateState> emit) {
    if (event.isThumb) {
      emit(state.copyWith(
          thumbList: List.from(state.thumbList)..removeAt(event.index)));
    } else {
      emit(state.copyWith(
          fileList: List.from(state.fileList)..removeAt(event.index)));
    }
  }

  FutureOr<void> _getVersionList(
      GetVersionList event, Emitter<ResourcesCreateState> emit) async {
    final versionList = await _apiRepo.get<GetBacthAsSections>(
        endpoint: getBatchAsSectionsEndPoint);

    List<DropdownItem> resourceType = [
      const DropdownItem(name: "Select", value: -1),
      const DropdownItem(name: "Article", value: "Article"),
      const DropdownItem(name: "Video", value: "Video"),
    ];

    List<DropdownItem> list = [
      const DropdownItem(name: "Select", value: -1),
    ];

    if (versionList != null) {
      for (int i = 0; i < versionList.data!.length; i++) {
        list.add(
          DropdownItem(
              name: versionList.data![i].versionName!,
              value: versionList.data![i].versionId),
        );
      }

      emit(state.copyWith(
          versionList: list,
          bacthAsSection: versionList,
          resourceTypeList: resourceType));
    }
  }

  FutureOr<void> _selectVersionId(
      SelectVersionId event, Emitter<ResourcesCreateState> emit) {
    final data = state.bacthAsSection.data!;
    List<DropdownItem> classList = [
      const DropdownItem(name: "Select", value: -1),
    ];

    if (event.id != state.selectedVersionId) {
      for (int i = 0; i < data.length; i++) {
        if (data[i].versionId == event.id) {
          for (int j = 0; j < data[i].classes!.length; j++) {
            classList.add(DropdownItem(
                name: data[i].classes![j].className!,
                value: data[i].classes![j].classId!));
          }
        }
      }

      emit(state.copyWith(
        selectedVersionId: event.id,
        setClass: true,
        setSubject: true,
        setChapter: true,
        selectedClassId: -1,
        selectedSubjectId: -1,
        selectedChapterId: -1,
        classList: classList,
        subjectList: [
          const DropdownItem(name: "Select", value: -1),
        ],
        chapterList: [],
      ));
    }
  }

  FutureOr<void> _selectClassId(
      SelectClassId event, Emitter<ResourcesCreateState> emit) {
    final data = state.bacthAsSection.data!;
    List<DropdownItem> subjectList = [
      const DropdownItem(name: "Select", value: -1),
    ];

    if (event.id != state.selectedClassId) {
      for (int i = 0; i < data.length; i++) {
        if (data[i].versionId == state.selectedVersionId) {
          for (int j = 0; j < data[i].classes!.length; j++) {
            if (data[i].classes![j].classId == event.id) {
              for (int k = 0; k < data[i].classes![j].subjects!.length; k++) {
                subjectList.add(DropdownItem(
                    name: data[i].classes![j].subjects![k].subjectName!,
                    value: data[i].classes![j].subjects![k].subjectId!));
              }
            }
          }
        }
      }

      emit(state.copyWith(
        selectedClassId: event.id,
        setSubject: true,
        setChapter: true,
        selectedSubjectId: -1,
        selectedChapterId: -1,
        subjectList: subjectList,
        chapterList: [
          const DropdownItem(name: "Select", value: -1),
        ],
      ));
    }
  }

  FutureOr<void> _selectSubjectId(
      SelectSubjectId event, Emitter<ResourcesCreateState> emit) async {
    if (event.id != state.selectedSubjectId) {
      add(GetChapter());
      emit(state.copyWith(
        selectedSubjectId: event.id,
        setChapter: true,
        selectedChapterId: -1,
        chapterList: [
          const DropdownItem(name: "Select", value: -1),
        ],
      ));
    }
  }

  FutureOr<void> _getChapter(
      GetChapter event, Emitter<ResourcesCreateState> emit) async {
    final chapter = await _apiRepo.get<Chapter>(
        endpoint: getChapterEndPoint(subjectId: state.selectedSubjectId));

    List<DropdownItem> listOfChapter = [
      const DropdownItem(name: "Select", value: -1),
    ];

    if (chapter != null) {
      for (int i = 0; i < chapter.data!.length; i++) {
        listOfChapter.add(DropdownItem(
            name: chapter.data![i].name!, value: chapter.data![i].id));
      }
    }
    emit(state.copyWith(chapterList: listOfChapter));
  }

  FutureOr<void> _selectChapterId(
      SelectChapterId event, Emitter<ResourcesCreateState> emit) {
    emit(state.copyWith(selectedChapterId: event.id));
  }

  FutureOr<void> _createChapter(
      CreateChapter event, Emitter<ResourcesCreateState> emit) {
    showChapterCreateDialog(_iFlutterNavigator.context,
        getChapterText: (String chapterTitle) async {
      final create = await _apiRepo.post<DefaultResponse>(
        endpoint: chapterCreateEndPoint,
        body: {
          "subject_id": state.selectedSubjectId,
          "title": chapterTitle,
          "can_delete": 1,
        },
      );
      if (create != null) {
        add(GetChapter());
        ShowSnackBar(message: create.message!, navigator: _iFlutterNavigator);
      }
    });
  }

  FutureOr<void> _selectResourceType(
      SelectResourceType event, Emitter<ResourcesCreateState> emit) {
    if (event.type != state.selectedResourceType) {
      emit(state.copyWith(
        selectedResourceType: event.type,
        title: '',
        fileList: [],
        thumbList: [],
        videoLink: '',
      ));
    }
  }

  FutureOr<void> _pressToCreate(
      PressToCreate event, Emitter<ResourcesCreateState> emit) async {
    if (isValid(event) && !state.loading) {
      emit(state.copyWith(loading: true));

      if (state.resourceId == -1) {
        final create = await _apiRepo.appMultipart<DefaultResponse, void>(
          endpoint: teacherResourcesCreateEndPoint,
          body: {
            "status": event.isDraft ? 0 : 1,
            "title": state.title,
            "content": event.content,
            "subject_id": state.selectedSubjectId,
            "chapter_id": state.selectedChapterId,
            "draft_status": event.isDraft ? 0 : 1,
            "resource_type": state.selectedResourceType == "Video" ? 1 : 0,
            "resource_vedio__embed_url": [state.videoLink],
            "_method": "POST",
          },
          thumbFieldName: "thumbnail",
          thumbFiles: state.thumbList,
          fileFieldName: "resource_attachment__url",
          files: state.fileList,
        );

        if (create != null) {
          _iFlutterNavigator.pop();
          navigatorKey.currentState!.pushNamedAndRemoveUntil(
              teacherResourcesListScreen, ModalRoute.withName('/'));
          ShowSnackBar(message: create.message!, navigator: _iFlutterNavigator);
        }
      } else {
        final create = await _apiRepo.post<DefaultResponse>(
          endpoint:
              teacherResourcedetailsEndPoint(resourceId: state.resourceId),
          body: {
            "title": state.title,
            "content": event.content,
            "subject_id": state.selectedSubjectId,
            "chapter_id": state.selectedChapterId,
            "draft_status": event.isDraft ? 0 : 1,
            "resource_type": state.selectedResourceType == "Video" ? 1 : 0,
            "thumbnail": state.resourceDtls.data!.thumbnail!,
            "resource_vedio__embed_url": [state.videoLink],
            "_method": "PUT",
          },
        );

        if (create != null) {
          _iFlutterNavigator.pop();
          navigatorKey.currentState!.pushNamedAndRemoveUntil(
              teacherResourcesListScreen, ModalRoute.withName('/'));
          ShowSnackBar(message: create.message!, navigator: _iFlutterNavigator);
        }
      }

      emit(state.copyWith(loading: false));
    } else {
      emit(state.copyWith(forms: Forms.invalid));
    }
  }

  bool isValid(PressToCreate event) {
    final validate = Validator.isValidated(items: [
      FormItem(text: state.title, focusNode: event.titleFocusnode),
    ], navigator: _iFlutterNavigator);

    if (!validate) return false;
    if (state.title.isEmpty ||
        state.videoLink.isEmpty && state.selectedResourceType == "Video" ||
        state.selectedVersionId == -1 ||
        state.selectedClassId == -1 ||
        state.selectedSubjectId == -1 ||
        state.selectedChapterId == -1) {
      return false;
    }
    return true;
  }

  FutureOr<void> _pressToCancel(
      PressToCancel event, Emitter<ResourcesCreateState> emit) {
    showCancelDialog(_iFlutterNavigator.context, pressToYes: () {
      Navigator.popUntil(_iFlutterNavigator.context, (route) => route.isFirst);
    });
  }

  FutureOr<void> _addData(AddData event, Emitter<ResourcesCreateState> emit) {
    if (state.isFirstTime) {
      emit(state.copyWith(
        title: event.title,
        videoLink: event.videoLink,
        selectedVersionId: event.selectedVersionId,
        selectedClassId: event.selectedClassId,
        selectedSubjectId: event.selectedSubjectId,
        selectedChapterId: event.selectedChapterId,
        selectedResourceType: event.selectedResourceType,
        isFirstTime: false,
      ));
    }
  }
}
