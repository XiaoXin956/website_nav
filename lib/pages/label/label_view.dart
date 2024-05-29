import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website_nav/bean/type_bean.dart';
import 'package:website_nav/pages/label/label_cubit.dart';
import 'package:website_nav/utils/print_utils.dart';
import 'package:website_nav/widgets/custom_widget.dart';

import 'label_state.dart';

class LabelPage extends StatefulWidget {
  Function(dynamic)? itemClick;

  LabelPage({super.key, this.itemClick});

  @override
  State<LabelPage> createState() => _LabelPageState();
}

class _LabelPageState extends State<LabelPage> with SingleTickerProviderStateMixin {
  
  int indexExpand = -1; // 展开的数据
  
  bool loading = false;
  bool loadingError = false;
  List<TypeLabelBean> typeData = [];
  List<TypeLabelBean> fixedData = [
    TypeLabelBean(id: -1, name: "关于我们"),
    TypeLabelBean(id: -2, name: "留言板"),
  ];

  LabelCubit? labelCubit;
  dynamic allMap = {"type": "search"};

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
        } else if (state is LabelExpandState) {
          indexExpand = state.index;
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
                              // 对应的标签展开
                              labelCubit?.reqExpandData(index: index);
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
              h(10),
            ],
          ),
        );
      },
    );
  }

  Widget menuItem({required int index, required TypeLabelBean typeBean}) {
    return Container(
      child: Column(
        children: [
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(),
            title: Row(
            // 父级菜单
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              w(5),
              Icon(
                Icons.account_balance_wallet_outlined,
                size: 30,
              ),
              w(5),
              Expanded(
                child: textWidget(
                    text: "${typeBean.name}",
                    maxLines: 1,
                    textStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    )),
                flex: 1,
              ),
            ],
          ),
            children: typeBean.parent!.map((e){
              return Padding(
                padding:  EdgeInsets.only(left: 20,top: 5,bottom: 5),
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
                      child: textWidget(
                          text: "${e.name}",
                          maxLines: 1,
                          textStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          )),
                      flex: 1,
                    ),
                  ],
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
