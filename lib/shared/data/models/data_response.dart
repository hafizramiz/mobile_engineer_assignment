
import 'package:cat_app_toy_project/shared/data/models/result_model.dart';

import '../../../core/models/base_model.dart';

final class DataResponse extends BaseModel<DataResponse>{
  String? version;
  bool? isSuccess;
  ResultModel? result;
  String? message;
  int? statusCode;

  DataResponse({
    this.version,
    this.isSuccess,
    this.result,
    this.message,
    this.statusCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'Version': version,
      'IsSuccess': isSuccess,
      'Result': result,
      'Message': message,
      'StatusCode': statusCode,
    };
  }

  factory DataResponse.fromJson(Map<String, dynamic> json) {
    return DataResponse(
      version: json['Version'] as String?,
      isSuccess: json['IsSuccess'] as bool?,
      result: json['Result'] == null
          ? null
          : ResultModel.fromJson(json['Result'] as Map<String, dynamic>),
      message: json['Message'] as String?,
      statusCode: json['StatusCode'] as int?,
    );
  }

  @override
  String toString() =>
      "DataResponse(version: $version,isSuccess: $isSuccess,result: $result,message: $message,statusCode: $statusCode)";

  @override
  int get hashCode =>
      Object.hash(version, isSuccess, result, message, statusCode);

  @override
  DataResponse fromJson(json) {
   return DataResponse.fromJson(json);
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}



