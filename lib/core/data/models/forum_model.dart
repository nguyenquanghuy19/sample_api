import 'dart:convert';

import 'package:elearning/core/utils/time_ago_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ForumModel {
  bool? status;
  String? message;
  List<DataForumCourse> data;
  int? total;

  ForumModel({this.status, this.message, this.data = const [], this.total});

  factory ForumModel.fromJson(Map<String, dynamic> json) {
    return ForumModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  DataForumCourse.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      total: json['total'] as int?,
    );
  }
}

class ForumTopicModel {
  bool? status;
  String? message;
  DataForumCourse? data;
  int? total;

  ForumTopicModel({this.status, this.message, this.data, this.total});

  factory ForumTopicModel.fromJson(Map<String, dynamic> json) {
    return ForumTopicModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? DataForumCourse.fromJson(json['products'] as Map<String, dynamic>)
          : null,
      total: json['total'] as int?,
    );
  }
}

class DataForumCourse {
  int? id;
  String? name;
  String? description;
  String? slug;
  int? total;
  String? status;
  String? type;
  int? parentId;
  List<TopicModel> listTopic;

  LatestPostModel? latestPost;
  ForumPostsModel? post;

  DataForumCourse({
    this.id,
    this.name,
    this.description,
    this.slug,
    this.total,
    this.status,
    this.type,
    this.parentId,
    this.listTopic = const [],
    this.latestPost,
    this.post,
  });

  factory DataForumCourse.fromJson(Map<String, dynamic> json) {
    return DataForumCourse(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      slug: json['slug'] as String?,
      total: json['total'] as int?,
      status: json['status'] as String?,
      type: json['type'] as String?,
      parentId: json['parentId'] as int?,
      listTopic: (json['children'] as List<dynamic>?)
              ?.map(
                (dynamic e) => TopicModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      latestPost: json['latestPost'] == null
          ? null
          : LatestPostModel.fromJson(
              json['latestPost'] as Map<String, dynamic>,
            ),
      post: json['post'] == null
          ? null
          : ForumPostsModel.fromJson(json['post'] as Map<String, dynamic>),
    );
  }
}

class TopicModel {
  int? id;
  String? name;
  String? description;
  String? slug;
  int total;
  String? status;
  String? type;
  int? parentId;
  List<ChildrenModel> children;

  LatestPostModel? latestPost;
  ForumPostsModel? post;

  TopicModel({
    this.id,
    this.name,
    this.description,
    this.slug,
    this.total = 0,
    this.status,
    this.type,
    this.parentId,
    this.children = const [],
    this.latestPost,
    this.post,
  });

  factory TopicModel.fromJson(Map<String, dynamic> json) {
    return TopicModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      slug: json['slug'] as String?,
      total: json['total'] as int,
      status: json['status'] as String?,
      type: json['type'] as String?,
      parentId: json['parentId'] as int?,
      children: (json['children'] as List<dynamic>?)
              ?.map(
                (dynamic e) =>
                    ChildrenModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      latestPost: json['latestPost'] == null
          ? null
          : LatestPostModel.fromJson(
              json['latestPost'] as Map<String, dynamic>,
            ),
      post: json['post'] == null
          ? null
          : ForumPostsModel.fromJson(json['post'] as Map<String, dynamic>),
    );
  }
}

class LatestPostModel {
  int? id;
  String? title;
  String? content;
  String? summary;
  String? slug;
  String? status;
  String? type;
  int? forumTopicId;
  String? createdBy;
  DateTime? createdAt;
  String? avatar;
  String? displayName;

  LatestPostModel({
    this.id,
    this.title,
    this.content,
    this.summary,
    this.slug,
    this.status,
    this.type,
    this.forumTopicId,
    this.createdBy,
    this.createdAt,
    this.avatar,
    this.displayName,
  });

  factory LatestPostModel.fromJson(Map<String, dynamic> json) {
    return LatestPostModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      summary: json['summary'] as String?,
      slug: json['slug'] as String?,
      status: json['status'] as String?,
      type: json['type'] as String?,
      forumTopicId: json['forumTopicId'] as int?,
      createdBy: json['createdBy'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      avatar: json['avatar'] as String?,
      displayName: json['displayName'] as String?,
    );
  }
}

class ChildrenModel {
  int? id;
  String? name;
  String? description;
  String? slug;
  int? total;
  String? status;
  String? type;
  int? parentId;
  List<ChildrenModel> children;

  LatestPostModel? latestPost;
  ForumPostsModel? post;

  ChildrenModel({
    this.id,
    this.name,
    this.description,
    this.slug,
    this.total,
    this.status,
    this.type,
    this.parentId,
    this.children = const [],
    this.latestPost,
    this.post,
  });

  factory ChildrenModel.fromJson(Map<String, dynamic> json) {
    return ChildrenModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      slug: json['slug'] as String?,
      total: json['total'] as int?,
      status: json['status'] as String?,
      type: json['type'] as String?,
      parentId: json['parentId'] as int?,
      children: (json['children'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  ChildrenModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      latestPost: json['latestPost'] == null
          ? null
          : LatestPostModel.fromJson(
              json['latestPost'] as Map<String, dynamic>,
            ),
      post: json['post'] == null
          ? null
          : ForumPostsModel.fromJson(json['post'] as Map<String, dynamic>),
    );
  }
}

/// model get post forum
class ResponseDataPostModel {
  bool? status;
  String? message;
  DataPostModel? data;
  int total;

