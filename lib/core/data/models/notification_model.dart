class NotificationResponse {
  bool? status;
  String? message;
  List<NotificationModel> data;
  int? total;

  NotificationResponse({
    this.status,
    this.message,
    this.data = const [],
    this.total,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  NotificationModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      total: json['total'],
    );
  }
}

class NotificationModel {
  int? id;
  String? title;
  String? content;
  String? type;
  String? status;
  int? targetId;
  String? targetUserId;
  String? createdBy;
  String? updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  NotificationModel({
    this.id,
    this.title,
    this.content,
    this.type,
    this.status,
    this.targetId,
    this.targetUserId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      type: json['type'] as String?,
      status: json['status'] as String?,
      targetId: json['targetId'] as int?,
      targetUserId: json['targetUserId'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
    );
  }
}

class NotificationResponseStatus {
  bool? status;
  String? message;
  bool? data;
  int? total;
  String? extend;

  NotificationResponseStatus({
    this.status,
    this.message,
    this.data,
    this.total,
    this.extend,
  });

  factory NotificationResponseStatus.fromJson(Map<String, dynamic> json) {
    return NotificationResponseStatus(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] as bool?,
      total: json['total'] as int?,
      extend: json['extend'] as String?,
    );
  }
}

class StatusNotificationModel {
  bool? status;
  String? message;
  bool data;
  int? total;

  // Null? extend;

  StatusNotificationModel({
    this.status,
    this.message,
    this.data = false,
    this.total,
  });

  factory StatusNotificationModel.fromJson(Map<String, dynamic> json) {
    return StatusNotificationModel(
      status: json['status'],
      message: json['message'],
      data: json['data'],
      total: json['total'],
      // extend : json['extend'],
    );
  }
}
