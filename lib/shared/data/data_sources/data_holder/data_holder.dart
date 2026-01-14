import '../../../../../shared/data/models/data_response.dart';
import '../../../../features/cats/data/models/cat_model.dart';
import '../../models/result_model.dart';

///Data Holder (Cache)
///  [DataHolder] acts as a cache to store data and ensure it's only fetched once.


abstract class DataHolder {
  List<CatModel>? getCats();
  ResultModel? getResultModel();
  bool get isDataFetched;
  void setData(DataResponse data);
}

class DataHolderImpl implements DataHolder {
  List<CatModel>? _cats;
  ResultModel? _resultModel;
  bool _isDataFetched = false;

  @override
  List<CatModel>? getCats() => _cats;

  @override
  ResultModel? getResultModel() => _resultModel;

  @override
  bool get isDataFetched => _isDataFetched;

  @override
  void setData(DataResponse data) {
    _cats = data.result?.cats;
    _resultModel = data.result;
    _isDataFetched = true;
  }
}
