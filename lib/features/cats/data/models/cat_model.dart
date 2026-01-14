import '../../domain/entities/cat.dart';

final class CatModel extends Cat {
  CatModel({
    super.id,
    super.url,
    super.width,
    super.height,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'width': width,
      'height': height,
    };
  }

  factory CatModel.fromJson(Map<String, dynamic> json) {
    return CatModel(
      id: json['id'] as String?,
      url: json['url'] as String?,
      width: json['width'] as int?,
      height: json['height'] as int?,
    );
  }

  @override
  String toString() => "Cats(id: $id,url: $url,width: $width,height: $height)";

  @override
  int get hashCode => Object.hash(id, url, width, height);
}
