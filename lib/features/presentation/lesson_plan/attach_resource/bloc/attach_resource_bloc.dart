import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_of_future/core/utils/utilities.dart';
import 'package:school_of_future/features/data/data_sources/remote_constants.dart';
import 'package:school_of_future/features/domain/entities/lesson_plan_details_response.dart';
import 'package:school_of_future/features/domain/entities/resources_response.dart';
import 'package:school_of_future/features/domain/repositories/api_repo.dart';

part 'attach_resource_event.dart';
part 'attach_resource_state.dart';

class AttachResourceBloc
    extends Bloc<AttachResourceEvent, AttachResourceState> {
  AttachResourceBloc(this._apiRepo) : super(AttachResourceInitial()) {
    on<GetResourcesCheckedIds>(_getResourcesCheckedIds);
    on<GetAllResources>(_getAllResources);
    on<ToggleCheckbox>(_toggleCheckbox);
    on<ChangeSearch>(_changeSearch);

    add(GetAllResources());
  }

  final ApiRepo _apiRepo;

  FutureOr<void> _getResourcesCheckedIds(
      GetResourcesCheckedIds event, Emitter<AttachResourceState> emit) async {
    emit(state.copyWith(checkedId: event.idList));
  }

  FutureOr<void> _getAllResources(
      GetAllResources event, Emitter<AttachResourceState> emit) async {
    final List<CheckUncheckResources> resourceList = [];
    final resources =
        await _apiRepo.get<Resources>(endpoint: teacherResourcesListEndPoint);

    if (resources != null) {
      for (int i = 0; i < resources.data!.length; i++) {
        if (state.checkedId.contains(resources.data![i].id)) {
          resourceList.add(CheckUncheckResources(
            id: resources.data![i].id!,
            isChecked: true,
            name: resources.data![i].title!,
            chapterName: resources.data![i].chapter!.title!,
            thumbImg: resources.data![i].thumbnail!,
          ));
        } else {
          resourceList.add(CheckUncheckResources(
            id: resources.data![i].id!,
            isChecked: false,
            name: resources.data![i].title!,
            chapterName: resources.data![i].chapter!.title!,
            thumbImg: resources.data![i].thumbnail!,
          ));
        }
      }
      emit(state.copyWith(
          allResource: resources, allCheckUncheck: resourceList));
    }
  }

  FutureOr<void> _toggleCheckbox(
      ToggleCheckbox event, Emitter<AttachResourceState> emit) {
    final updatedCopyOptions = state.copyCheckUncheck.map((resource) {
      if (resource.id == event.id) {
        return CheckUncheckResources(
          id: resource.id,
          isChecked: event.value,
          name: resource.name,
          chapterName: resource.chapterName,
          thumbImg: resource.thumbImg,
        );
      }
      return resource; // Return the student as-is if no update
    }).toList();

    final updatedOptions = state.allCheckUncheck.map((resource) {
      if (resource.id == event.id) {
        return CheckUncheckResources(
          id: resource.id,
          isChecked: event.value,
          name: resource.name,
          chapterName: resource.chapterName,
          thumbImg: resource.thumbImg,
        );
      }
      return resource; // Return the student as-is if no update
    }).toList();

    emit(state.copyWith(
        allCheckUncheck: updatedOptions, copyCheckUncheck: updatedCopyOptions));
  }

  FutureOr<void> _changeSearch(
      ChangeSearch event, Emitter<AttachResourceState> emit) {
    if (event.search.isNotEmpty) {
      emit(
        state.copyWith(
          copyCheckUncheck: state.allCheckUncheck
              .where((item) =>
                  item.name.toLowerCase().contains(event.search.toLowerCase()))
              .toList(),
        ),
      );
    } else {
      emit(state.copyWith(copyCheckUncheck: []));
    }
  }
}
