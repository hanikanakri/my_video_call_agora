part of 'value_changed_cubit.dart';

@immutable
abstract class ValueChangedState<Value> {
  final Value? value;

  const ValueChangedState({this.value});
}

class ValueChangedInitial<Value> extends ValueChangedState {
  const ValueChangedInitial({required super.value});
}

class ValueChangedLoading extends ValueChangedState {
  const ValueChangedLoading();
}

class GetValueSuccessfully<Value> extends ValueChangedState {
  const GetValueSuccessfully({required super.value});
}
