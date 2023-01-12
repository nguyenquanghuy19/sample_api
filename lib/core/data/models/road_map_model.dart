class DataRoadmap {
  int? id;
  int? classroomId;
  int? roadmapId;
  String? type;
  String? status;
  String? note;
  List<LectureModel> items;
  String? createdBy;
  String? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  DataRoadmap({
    this.id,
    this.classroomId,
    this.roadmapId,
    this.type,
    this.status,
    this.note,
    this.items = const [],
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  bool startLeft(int indexLecture) {
    int length = 0;
    for (int i = 0; i <= indexLecture; i++) {
      length += items[i].items.length;
    }
    if (length % 2 ==  1) {
      return true;
    }

    return false;
  }

  bool startLeftPosition(int indexLecture, int indexLession) {
    if (indexLecture == 0) {
      if (indexLession % 2 == 0) {
        return true;
      }

      return false;
    }

    int length = 0;
    for (int i = 0; i < indexLecture; i++) {
      length += items[i].items.length;
    }
    if (length % 2 == 0) {
      if (indexLession % 2 == 0) {
        return true;
      }

      return false;
    } else {
      if (indexLession % 2 == 0) {
        return false;
      }

      return true;
    }
  }

  factory DataRoadmap.fromJson(Map<String, dynamic> json) {
    return DataRoadmap(
      id: json['id'] as int?,
      classroomId: json['classroomId'] as int?,
      roadmapId: json['roadmapId'] as int?,
      type: json['type'] as String?,
      status: json['status'] as String?,
      note: json['note'] as String?,
      items: (json['items'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  LectureModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      deletedAt: json['deletedAt'] as String?,
    );
  }
}

class LectureModel {
  int? id;
  int? fkey;
  String? name;
  String? unit;
  List<LectureModel> items;
  int? total;
  String? slug;
  String? type;
  int? parent;
  String? status;
  String? sequent;

  LectureModel({
    this.id,
    this.unit,
    this.items = const [],
    this.parent,
    this.total,
    this.fkey,
    this.name,
    this.slug,
    this.type,
    this.status,
    this.sequent,
  });

  factory LectureModel.fromJson(Map<String, dynamic> json) {
    return LectureModel(
      id: json['id'] as int?,
      items: (json['items'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  LectureModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      unit: json['unit'] as String?,
      parent: json['parent'] as int?,
      total: json['total'] as int?,
      fkey: json['fkey'] as int?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      type: json['type'] as String?,
      status: json['status'] as String?,
      sequent: json['sequent'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fkey'] = fkey;
    data['name'] = name;
    data['slug'] = slug;
    data['type'] = type;
    data['status'] = status;
    data['sequent'] = sequent;

    return data;
  }
}
