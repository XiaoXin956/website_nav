import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website_nav/bean/type_bean.dart';
import 'package:website_nav/generated/l10n.dart';
import 'package:website_nav/pages/dialog/dialog_widgets.dart';
import 'package:website_nav/pages/home/home_bloc.dart';
import 'package:website_nav/pages/home/home_event.dart';
import 'package:website_nav/pages/knowledge_edit/knowledge_event.dart';
import 'package:website_nav/pages/label/label_cubit.dart';
import 'package:website_nav/utils/print_utils.dart';

import 'label_bloc.dart';
import 'label_event.dart';
import 'label_state.dart';

class LabelPage extends StatefulWidget {
  Function(dynamic)? itemClick;

  LabelPage({super.key, this.itemClick});

  @override
  State<LabelPage> createState() => _LabelPageState();
}

class _LabelPageState extends State<LabelPage> with SingleTickerProviderStateMixin {
  double minValue = (kIsWeb) ? 120 : 60.0;
  double maxValue = (kIsWeb) ? 230 : 150.0;
  bool _isExpanded = true;
  bool loading = false;
  bool _isEdit = false;
  bool loadingError = false;
  List<TypeBean> typeData = [];

  // LabelBloc? labelBloc;
  LabelCubit? labelCubit;
  dynamic allMap = {"type": "all"};

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // labelBloc?.add(LabelTypeAllSearchEvent(data: allMap));
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
          typeData.clear();
          typeData.addAll(state.typeData);
          loading = false;
          loadingError = false;
        } else if (state is LabelTypeSuccessState) {
          // labelBloc?.add(LabelTypeAllSearchEvent(data: allMap));
          loadingError = true;
          loading = false;
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msgSuccess)));
          });
        } else if (state is LabelTypeFailState) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msgFail)));
          });
          loadingError = true;
          loading = false;
        } else if (state is LabelSelectIndexState) {
          _selectedIndex = state.index;
        } else if (state is LabelZoomState) {
          _isExpanded = !_isExpanded;
          labelCubit?.init();
        }
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: _isExpanded ? 300.0 : 56.0,
          child: Drawer(
            width: _isExpanded ? maxValue : minValue,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    labelCubit?.zoom();
                  },
                  child: _isExpanded ? Icon(Icons.arrow_back) : Icon(Icons.menu),
                ),
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
                    child: Text('重新加載'),
                  ),
              ],
            ),
          ),
        );
        return Container(
          height: double.maxFinite,
          color: Colors.white,
          child: Column(
            children: [
              if (loadingError)
                TextButton(
                  onPressed: () {
                    context.read<LabelBloc>().add(LabelTypeAllSearchEvent(data: allMap));
                  },
                  child: Text('重新加載'),
                ),
              Expanded(
                  child: Row(
                children: [
                  (loading)
                      ? Expanded(
                          child: Row(
                          children: [Expanded(child: SizedBox()), CircularProgressIndicator(), Expanded(child: SizedBox())],
                        ))
                      : Expanded(
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
                ],
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (!loading)
                    InkWell(
                      onTap: () {
                        // labelBloc?.add(LabelTypeAllSearchEvent(data: allMap));
                      },
                      child: Icon(
                        Icons.refresh,
                        size: 25,
                        color: Colors.blue,
                      ),
                    ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      (_isEdit) ? S.of(context).complete : S.of(context).edit,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              )
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
          if (_isExpanded)
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
