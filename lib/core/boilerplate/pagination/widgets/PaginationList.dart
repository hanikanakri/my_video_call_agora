
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../animations/fade_animation.dart';
import '../../../widgets/errors/empty_data_widget.dart';
import '../../../widgets/loading.dart';
import '../../../widgets/loading_footer.dart';
import '../../../widgets/errors/connection_error_widget.dart';
import '../cubits/pagination_cubit.dart';

typedef CreatedCallback = void Function(PaginationCubit cubit);

typedef ListBuilder<Model> = Widget Function(List<Model> list);
//typedef AsyncWidgetBuilder<T> = Widget Function(BuildContext context, AsyncSnapshot<T> snapshot);

class PaginationList<Model> extends StatefulWidget {
  final RepositoryCallBack? repositoryCallBack;
  final ListBuilder<Model>? listBuilder;
  final CreatedCallback? onCubitCreated;
  final bool? withPagination;
  final bool? withLoading;
  final Widget? childEmptyWidget;

  const PaginationList(
      {Key? key,
      this.repositoryCallBack,
      this.listBuilder,
      this.withPagination = false,
      this.onCubitCreated,
      this.childEmptyWidget = const EmptyDataWidget(), this.withLoading=true})
      : super(key: key);

  @override
  _PaginationListState<Model> createState() => _PaginationListState<Model>();
}

class _PaginationListState<Model> extends State<PaginationList<Model>> {
  final RefreshController _refreshController = RefreshController();
  PaginationCubit<Model>? cubit;

  @override
  void initState() {
    cubit = PaginationCubit<Model>(widget.repositoryCallBack!);
    if (widget.onCubitCreated != null) {
      widget.onCubitCreated!(cubit!);
    }
    cubit!.getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildConsumer();
  }

  _buildConsumer() {
    return BlocConsumer<PaginationCubit<Model>, PaginationState>(
        bloc: cubit,
        listener: (context, state) {
          if (state is Error) {
            // ScaffoldMessenger.of(context).showSnackBar(snackBar(state.message));
          } else if (state is GetListSuccessfully) {
            _refreshController.refreshCompleted();
            if (state.noMoreData!) {
              _refreshController.loadNoData();
            } else {
              _refreshController.loadComplete();
            }
          }
        },
        builder: (context, state) {
          print('fromPatientList builder');
          print(state);
          if (state is Loading) {
            return  widget.withLoading! ?const LoadingWidget():Container();
          } else if (state is GetListSuccessfully) {
            return smartRefresher(state.list as List<Model>);
          } else if (state is Error) {
            return ConnectionErrorWidget(
              message: state.message,
              onTap: () {
                cubit!.getList();
              },
            );
          } else {
            return Container();
          }
        });
  }

  smartRefresher(List<Model> list) {
    Widget? child;
    if (list.isEmpty) {
      child = widget.childEmptyWidget;
    } else {
      child = widget.listBuilder!(list);
    }

    return FadeAnimation(
      fadeDirection: FadeDirection.bottom,
      child: Scrollbar(
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: const MaterialClassicHeader(),
          controller: _refreshController,
          onRefresh: () async {
            cubit!.getList();
          },
          onLoading: () async {
            cubit!.getList(loadMore: true);
          },
          footer: customFooter,
          child: child,
        ),
      ),
    );
  }
}
