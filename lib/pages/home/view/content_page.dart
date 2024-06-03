import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website_nav/bean/knowledge_bean.dart';
import 'package:website_nav/bean/type_bean.dart';
import 'package:website_nav/pages/home/bloc/click_cubit.dart';
import 'package:website_nav/pages/knowledge_edit/knowledge_cubit.dart';
import 'package:website_nav/pages/knowledge_edit/knowledge_state.dart';
import 'package:website_nav/widgets/custom_widget.dart';
import 'dart:html' as html;

class ContentPage extends StatefulWidget {
  const ContentPage({super.key});

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  List<KnowResult> knowResult = [];
  KnowledgeCubit? knowledgeCubit;
  ScrollController scrollController = ScrollController();
  // List<GlobalKey> itemKeys = [];
  bool _edit = false;

  Map<int, int> _selectMap = {};

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClickCubit, ClickState>(
      builder: (BuildContext context, state) {
        if (state is ClickInitial) {
          // 什么都不做
        } else if (state is ClickMoveToPositionState) {
          // 查询成功，显示
          print("滑动  ${state.typeBean}");
          context.read<ClickCubit>().clickInitial();
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            checkPosition(state.typeBean);
          });
        }
        return BlocBuilder<KnowledgeCubit, KnowledgeState>(
          builder: (BuildContext context, state) {
            knowledgeCubit = context.read<KnowledgeCubit>();
            if (state is KnowledgeSearchDataState) {
              // 查询成功，显示
              knowResult = state.knowData ?? [];
              // _selectMap[knowResult[0].typeParent?.id?? 0]=0;
              // itemKeys.clear();
              // itemKeys = List.generate(knowData.length, (index) => GlobalKey());
            } else if (state is KnowledgeFailState) {
            } else if (state is KnowledgeEditTypeState) {
            } else if (state is KnowledgeSuccessState) {
              knowledgeCubit?.reqSearchAllKnowledgeData(data: {"type": "search"});
            }
            return _buildUI();
          },
        );
      },
    );
  }

  Widget _buildUI() {
    return Container(
      color: Color(0xffF9F9F9),
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        controller: scrollController,
        padding: EdgeInsets.zero,
        itemCount: knowResult.length,
        itemBuilder: (BuildContext context, int index) {
          KnowResult data = knowResult[index];
          return Column(
            // key: itemKeys[index],
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
                child: Text(
                  '${data.typeParent?.name}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: data.childData!.asMap().entries.map((e) {
                    return GestureDetector(
                      onTap: () {
                        _selectMap[data.typeParent?.id ?? 0] = e.key;
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          color: (_selectMap[data.typeParent?.id ?? 0] == e.key) ? Color(0xff5961F9) : Color(0xffE0E0E0),
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        child: textWidget(
                            text: e.value.typeChild!.name.toString(),
                            textStyle: TextStyle(
                              color: (_selectMap[data.typeParent?.id ?? 0] == e.key) ? Colors.white : Colors.grey,
                            )),
                      ),
                    );
                  }).toList()),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width ~/ 250,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 2.5,

                ),
                itemCount: data.childData?[_selectMap[data.typeParent?.id ?? 0] ?? 0].result?.length,
                itemBuilder: (BuildContext context, int index) {
                  var knowledgeBean = data.childData?[_selectMap[data.typeParent?.id ?? 0] ?? 0].result?[index];
                  String? title = knowledgeBean?.title.toString();
                  String? imageUrl = knowledgeBean?.imgUrl.toString();
                  String? info = knowledgeBean?.info.toString();
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          w(5),
                          Image.network(
                            imageUrl.toString(),
                            width: 50,
                            height: 50,
                          ),
                          w(5),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              textWidget(text: "${title}", textStyle: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold), maxLines: 1),
                              textWidget(text: "${info}", textStyle: TextStyle(fontSize: 12, color: Colors.grey), maxLines: 1),
                            ],
                          )),
                        ],
                      ),
                    ),
                  );

                  // return GridView.builder(
                  //   physics: NeverScrollableScrollPhysics(),
                  //   shrinkWrap: true,
                  //   gridDelegate: FixedSizeGridDelegate(150, 60, mainAxisSpacing: 10),
                  //   itemCount: data.childData?.length,
                  //   itemBuilder: (BuildContext context, int index) {
                  //     KnowledgeBean knowledgeBean = data['know_data'][index];
                  //     return Container(
                  //       child: Stack(
                  //         children: [
                  //           GestureDetector(
                  //             onTap: () {
                  //               // 跳转
                  //               if(kIsWeb){
                  //                 String url = "http://${html.window.location.host}/feedback";
                  //                 html.window.open(knowledgeBean.url.toString(),"_blank");
                  //               }else{
                  //
                  //               }
                  //             },
                  //             child: Container(
                  //               height: 60,
                  //               decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white, border: Border.all(color: Colors.grey, width: 1)),
                  //               margin: EdgeInsets.all(2),
                  //               child: Row(
                  //                 children: [
                  //                   // 图标
                  //                   Container(
                  //                     width: 40,
                  //                     height: 40,
                  //                     margin: EdgeInsets.only(left: 5, right: 5),
                  //                     child: (knowledgeBean.imgUrl != null)?
                  //                     Image.network(knowledgeBean.imgUrl.toString()):
                  //                     Icon(
                  //                       Icons.account_balance_rounded,
                  //                       size: 20,
                  //                     ),
                  //                   ),
                  //
                  //                   // 文本
                  //                   Expanded(
                  //                       child: Text(
                  //                         "${knowledgeBean.title}",
                  //                         style: TextStyle(color: Colors.black),
                  //                       )),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //           Positioned(
                  //               right: 5,
                  //               top: 5,
                  //               child: Row(
                  //                 children: [
                  //                   GestureDetector(
                  //                     onTap: () {},
                  //                     child: Icon(
                  //                       Icons.edit_note,
                  //                       size: 20,
                  //                       color: Colors.blue,
                  //                     ),
                  //                   ),
                  //                   GestureDetector(
                  //                     onTap: () {
                  //                       // 删除
                  //                       knowledgeCubit?.reqDelKnowledgeData(data: {"id": knowledgeBean.id,"type":"remove"});
                  //                     },
                  //                     child: Icon(
                  //                       Icons.remove_circle,
                  //                       size: 20,
                  //                       color: Colors.red,
                  //                     ),
                  //                   ),
                  //                 ],
                  //               )),
                  //         ],
                  //       ),
                  //     );
                  //   },
                  // );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  checkPosition(TypeLabelBean typeBean) {
    // var indexWhere = knowData.indexWhere((element) {
    //   return element['type_bean'].id == typeBean.id;
    // });
    // double height = 0;
    // for (var i = 0; i < indexWhere; i++) {
    //   RenderBox itemBox = itemKeys[i].currentContext!.findRenderObject() as RenderBox;
    //   double itemPosition = itemBox.size.height;
    //   height = height + itemPosition;
    // }
    // scrollController.animateTo(
    //   height,
    //   duration: Duration(milliseconds: 500),
    //   curve: Curves.easeInOut,
    // );
  }
}