  ResponseDataPostModel({this.status, this.message, this.data, this.total = 0});

  factory ResponseDataPostModel.fromJson(Map<String, dynamic> json) {
    return ResponseDataPostModel(
      total: json['total'] as int,
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? DataPostModel.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

class DataPostModel {
  int? id;
  String? name;
  String? description;
  String? slug;
  int total;
  String? status;
  String? type;
  int? parentId;
  List<String> children;
  LatestPostModel? latestPost;
  List<ForumPostsModel> posts;

  DataPostModel({
    this.id,
    this.name,
    this.description,
    this.slug,
    this.total = 0,
    this.status,
    this.type,
    this.parentId,
    this.children = const [],
    this.latestPost,
    this.posts = const [],
  });

  factory DataPostModel.fromJson(Map<String, dynamic> json) {
    return DataPostModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      slug: json['slug'] as String?,
      total: json['total'] as int,
      status: json['status'] as String?,
      type: json['type'] as String?,
      parentId: json['parentId'] as int?,
      children:
          (json['children'] as List<String>?)?.map<String>((e) => e).toList() ??
              const [],
      latestPost: json['latestPost'] == null
          ? null
          : LatestPostModel.fromJson(
              json['latestPost'] as Map<String, dynamic>,
            ),
      posts: (json['forumPosts'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  ForumPostsModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }
}

class ForumPostsModel {
  int? id;
  String? title;
  String? content;
  String? summary;
  String? slug;
  String? status;
  String? type;
  int? topicId;
  String? createdBy;
  DateTime? createdAt;
  String? avatar;
  String? displayName;

  ForumPostsModel({
    this.id,
    this.title,
    this.content,
    this.summary,
    this.slug,
    this.status,
    this.type,
    this.topicId,
    this.createdBy,
    this.createdAt,
    this.avatar,
    this.displayName,
  });

  Uint8List? convertAvatar() {
    try {
      return base64Decode(avatar!);
    } catch (e) {
      return null;
    }
  }

  String? get dateFormat {
    if (createdAt != null) {
      return createdAt!.day == DateTime.now().day
          ? "Today at ${DateFormat('hh:mm a').format(createdAt!)}"
          : "${DateFormat('yyyy-MM-dd').format(createdAt!)} at ${DateFormat('HH:mm').format(createdAt!)}";
    }

    return null;
  }

  factory ForumPostsModel.fromJson(Map<String, dynamic> json) {
    return ForumPostsModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      summary: json['summary'] as String?,
      slug: json['slug'] as String?,
      status: json['status'] as String?,
      type: json['type'] as String?,
      topicId: json['topicId'] as int?,
      createdBy: json['createdBy'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      avatar: json['avatar'] as String?,
      displayName: json['displayName'] as String?,
    );
  }
}

class ForumResponseModel {
  bool? status;
  String? message;
  ForumPostsModel? dataForum;
  int? total;

  ForumResponseModel({this.status, this.message, this.dataForum, this.total});

  factory ForumResponseModel.fromJson(Map<String, dynamic> json) {
    return ForumResponseModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      dataForum: json['data'] != null
          ? ForumPostsModel.fromJson(json['data'] as Map<String, dynamic>)
          : null,
      total: json['total'] as int?,
    );
  }
}

/// Model common of likes comment
class ForumLikesResponseModel {
  bool? status;
  String? message;
  int? total;

  ForumLikesResponseModel({this.status, this.message, this.total});

  factory ForumLikesResponseModel.fromJson(Map<String, dynamic> json) {
    return ForumLikesResponseModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      total: json['total'] as int?,
    );
  }
}

class CommentModel {
  bool? status;
  String? message;
  List<CommentItemModel> data;
  int? total;

  CommentModel({this.status, this.message, this.data = const [], this.total});

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      total: json['total'] as int?,
      data: (json['data'] as List<dynamic>?)
              ?.map((dynamic e) =>
                  CommentItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }
}

class CommentItemModel {
  int? id;
  String? content;
  int? forumPostId;
  int totalLike = 0;
  String? status;
  String? type;
  bool hasLike = false;
  String? createdBy;
  DateTime? createdAt;

  CommentItemModel({
    this.id,
    this.content,
    this.forumPostId,
    this.totalLike = 0,
    this.status,
    this.type,
    this.hasLike = false,
    this.createdBy,
    this.createdAt,
  });

  String? dateFormat(BuildContext context) {
    if (createdAt != null) {
      return TimeAgoUtils.timeAgo(context: context, time: createdAt!);
    }

    return null;
  }

  factory CommentItemModel.fromJson(Map<String, dynamic> json) {
    return CommentItemModel(
      id: json['id'] as int?,
      content: json['content'] as String?,
      forumPostId: json['forumPostId'] as int?,
      totalLike: json['totalLike'] as int,
      status: json['status'] as String?,
      type: json['type'] as String?,
      hasLike: json['hasLike'] as bool,
      createdBy: json['createdBy'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );
  }
}
