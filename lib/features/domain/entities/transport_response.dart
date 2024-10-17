class Transport {
  final Data? data;

  const Transport({
    this.data,
  });

  factory Transport.fromJson(Map<String, dynamic> json) => Transport(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final int? id;
  final int? receiverId;
  final int? vehicleId;
  final int? routeId;
  final String? busFare;
  final String? receiverType;
  final List<Schedule>? schedules;
  final Vehicle? vehicle;
  final Route? route;

  const Data({
    this.id,
    this.receiverId,
    this.vehicleId,
    this.routeId,
    this.busFare,
    this.receiverType,
    this.schedules,
    this.vehicle,
    this.route,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        receiverId: json["receiver_id"],
        vehicleId: json["vehicle_id"],
        routeId: json["route_id"],
        busFare: json["bus_fare"],
        receiverType: json["receiver_type"],
        schedules: json["schedules"] == null
            ? []
            : List<Schedule>.from(
                json["schedules"]!.map((x) => Schedule.fromJson(x))),
        vehicle:
            json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]),
        route: json["route"] == null ? null : Route.fromJson(json["route"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "receiver_id": receiverId,
        "vehicle_id": vehicleId,
        "route_id": routeId,
        "bus_fare": busFare,
        "receiver_type": receiverType,
        "schedules": schedules == null
            ? []
            : List<dynamic>.from(schedules!.map((x) => x.toJson())),
        "vehicle": vehicle?.toJson(),
        "route": route?.toJson(),
      };
}

class Route {
  final int? id;
  final String? destination;
  final String? cost;
  final int? mainRouteId;
  final Target? target;

  const Route({
    this.id,
    this.destination,
    this.cost,
    this.mainRouteId,
    this.target,
  });

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        id: json["id"],
        destination: json["destination"],
        cost: json["cost"],
        mainRouteId: json["main_route_id"],
        target: json["target"] == null ? null : Target.fromJson(json["target"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "destination": destination,
        "cost": cost,
        "main_route_id": mainRouteId,
        "target": target?.toJson(),
      };
}

class Target {
  final int? id;
  final String? destination;

  Target({
    this.id,
    this.destination,
  });

  factory Target.fromJson(Map<String, dynamic> json) => Target(
        id: json["id"],
        destination: json["destination"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "destination": destination,
      };
}

class Schedule {
  final int? id;
  final String? weekday;
  final String? homePickupTime;
  final String? schoolPickupTime;
  final int? routeId;
  final bool? isToday;

  const Schedule({
    this.id,
    this.weekday,
    this.homePickupTime,
    this.schoolPickupTime,
    this.routeId,
    this.isToday,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json["id"],
        weekday: json["weekday"],
        homePickupTime: json["home_pickup_time"],
        schoolPickupTime: json["school_pickup_time"],
        routeId: json["route_id"],
        isToday: json["is_today"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "weekday": weekday,
        "home_pickup_time": homePickupTime,
        "school_pickup_time": schoolPickupTime,
        "route_id": routeId,
        "is_today": isToday,
      };
}

class Vehicle {
  final int? id;
  final String? vehicleNo;
  final int? noOfSeats;
  final String? driver;
  final String? busMotherContact;

  const Vehicle({
    this.id,
    this.vehicleNo,
    this.noOfSeats,
    this.driver,
    this.busMotherContact,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: json["id"],
        vehicleNo: json["vehicle_no"],
        noOfSeats: json["no_of_seats"],
        driver: json["driver"],
        busMotherContact: json["bus_mother_contact"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vehicle_no": vehicleNo,
        "no_of_seats": noOfSeats,
        "driver": driver,
        "bus_mother_contact": busMotherContact,
      };
}
