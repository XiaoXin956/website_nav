import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website_nav/bean/type_bean.dart';
import 'package:website_nav/generated/l10n.dart';
import 'package:website_nav/pages/dialog/dialog_widgets.dart';
import 'package:website_nav/pages/knowledge_edit/knowledge_event.dart';
import 'package:website_nav/pages/label/label_bloc.dart';
import 'package:website_nav/pages/label/label_event.dart';
import 'package:website_nav/utils/print_utils.dart';
import 'package:website_nav/widgets/fixed_size_grid_delegate.dart';

import 'knowledge_bloc.dart';
import 'knowledge_state.dart';

// 编辑页面
class KnowledgePage extends StatefulWidget {
  const KnowledgePage({super.key});

  @override
  State<KnowledgePage> createState() => _KnowledgePageState();
}

class _KnowledgePageState extends State<KnowledgePage> {
  KnowledgeBloc? knowledgeBloc;
  TypeBean? selectChildValue;

  String oneMenuName = "";
  String twoMenuName = "";

  List<TypeBean> typeChildData = [];

  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _urlEditingController = TextEditingController();
  TextEditingController _labelEditingController = TextEditingController();
  TextEditingController _describeEditingController = TextEditingController();

  bool _edit = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      knowledgeBloc?.add(LabelSearchEvent(data: {"type": "child"}));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => KnowledgeBloc(),
      child: BlocBuilder<KnowledgeBloc, KnowledgeState>(
        builder: (BuildContext context, state) {
          knowledgeBloc = context.read<KnowledgeBloc>();
          if (state is KnowledgeInitState) {
            // 初始化
            // _textEditingController.text = "";
            // _urlEditingController.text = "";
            // _labelEditingController.text = "";
            // _describeEditingController.text = "";
          } else if (state is LabelTypeSelectChildState) {
            selectChildValue = state.typeBean;
          } else if (state is LabelTypeFailState) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msgFail)));
            });
          } else if (state is LabelTypeSearchSuccessState) {
            context.read<LabelBloc>().add(LabelTypeAllSearchEvent(data: {"type": "all"}));
            // 获取成功
            typeChildData.clear();
            typeChildData.addAll(state.typeData);
          } else if (state is LabelTypeAddSuccessState) {
            //  添加成功
            // 一级刷新数据
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msgSuccess)));
            });
            // 获取成功
            knowledgeBloc?.add(LabelSearchEvent(data: {"type": "child"}));
          } else if (state is KnowledgeAddSuccessState) {
            knowledgeBloc?.add(KnowledgeInitEvent());
            // 资源添加成功
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msgSuccess)));
            });
          } else if (state is KnowledgeFailState) {
            // 资源添加成功
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msgFail)));
            });
          }else if (state is KnowledgeEditTypeState) {
            // 编辑类型
            _edit = !_edit;

            knowledgeBloc?.add(KnowledgeInitEvent());
          }else if (state is KnowledgeSuccessState) {

            knowledgeBloc?.add(LabelSearchEvent(data: {"type": "child"}));
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msgSuccess)));
            });
          }
          return _buildPage(context);
        },
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              // 上方显示类型，
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          height: 200,
                          alignment: Alignment.topCenter,
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Expanded(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: Row(
                                    children: [
                                      Text("  ${S.of(context).menu}  "),
                                      Expanded(
                                          child: Container(
                                        padding: EdgeInsets.only(right: 10),
                                        child: TextField(
                                          textAlign: TextAlign.start,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2)),
                                          ),
                                          onChanged: (value) {
                                            twoMenuName = value;
                                          },
                                        ),
                                      ))
                                    ],
                                  )),
                                ],
                              )),
                              SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    knowledgeBloc?.add(LabelTypeAddEvent(data: {
                                      "type": "child",
                                      "name": twoMenuName,
                                    }));
                                  },
                                  child: Text("新增菜单")),
                            ],
                          ),
                        )),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 200,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Text("${S.of(context).type}"),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          // 进行编辑操作
                                          knowledgeBloc?.add(KnowledgeEditTypeEvent());
                                        },
                                        child: Text(
                                          (_edit)?"${S.of(context).complete}":"${S.of(context).edit}",
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                // 表格列表选中
                                Expanded(
                                    child: GridView.builder(
                                  gridDelegate: FixedSizeGridDelegate(100, 50, mainAxisSpacing: 10),
                                  itemCount: typeChildData.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    TypeBean selectValueTemp = typeChildData[index];
                                    return Stack(
                                      children: [
                                        Container(
                                          width: double.maxFinite,
                                          height: double.maxFinite,
                                          child: GestureDetector(
                                            onTap: () {
                                              knowledgeBloc?.add(LabelTypeSelectChildEvent(typeBean: typeChildData[index]));
                                            },
                                            child: Container(
                                              height: 60,
                                              width: 60,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: (selectChildValue != null && selectChildValue!.id == selectValueTemp.id) ? Colors.blue : Colors.white,
                                                  border: Border.all(
                                                      color: (selectChildValue != null && selectChildValue!.id == selectValueTemp.id) ? Colors.white : Colors.grey, width: 1)),
                                              margin: EdgeInsets.all(2),
                                              child: Row(
                                                children: [
                                                  // 图标
                                                  Icon(
                                                    Icons.account_balance_rounded,
                                                    size: 20,
                                                  ),
                                                  // 文本
                                                  Expanded(
                                                      child: Text(
                                                    "${typeChildData[index].name}",
                                                    style: TextStyle(color: (selectChildValue != null && selectChildValue!.id == selectValueTemp.id) ? Colors.white : Colors.black),
                                                  )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        if(_edit)
                                          Positioned(
                                              right: 0,
                                              top: 0,
                                              child: GestureDetector(
                                                onTap: (){
                                                  knowledgeBloc?.add(KnowledgeDelTypeEvent(data: {"id":selectValueTemp.id}));
                                                },
                                                child: Icon(
                                                Icons.cancel_outlined,
                                                color: Colors.red,
                                                size: 20,
                                              ),)),
                                      ],
                                    );
                                  },
                                )),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 10,
              ),
              // 下方内容
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        // 标题
                        Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Text('标题：'),
                                Expanded(
                                    child: TextField(
                                  controller: _textEditingController,
                                  textAlign: TextAlign.start,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2))),
                                  onChanged: (value) {
                                    _textEditingController.text = value;

                                    _textEditingController.selection =
                                        TextSelection(baseOffset: _textEditingController.text.length, extentOffset: _textEditingController.text.length);
                                  },
                                )),
                              ],
                            )),
                        const SizedBox(
                          width: 50,
                        ),
                        Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Text('链接：'),
                                Expanded(
                                    child: TextField(
                                  controller: _urlEditingController,
                                  textAlign: TextAlign.start,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2))),
                                  onChanged: (value) {
                                    _urlEditingController.text = value;
                                    _urlEditingController.selection = TextSelection(baseOffset: _urlEditingController.text.length, extentOffset: _urlEditingController.text.length);
                                  },
                                )),
                              ],
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        // 标签
                        Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Text('标签：'),
                                Expanded(
                                    child: TextField(
                                  controller: _labelEditingController,
                                  textAlign: TextAlign.start,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2))),
                                  onChanged: (value) {
                                    _labelEditingController.text = value;
                                    _labelEditingController.selection =
                                        TextSelection(baseOffset: _labelEditingController.text.length, extentOffset: _labelEditingController.text.length);
                                  },
                                )),
                              ],
                            )),
                        const SizedBox(
                          width: 50,
                        ),
                        Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Text('描述：'),
                                Expanded(
                                    child: TextField(
                                  controller: _describeEditingController,
                                  textAlign: TextAlign.start,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2))),
                                  onChanged: (value) {
                                    _describeEditingController.text = value;
                                    _describeEditingController.selection =
                                        TextSelection(baseOffset: _describeEditingController.text.length, extentOffset: _describeEditingController.text.length);
                                  },
                                )),
                              ],
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          knowledgeBloc?.add(KnowledgeAddDataEvent(map: {
                            "type": "add",
                            "text": "${_textEditingController.text}",
                            "url": "${_urlEditingController.text}",
                            "label": "${_labelEditingController.text}",
                            "type_id": selectChildValue?.id,
                            "describe": "${selectChildValue?.id}",
                          }));
                        },
                        child: Text("添加")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
