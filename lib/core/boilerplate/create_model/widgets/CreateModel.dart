
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubits/create_model_cubit.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:easy_localization/easy_localization.dart';
typedef CreatedCallback = void Function( CreateModelCubit cubit);
typedef ModelCreated<Model>  =   Function (Model model);

class CreateModel<Model> extends StatefulWidget {

  final ModelCreated<Model> onSuccess;

  final RepositoryCallBack repositoryCallBack;
  final CreatedCallback onCubitCreated;
  final Widget child;
  final bool?withSuccessMessage;


  const CreateModel({Key? key,
    required this.repositoryCallBack,
    required this.onCubitCreated,
    required this.child,
    required this.onSuccess ,this.withSuccessMessage=true}) : super(key: key);

  @override
  State<CreateModel<Model>> createState() => _GetModelState<Model>();
}

class _GetModelState<Model> extends State<CreateModel<Model>> {

  CreateModelCubit<Model>? cubit ;

  @override
  void initState() {
    cubit = CreateModelCubit<Model>(widget.repositoryCallBack);
      widget.onCubitCreated(cubit!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateModelCubit,CreateModelState>(
      bloc:  cubit,
      builder: (context, state) {
        print('fromPatientList builder');
        print(state);
        if(state is CreateModelInitial) {
          return widget.child;
        }  else if(state is CreateModelSuccessfully ){
          return widget.child ;
        }
        else {
          return  widget.child;
        }
      },
      listener: (context, state) {
        if (state is CreateModelSuccessfully) {
          widget.onSuccess(state.model);
          EasyLoading.dismiss();
          if(widget.withSuccessMessage==true)
          {
            EasyLoading.showSuccess('success'.tr());

          }
        } else if (state is Loading) {
          if(widget.withSuccessMessage==true){
            EasyLoading.show(status: 'loading'.tr(),);
          }
        }
        if (state is Error) {
          EasyLoading.showError(state.message.toString());
        }
      },
    );
  }

}
