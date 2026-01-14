import 'package:cat_app_toy_project/core/constants/network/network_constants.dart';
import 'package:dio/dio.dart';

import '../../models/data_response.dart';

/// [RemoteDataSource] is responsible for fetching all the necessary data from the server.

abstract class RemoteDataSource {
  Future<DataResponse> fetchData();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  const RemoteDataSourceImpl(this.dio);

  final Dio dio;


  @override
  Future<DataResponse> fetchData() async {

    final result = await dio.get(
      NetworkConstants.testData,
    );
    return DataResponse.fromJson(result.data);
  }
}
