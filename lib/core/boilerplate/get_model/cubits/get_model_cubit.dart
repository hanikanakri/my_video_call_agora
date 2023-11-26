import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../api/core_models/base_response_model.dart';
import '../../../api/core_models/base_result_model.dart';
import '../../../api/errors/net_error.dart';
import '/core/API/errors/base_error.dart';

part 'get_model_state.dart';

typedef RepositoryCallBack = Future<BaseResultModel> Function(dynamic data);

class GetModelCubit<Model> extends Cubit<GetModelState> {
  final RepositoryCallBack getData;
  GetModelCubit(this.getData) : super(GetModelInitial());

  getModel({Map<String, dynamic>? params}) async {
    emit(Loading());
    try {
      var response = await getData(params);
      debugPrint('responseeeeeeeeeeeee = ${(response)}');

      if (response is Model) {
        emit(GetModelSuccessfully(response));
      } else if (response is BaseError) {
        emit(Error((response as BaseError).message.toString()));
      } else if (response is ServerError) {
        emit(Error(response.message ?? ""));
      }else if (response is NetError) {
        emit(Error(response.message ?? ""));
      }
    } catch (e) {
      emit(Error(e.toString()));
    }
  }
}
