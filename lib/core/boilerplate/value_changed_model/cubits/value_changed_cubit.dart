import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'value_changed_state.dart';

class ValueChangedCubit<Value> extends Cubit<ValueChangedState> {
  ValueChangedCubit({required this.value})
      : super(ValueChangedInitial<Value>(value: value));
  final Value value;
  changeValue(Value value) async {
    emit(const ValueChangedLoading());
    emit(GetValueSuccessfully<Value>(value: value));
  }
}
