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
    this.userId = '',
    this.eventList = const EventList(),
    this.events = const {},
  });

  final int page;
  final bool loading;
  final bool isFirst;
  final bool isEndList;
  final bool incrementLoader;
  final String activeTab;
  final String startDate;
  final String endDate;
  final String userId;
  final EventList eventList;
  final Map<String, int> events;

  EventState copyWith({
    int? page,
    bool? loading,
    bool? isFirst,
    bool? isEndList,
    bool? incrementLoader,
    String? activeTab,
    String? startDate,
    String? endDate,
    String? userId,
    String? searchText,
    EventList? eventList,
    Map<String, int>? events,
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
      userId: userId ?? this.userId,
      eventList: eventList ?? this.eventList,
      events: events ?? this.events,
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
        userId,
        eventList,
        events
      ];
}

final class EventInitial extends EventState {}
