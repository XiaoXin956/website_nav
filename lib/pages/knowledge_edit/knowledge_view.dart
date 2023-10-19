import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website_nav/bean/type_bean.dart';
import 'package:website_nav/pages/dialog/dialog_widgets.dart';
import 'package:website_nav/pages/knowledge_edit/knowledge_event.dart';
import 'package:website_nav/utils/print_utils.dart';

import 'knowledge_bloc.dart';
import 'knowledge_state.dart';

// 编辑页面
class KnowledgePage extends StatelessWidget {

  KnowledgeBloc? knowledgeBloc;
  TypeBean? selectParentValue;
  String oneMenuName = "";
  String twoMenuName = "";

  List<TypeBean> typeParentData = [];

  List<TypeBean> typeChildData = [ ];

  GlobalKey parentKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KnowledgeBloc,KnowledgeState>(builder: (BuildContext context, state) {

      knowledgeBloc = context.read<KnowledgeBloc>();
      if (state is LabelTypeSelectState) {
        selectParentValue = state.typeBean;
      } else if (state is LabelTypeFailState) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msgFail)));
        });
        // 刷新数据
        // labelBloc?.add(LabelParentSearchEvent(data: {"type":"parent"}));
      } else if (state is LabelTypeSearchSuccessState) {
        // 获取成功
        if(state.type=="parent"){
          typeParentData.clear();
          typeParentData.addAll(state.typeData);
        }else{
          typeChildData.clear();
          typeChildData.addAll(state.typeData);
        }

      }else if (state is LabelTypeAddSuccessState) { //  添加成功
        // 一级刷新数据
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msgSuccess)));
        });
        // 获取成功
        if(state.type=="parent"){
          knowledgeBloc?.add(LabelSearchEvent(data: {"type":"parent"}));
        }else{
          knowledgeBloc?.add(LabelSearchEvent(data: {"type":"child"}));
        }

      }

      return _buildPage(context);
    },);
  }

  Widget _buildPage(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // 上方显示添加类型，
            Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
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
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(child: Text("一级菜单")),
                              Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2))),
                                  onChanged: (value) {
                                    oneMenuName = value;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    knowledgeBloc?.add(LabelTypeAddEvent(data: {"type": "parent", "name": oneMenuName}));
                                  },
                                  child: Text("新增一级菜单")),
                            ],
                          )),
                      Expanded(
                          flex: 2,
                          child: Container(
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
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: Row(
                                          children: [
                                            Text("一级菜单  "),
                                            Expanded(
                                                flex: 2,
                                                child: Container(
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.black, width: 1)),
                                                  padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                                                  child: InkWell(
                                                    key: parentKey,
                                                    onTap: () {
                                                      RenderObject? boundary = parentKey.currentContext!.findRenderObject();
                                                      Rect rect = boundary!.paintBounds;
                                                      printBlue("${rect.top}  ${rect.bottom}  ${rect.left}  ${rect.right}");
                                                      showTypeSelect(
                                                          context: context,
                                                          rect: rect,
                                                          typeData: typeParentData,
                                                          selectData: (value) {
                                                            knowledgeBloc?.add(LabelTypeSelectEvent(typeBean: value));
                                                          });
                                                    },
                                                    child: (selectParentValue == null) ? Text("请选择") : Text("${selectParentValue?.name.toString()}"),
                                                  ),
                                                ))
                                          ],
                                        )),
                                    Expanded(
                                        flex: 2,
                                        child: Row(
                                          children: [
                                            Text("  二级菜单  "),
                                            Expanded(
                                                flex: 2,
                                                child: Container(
                                                  padding: EdgeInsets.only(left: 10, right: 10),
                                                  child: TextField(
                                                    textAlign: TextAlign.center,
                                                    decoration: InputDecoration(
                                                        border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2))),
                                                    onChanged: (value){
                                                      twoMenuName = value;
                                                    },
                                                  ),
                                                ))
                                          ],
                                        )),
                                    ElevatedButton(
                                        onPressed: () {
                                          knowledgeBloc?.add(LabelTypeAddEvent(data: {"type": "child", "name": twoMenuName,"parent_id":selectParentValue?.id}));
                                        },
                                        child: Text("新增二级菜单")),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                Container(
                  height: 150,
                  margin: EdgeInsets.only(left: 20, right: 20),
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
                        child: Text("类型"),
                      ),
                      // 表格列表选中
                      Expanded(
                          child: GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 10, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: (itemWidth / itemHeight)),
                            itemCount: typeChildData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: 60,
                                width: 60,
                                color: Colors.lightBlueAccent,
                                margin: EdgeInsets.all(2),
                                child: Row(
                                  children: [
                                    // 图标
                                    Icon(
                                      Icons.account_balance_rounded,
                                      size: 20,
                                    ),
                                    // 文本
                                    Text("${typeChildData[index].name}"),
                                  ],
                                ),
                              );
                            },
                          )),
                    ],
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );

  }
}
