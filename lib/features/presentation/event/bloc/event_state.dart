part of 'event_bloc.dart';

class EventState extends Equatable {
  const EventState({
    this.page = 1,
    this.loading = false,
    this.isFirst = true,
    this.isEndList = false,
    this.incrementLoader = false,
    this.activeTab = '0',
    this.startDate = '',
    this.endDate = '',
    this.eventList = const EventList(),
  });

  final int page;
  final bool loading;
  final bool isFirst;
  final bool isEndList;
  final bool incrementLoader;
  final String activeTab;
  final String startDate;
  final String endDate;
  final EventList eventList;

  EventState copyWith({
    int? page,
    bool? loading,
    bool? isFirst,
    bool? isEndList,
    bool? incrementLoader,
    String? activeTab,
    String? startDate,
    String? endDate,
    String? searchText,
    EventList? eventList,
  }) {
    return EventState(
      page: page ?? this.page,
      loading: loading ?? this.loading,
      isFirst: isFirst ?? this.isFirst,
      isEndList: isEndList ?? this.isEndList,
      incrementLoader: incrementLoader ?? this.incrementLoader,
      activeTab: activeTab ?? this.activeTab,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      eventList: eventList ?? this.eventList,
    );
  }

  @override
  List<Object> get props => [
        page,
        loading,
        isFirst,
        isEndList,
        incrementLoader,
        activeTab,
        startDate,
        endDate,
        eventList,
      ];
}

final class EventInitial extends EventState {}
