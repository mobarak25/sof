class ResourceDetails {
  final Data? data;

  const ResourceDetails({
    this.data,
  });

  factory ResourceDetails.fromJson(Map<String, dynamic> json) =>
      ResourceDetails(
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class Data {
  final int? id;
  final String? title;
  final String? content;
  final int? subjectId;
  final int? chapterId;
  final String? thumbnail;
  final int? resourceType;
  final List<Attachment>? attachments;
  final List<Video>? videos;
  final Subject? subject;
  final ResourceChapter? chapter;

  const Data({
    this.id,
    this.title,
    this.content,
    this.subjectId,
    this.chapterId,
    this.thumbnail,
    this.resourceType,
    this.attachments,
    this.videos,
    this.subject,
    this.chapter,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        content: json["content"],
        subjectId: json["subject_id"],
        chapterId: json["chapter_id"],
        thumbnail: json["thumbnail"],
        resourceType: json["resource_type"],
        attachments: json["attachments"] == null
            ? []
            : List<Attachment>.from(
                json["attachments"]!.map((x) => Attachment.fromJson(x))),
        videos: json["videos"] == null
            ? []
            : List<Video>.from(json["videos"]!.map((x) => Video.fromJson(x))),
        subject:
            json["subject"] == null ? null : Subject.fromJson(json["subject"]),
        chapter: json["chapter"] == null
            ? null
            : ResourceChapter.fromJson(json["chapter"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "subject_id": subjectId,
        "chapter_id": chapterId,
        "thumbnail": thumbnail,
        "resource_type": resourceType,
        "attachments": attachments == null
            ? []
            : List<dynamic>.from(attachments!.map((x) => x.toJson())),
        "videos": videos == null
            ? []
            : List<dynamic>.from(videos!.map((x) => x.toJson())),
        "subject": subject?.toJson(),
        "chapter": chapter?.toJson(),
      };
}

class Attachment {
  final int? id;
  final String? url;
  final int? resourceId;

  const Attachment({
    this.id,
    this.url,
    this.resourceId,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        id: json["id"],
        url: json["url"],
        resourceId: json["resource_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "resource_id": resourceId,
      };
}

class ResourceChapter {
  final int? id;
  final String? title;

  const ResourceChapter({
    this.id,
    this.title,
  });

  factory ResourceChapter.fromJson(Map<String, dynamic> json) =>
      ResourceChapter(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}

class Subject {
  final int? id;
  final String? name;
  final String? imageUrl;
  final int? versionId;
  final int? classId;
  final Class? version;
  final Class? subjectClass;

  const Subject({
    this.id,
    this.name,
    this.imageUrl,
    this.versionId,
    this.classId,
    this.version,
    this.subjectClass,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        name: json["name"],
        imageUrl: json["image_url"],
        versionId: json["version_id"],
        classId: json["class_id"],
        version:
            json["version"] == null ? null : Class.fromJson(json["version"]),
        subjectClass:
            json["class"] == null ? null : Class.fromJson(json["class"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image_url": imageUrl,
        "version_id": versionId,
        "class_id": classId,
        "version": version?.toJson(),
        "class": subjectClass?.toJson(),
      };
}

class Class {
  final int? id;
  final String? name;

  const Class({
    this.id,
    this.name,
  });

  factory Class.fromJson(Map<String, dynamic> json) => Class(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Video {
  final int? id;
  final String? title;
  final String? embedUrl;
  final String? duration;
  final int? resourceId;
  final String? videoId;
  final List<VideoThumbnail>? videoThumbnails;

  const Video({
    this.id,
    this.title,
    this.embedUrl,
    this.duration,
    this.resourceId,
    this.videoId,
    this.videoThumbnails,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        title: json["title"],
        embedUrl: json["embed_url"],
        duration: json["duration"],
        resourceId: json["resource_id"],
        videoId: json["video_id"],
        videoThumbnails: json["video_thumbnails"] == null
            ? []
            : List<VideoThumbnail>.from(json["video_thumbnails"]!
                .map((x) => VideoThumbnail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "embed_url": embedUrl,
        "duration": duration,
        "resource_id": resourceId,
        "video_id": videoId,
        "video_thumbnails": videoThumbnails == null
            ? []
            : List<dynamic>.from(videoThumbnails!.map((x) => x.toJson())),
      };
}

class VideoThumbnail {
  final int? id;
  final String? thumbDefault;
  final String? thumbMedium;
  final String? thumbHigh;
  final String? thumbStandard;
  final String? thumbMaxres;
  final int? resourceVideoId;

  const VideoThumbnail({
    this.id,
    this.thumbDefault,
    this.thumbMedium,
    this.thumbHigh,
    this.thumbStandard,
    this.thumbMaxres,
    this.resourceVideoId,
  });

  factory VideoThumbnail.fromJson(Map<String, dynamic> json) => VideoThumbnail(
        id: json["id"],
        thumbDefault: json["thumb_default"],
        thumbMedium: json["thumb_medium"],
        thumbHigh: json["thumb_high"],
        thumbStandard: json["thumb_standard"],
        thumbMaxres: json["thumb_maxres"],
        resourceVideoId: json["resource_video_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "thumb_default": thumbDefault,
        "thumb_medium": thumbMedium,
        "thumb_high": thumbHigh,
        "thumb_standard": thumbStandard,
        "thumb_maxres": thumbMaxres,
        "resource_video_id": resourceVideoId,
      };
}
