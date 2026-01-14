import 'package:equatable/equatable.dart';

class ImageResponse extends Equatable {
  final String url;

  const ImageResponse({required this.url});

  factory ImageResponse.fromJson(Map<String, dynamic> json) {
    return ImageResponse(url: json['url'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'url': url};
  }

  @override
  List<Object?> get props => [url];
}
