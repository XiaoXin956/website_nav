import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website_nav/bean/type_bean.dart';
import 'package:website_nav/pages/label/label_cubit.dart';
import 'package:website_nav/utils/print_utils.dart';

import 'label_state.dart';

class LabelPage extends StatefulWidget {
  Function(dynamic)? itemClick;

  LabelPage({super.key, this.itemClick});

  @override
  State<LabelPage> createState() => _LabelPageState();
}

class _LabelPageState extends State<LabelPage> with SingleTickerProviderStateMixin {
  bool loading = false;
  bool loadingError = false;
  List<TypeBean> typeData = [];

  // LabelBloc? labelBloc;
  LabelCubit? labelCubit;
  dynamic allMap = {"type": "all"};

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      labelCubit?.searchAllType(allMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LabelCubit, LabelState>(
      builder: (BuildContext context, state) {
        labelCubit = context.read<LabelCubit>();
        if (state is LabelInitial) {
          // 加载中
          printBlue("恢復");
        } else if (state is LabelTypeLoadingState) {
          // 加载中
          loading = true;
          loadingError = false;
        } else if (state is LabelTypeSearchSuccessState) {
          // 查询成功，显示
          typeData.clear();
          typeData.addAll(state.typeData);
          loading = false;
          loadingError = false;
        } else if (state is LabelTypeSuccessState) {
          // 操作成功
          loadingError = true;
          loading = false;
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msgSuccess)));
          });
        } else if (state is LabelTypeFailState) {
          // 操作失败
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msgFail)));
          });
          loadingError = true;
          loading = false;
        }
        return Container(
          width: 200.0,
          child: Column(
            children: [
              (loading)
                  ? Expanded(
                      child: Row(
                      children: [Expanded(child: SizedBox()), CircularProgressIndicator(), Expanded(child: SizedBox())],
                    ))
                  : Expanded(
                      flex: 1,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: typeData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              widget.itemClick!(typeData[index]);
                            },
                            child: menuItem(index: index, typeBean: typeData[index]),
                          );
                        },
                      )),
              if (loadingError)
                TextButton(
                  onPressed: () {
                    context.read<LabelCubit>().searchAllType(allMap);
                  },
                  child: Text('重新加载'),
                ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget menuItem({required int index, required TypeBean typeBean}) {
    return Container(
      padding: const EdgeInsets.only(top: 6, bottom: 6),
      child: Row(
        // 父级菜单
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 5,
          ),
          Icon(
            Icons.account_balance_wallet_outlined,
            size: 30,
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(
              "${typeBean.name}",
              maxLines: 1,
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
}
