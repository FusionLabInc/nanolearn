import 'package:flutter/foundation.dart';

@immutable
class Content {
  final String? id;
  final String? fileName;
  final int? size;

  const Content({
    this.id,
    this.fileName,
    this.size,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      id: json['id'] as String?,
      fileName: json['file_name'] as String?,
      size: json['size'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "file_name": fileName,
        "size": size,
      };

  Content copyWith({
    String? id,
    String? fileName,
    int? size,
  }) {
    return Content(
      id: id ?? this.id,
      fileName: fileName ?? this.fileName,
      size: size ?? size,
    );
  }
}
