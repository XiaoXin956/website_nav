import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website_nav/bean/knowledge_bean.dart';
import 'package:website_nav/bean/type_bean.dart';
import 'package:website_nav/pages/home/bloc/click_cubit.dart';
import 'package:website_nav/pages/knowledge_edit/knowledge_cubit.dart';
import 'package:website_nav/pages/knowledge_edit/knowledge_state.dart';
import 'package:website_nav/widgets/fixed_size_grid_delegate.dart';
import 'dart:html' as html;

class ContentPage extends StatefulWidget {

  const ContentPage({super.key});

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  List<dynamic> knowData = [];

  KnowledgeCubit? knowledgeCubit;

  ScrollController scrollController = ScrollController();

  List<GlobalKey> itemKeys = [];

  bool _edit = false;

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
              knowData = state.knowData;
              itemKeys.clear();
              itemKeys = List.generate(knowData.length, (index) => GlobalKey());
            }else if(state is KnowledgeFailState){

            }else if(state is KnowledgeEditTypeState){

            }else if(state is KnowledgeSuccessState){
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
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        controller: scrollController,
        padding: EdgeInsets.zero,
        itemCount: knowData.length,
        itemBuilder: (BuildContext context, int index) {
          dynamic data = knowData[index];
          return Column(
            key: itemKeys[index],
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
                child: Text(
                  '${data['type_bean'].name}',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: FixedSizeGridDelegate(150, 60, mainAxisSpacing: 10),
                itemCount: data['know_data'].length,
                itemBuilder: (BuildContext context, int index) {
                  KnowledgeBean knowledgeBean = data['know_data'][index];
                  return Container(
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // 跳转
                            if(kIsWeb){
                              String url = "http://${html.window.location.host}/feedback";
                              html.window.open(knowledgeBean.url.toString(),"_blank");
                            }else{

                            }
                          },
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white, border: Border.all(color: Colors.grey, width: 1)),
                            margin: EdgeInsets.all(2),
                            child: Row(
                              children: [
                                // 图标
                                Container(
                                  width: 40,
                                  height: 40,
                                  margin: EdgeInsets.only(left: 5, right: 5),
                                  child: (knowledgeBean.imgUrl != null)?
                                  Image.network(knowledgeBean.imgUrl.toString()):
                                  Icon(
                                    Icons.account_balance_rounded,
                                    size: 20,
                                  ),
                                ),

                                // 文本
                                Expanded(
                                    child: Text(
                                      "${knowledgeBean.title}",
                                      style: TextStyle(color: Colors.black),
                                    )),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                            right: 5,
                            top: 5,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.edit_note,
                                    size: 20,
                                    color: Colors.blue,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // 删除
                                    knowledgeCubit?.reqDelKnowledgeData(data: {"id": knowledgeBean.id,"type":"remove"});
                                  },
                                  child: Icon(
                                    Icons.remove_circle,
                                    size: 20,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }

  checkPosition(TypeLabelBean typeBean) {
    var indexWhere = knowData.indexWhere((element) {
      return element['type_bean'].id == typeBean.id;
    });
    double height = 0;
    for (var i = 0; i < indexWhere; i++) {
      RenderBox itemBox = itemKeys[i].currentContext!.findRenderObject() as RenderBox;
      double itemPosition = itemBox.size.height;
      height = height + itemPosition;
    }
    scrollController.animateTo(
      height,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
