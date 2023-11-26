import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/value_changed_cubit.dart';

typedef CreatedCallback = void Function(ValueChangedCubit cubit);
typedef ValueBuilder<Value> = Widget Function(Value value);
typedef ValueReceived<Value> = void Function(Value value);

class ValueChangedModel<Value> extends StatefulWidget {
  final CreatedCallback? onCubitCreated;
  final ValueBuilder<Value> builder;
  final Widget Function()? emptyBuilder;

  final Widget loadingWidget;
  final ValueReceived<Value>? onValueChanged;
  final bool fromProvider;
  final Value? initialValue;

  const ValueChangedModel({
    Key? key,
    this.initialValue,
    this.onCubitCreated,
    required this.builder,
    this.loadingWidget = const CircularProgressIndicator(),
    this.onValueChanged,
    this.emptyBuilder,
    this.fromProvider = true,
  }) : super(key: key);

  @override
  State<ValueChangedModel<Value>> createState() =>
      _ValueChangedModelState<Value>();
}

class _ValueChangedModelState<Value> extends State<ValueChangedModel<Value>> {
  late ValueChangedCubit<Value?> cubit;

  @override
  void initState() {
    if (widget.fromProvider) {
      cubit = context.read<ValueChangedCubit<Value>>();
    } else if (widget.initialValue != null) {
      cubit = ValueChangedCubit<Value>(value: widget.initialValue as Value);
    }
    if (widget.onCubitCreated != null) widget.onCubitCreated!(cubit);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ValueChangedCubit, ValueChangedState>(
      listener: (context, state) {
        if (state is GetValueSuccessfully<Value> &&
            widget.onValueChanged != null) {
          widget.onValueChanged!(state.value);
        }
      },
      bloc: cubit,
      builder: (context, state) {
        if (state is ValueChangedLoading) {
          return widget.loadingWidget;
        }
        return widget.builder(state.value);
      },
    );
  }
}
