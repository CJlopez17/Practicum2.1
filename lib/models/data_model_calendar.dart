class DataCalendar {
  int status;
  List<DataEvent> data;
  String message;
  int page;
  int paginator;
  int total;
  int totalPages;
  bool hasPreviousPage;
  bool hasNextPage;
  dynamic orderBy;
  bool ascending;

  DataCalendar({
    required this.status,
    required this.data,
    required this.message,
    required this.page,
    required this.paginator,
    required this.total,
    required this.totalPages,
    required this.hasPreviousPage,
    required this.hasNextPage,
    required this.orderBy,
    required this.ascending,
  });

  factory DataCalendar.fromJson(Map<String, dynamic> json) => DataCalendar(
        status: json["status"],
        data: List<DataEvent>.from(
            json["data"].map((x) => DataEvent.fromJson(x))),
        message: json["message"] ?? '',
        page: json["page"],
        paginator: json["paginator"],
        total: json["total"],
        totalPages: json["totalPages"],
        hasPreviousPage: json["hasPreviousPage"],
        hasNextPage: json["hasNextPage"],
        orderBy: json["orderBy"],
        ascending: json["ascending"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "page": page,
        "paginator": paginator,
        "total": total,
        "totalPages": totalPages,
        "hasPreviousPage": hasPreviousPage,
        "hasNextPage": hasNextPage,
        "orderBy": orderBy,
        "ascending": ascending,
      };
}

class DataEvent {
  String title;
  String description;
  List<dynamic> authors;
  String category;
  DateTime date;
  dynamic image;
  dynamic video;
  List<Extra> extras;

  DataEvent({
    required this.title,
    required this.description,
    required this.authors,
    required this.category,
    required this.date,
    required this.image,
    required this.video,
    required this.extras,
  });

  factory DataEvent.fromJson(Map<String, dynamic> json) => DataEvent(
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        authors: json["authors"] != null
            ? List<dynamic>.from(json["authors"].map((x) => x))
            : [],
        category: json["category"] ?? '',
        date: json["date"] ?? DateTime(2024, 1, 1, 0, 0, 0),
        image: json["image"],
        video: json["video"],
        extras: List<Extra>.from(json["extras"].map((x) => Extra.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "authors": List<dynamic>.from(authors.map((x) => x)),
        "category": category,
        "date": date,
        "image": image,
        "video": video,
        "extras": List<dynamic>.from(extras.map((x) => x.toJson())),
      };
}

class Extra {
  String type;
  String name;
  List<DataClass> data;

  Extra({
    required this.type,
    required this.name,
    required this.data,
  });

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
        type: json["type"] ?? '',
        name: json["name"] ?? '',
        data: List<DataClass>.from(
            json["data"].map((x) => DataClass.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataClass {
  String title;
  String description;
  String classroom;
  String type;
  String place;
  String typeSchedule;
  String beginClass;
  String endClass;
  String day;
  String location;
  List<DataclassEvent> relation;

  DataClass({
    required this.title,
    required this.description,
    required this.classroom,
    required this.type,
    required this.place,
    required this.typeSchedule,
    required this.beginClass,
    required this.endClass,
    required this.day,
    required this.location,
    required this.relation,
  });

  factory DataClass.fromJson(Map<String, dynamic> json) => DataClass(
        title: json["title"] ?? '',
        description: json["description"] ?? '',
        classroom: json["classroom"] ?? '',
        type: json["type"] ?? '',
        place: json['place'] ?? '',
        typeSchedule: json['typeSchedule'] ?? '',
        beginClass: json["beginClass"] ?? '',
        endClass: json["endClass"] ?? '',
        day: json["day"] ?? '',
        location: json["location"] ?? '',
        relation: List<DataclassEvent>.from(
          (json["relation"]).map((x) => DataclassEvent.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "classroom": classroom,
        "type": type,
        "place": place,
        "typeSchedule": typeSchedule,
        "beginClass": beginClass,
        "endClass": endClass,
        "day": day,
        "location": location,
        "relation": List<dynamic>,
      };
}

class DataclassEvent {
  String type;
  String? identifier;
  String name;

  DataclassEvent({
    required this.type,
    required this.identifier,
    required this.name,
  });

  factory DataclassEvent.fromJson(Map<String, dynamic> json) => DataclassEvent(
        type: json['type'] ?? '',
        identifier: json["identifier"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "identifier": identifier,
        "name": name,
      };
}
