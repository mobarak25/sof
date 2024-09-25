class ImageResponse {
  final List<FileElement>? files;

  ImageResponse({
    this.files,
  });

  factory ImageResponse.fromJson(Map<String, dynamic> json) => ImageResponse(
        files: json["files"] == null
            ? []
            : List<FileElement>.from(
                json["files"]!.map((x) => FileElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "files": files == null
            ? []
            : List<dynamic>.from(files!.map((x) => x.toJson())),
      };
}

class FileElement {
  final String? fieldname;
  final String? originalname;
  final String? encoding;
  final String? mimetype;
  final int? size;
  final String? bucket;
  final String? key;
  final String? acl;
  final String? contentType;
  final dynamic contentDisposition;
  final String? storageClass;
  final dynamic serverSideEncryption;
  final dynamic metadata;
  final String? location;
  final String? etag;

  FileElement({
    this.fieldname,
    this.originalname,
    this.encoding,
    this.mimetype,
    this.size,
    this.bucket,
    this.key,
    this.acl,
    this.contentType,
    this.contentDisposition,
    this.storageClass,
    this.serverSideEncryption,
    this.metadata,
    this.location,
    this.etag,
  });

  factory FileElement.fromJson(Map<String, dynamic> json) => FileElement(
        fieldname: json["fieldname"],
        originalname: json["originalname"],
        encoding: json["encoding"],
        mimetype: json["mimetype"],
        size: json["size"],
        bucket: json["bucket"],
        key: json["key"],
        acl: json["acl"],
        contentType: json["contentType"],
        contentDisposition: json["contentDisposition"],
        storageClass: json["storageClass"],
        serverSideEncryption: json["serverSideEncryption"],
        metadata: json["metadata"],
        location: json["location"],
        etag: json["etag"],
      );

  Map<String, dynamic> toJson() => {
        "fieldname": fieldname,
        "originalname": originalname,
        "encoding": encoding,
        "mimetype": mimetype,
        "size": size,
        "bucket": bucket,
        "key": key,
        "acl": acl,
        "contentType": contentType,
        "contentDisposition": contentDisposition,
        "storageClass": storageClass,
        "serverSideEncryption": serverSideEncryption,
        "metadata": metadata,
        "location": location,
        "etag": etag,
      };
}
