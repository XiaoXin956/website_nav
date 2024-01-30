import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website_nav/bean/type_bean.dart';
import 'package:website_nav/generated/l10n.dart';
import 'package:website_nav/pages/dialog/dialog_widgets.dart';
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
  int _expandedIndex = -1;
  bool loading = false;
  bool _isEdit = false;
  bool loadingError = false;
  List<TypeBean> typeData = [];
  LabelBloc? labelBloc;
  dynamic allMap = { "type": "all"};

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      labelBloc?.add(LabelTypeAllSearchEvent(data: allMap));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LabelBloc, LabelState>(
      builder: (BuildContext context, state) {
        labelBloc = context.read<LabelBloc>();
        if (state is LabelTypeInitialState) {
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
          context.read<LabelBloc>().add(LabelTypeInitialEvent());
        } else if (state is LabelTypeSuccessState) {
          labelBloc?.add(LabelTypeAllSearchEvent(data: allMap));
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
        } else if (state is LabelTypeParentFoldState) {
          // 编辑
          _expandedIndex = state.index;
          context.read<LabelBloc>().add(LabelTypeInitialEvent());
        } else if (state is LabelTypeEditState) {
          // 编辑
          _isEdit = !_isEdit;
          context.read<LabelBloc>().add(LabelTypeInitialEvent());
        }
        return Container(
          width: 200,
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
                        labelBloc?.add(LabelTypeAllSearchEvent(data: allMap));
                      },
                      child: Icon(
                        Icons.refresh,
                        size: 25,
                        color: Colors.blue,
                      ),
                    ),
                  InkWell(
                    onTap: () {
                      labelBloc?.add(LabelTypeEditEvent(edit: _isEdit));
                    },
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
      child: Column(
        children: [
          InkWell(
            onTap: () {
              labelBloc?.add(LabelTypeParentFoldEvent(index: index));
            },
            child: Row(
              // 父级菜单
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 5,),
                Icon(
                  Icons.account_balance_wallet_outlined,
                  size: 30,
                ),
                SizedBox(width: 5,),
                  Expanded(
                    child: Text(
                      "${typeBean.name}",
                      maxLines: 1,
                    ),
                    flex: 1,
                  ),
                Row(
                  children: [
                    if (_isEdit)
                      InkWell(
                        onTap: () {
                          showDialogEdit(
                              context: context,
                              typeBean: typeBean,
                              submit: (value) {
                                Navigator.pop(context);
                                labelBloc?.add(LabelTypeUpdateEvent(data: {"type": "parent", "id": typeBean.id, "name": value}));
                              });
                        },
                        child: Icon(
                          Icons.mode_edit_outline,
                          color: Colors.red,
                          size: 16,
                        ),
                      ),
                    SizedBox(
                      width: 5,
                    ),
                    if (_isEdit)
                      InkWell(
                        onTap: () {
                          //删除
                          showDialogConfirmCancel(
                            context: context,
                            title: Text("删除类型"),
                            leftWidget: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text("取消", style: TextStyle(fontSize: 16, color: Colors.black)),
                            ),
                            rightWidget: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                // 父级菜单
                                labelBloc?.add(LabelTypeDelEvent(data: {"id": typeBean.id, "type": "parent"}));
                              },
                              child: Text(
                                "确认",
                                style: TextStyle(fontSize: 16, color: Colors.red),
                              ),
                            ),
                            content: Text("是否删除父菜单，关联的子菜单会一起删除"),
                          );
                        },
                        child: Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: 16,
                        ),
                      )
                  ],
                ),
                SizedBox(
                  width: 6,
                ),
              ],
            ),
          ),
          // 二级菜单
          if (typeBean.childTypeData != null && _expandedIndex == index)
            Column(
              children: typeBean.childTypeData!.map((e) {
                return InkWell(
                  onTap: () {
                    widget.itemClick!(e);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.account_balance_wallet_outlined,
                        size: 26,
                      ),
                        Expanded(
                          child: Text(
                            "${e?.name}",
                            maxLines: 1,
                          ),
                          flex: 1,
                        ),
                      Row(
                        children: [
                          if (_isEdit)
                            InkWell(
                              onTap: () {
                                showDialogEdit(
                                    context: context,
                                    typeBean: e!,
                                    submit: (value) {
                                      Navigator.pop(context);
                                      labelBloc?.add(LabelTypeUpdateEvent(data: {
                                        "type": "child",
                                        "id": e.id,
                                        "name": value,
                                        "parent_id": e.parentId,
                                      }));
                                    });
                              },
                              child: Icon(
                                Icons.mode_edit_outline,
                                color: Colors.red,
                                size: 16,
                              ),
                            ),
                          SizedBox(
                            width: 5,
                          ),
                          if (_isEdit)
                            InkWell(
                              onTap: () {
                                showDialogConfirmCancel(
                                  context: context,
                                  title: Text("删除类型"),
                                  leftWidget: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("取消", style: TextStyle(fontSize: 16, color: Colors.black)),
                                  ),
                                  rightWidget: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                      // 父级菜单
                                      labelBloc?.add(LabelTypeDelEvent(data: {"id": e?.id, "type": "child"}));
                                    },
                                    child: Text(
                                      "确认",
                                      style: TextStyle(fontSize: 16, color: Colors.red),
                                    ),
                                  ),
                                  content: Text("是否删除子类型"),
                                );
                              },
                              child: Icon(
                                Icons.cancel,
                                color: Colors.grey,
                                size: 16,
                              ),
                            )
                        ],
                      ),
                      SizedBox(
                        width: 6,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
