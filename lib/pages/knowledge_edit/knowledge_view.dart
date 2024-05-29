import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:website_nav/bean/type_bean.dart';
import 'package:website_nav/generated/l10n.dart';
import 'package:website_nav/pages/knowledge_edit/knowledge_cubit.dart';
import 'package:website_nav/pages/label/label_cubit.dart';
import 'package:website_nav/utils/print_utils.dart';
import 'package:website_nav/widgets/custom_widget.dart';
import 'package:website_nav/widgets/edit_widget.dart';
import 'package:website_nav/widgets/fixed_size_grid_delegate.dart';

import 'knowledge_state.dart';

// 编辑页面
class KnowledgePage extends StatefulWidget {
  const KnowledgePage({super.key});

  @override
  State<KnowledgePage> createState() => _KnowledgePageState();
}

class _KnowledgePageState extends State<KnowledgePage> {
  KnowledgeCubit? knowledgeCubit;
  TypeLabelBean? selectChildValue;

  String oneMenuName = "";
  String twoMenuName = "";

  List<TypeLabelBean> typeChildData = [];

  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _urlEditingController = TextEditingController();
  TextEditingController _labelEditingController = TextEditingController();
  TextEditingController _describeEditingController = TextEditingController();

  String imageUrl = "";
  bool uploadLoading = false;

  bool _edit = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      knowledgeCubit?.reqSearchType(data: {"type": "search"});
      // knowledgeBloc?.add(LabelSearchEvent(data: {"type": "child"}));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KnowledgeCubit, KnowledgeState>(
      builder: (BuildContext context, state) {
        knowledgeCubit = context.read<KnowledgeCubit>();
        if (state is KnowledgeInitState) {
        } else if (state is LabelTypeSelectChildState) {
          selectChildValue = state.typeBean;
        } else if (state is LabelTypeFailState) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msgFail)));
          });
        } else if (state is LabelTypeSearchSuccessState) {
          context.read<LabelCubit>().reqSearchLabel({"type": "search"});
          context.read<KnowledgeCubit>().reqSearchAllKnowledgeData(data: {"type": "search"});
          // 获取成功
          typeChildData.clear();
          typeChildData.addAll(state.typeData);
        } else if (state is LabelTypeAddSuccessState) {
          knowledgeCubit?.reqSearchType(data: {"type": "search"});
          context.read<LabelCubit>().searchAllType({"type": "search"});
          context.read<KnowledgeCubit>().reqSearchAllKnowledgeData(data: {"type": "search"});
          //  添加成功
          // 一级刷新数据
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msgSuccess)));
          });
          // 获取成功
          // knowledgeCubit?.add(LabelSearchEvent(data: {"type": "child"}));
          knowledgeCubit?.reqSearchType(data: {"type": "search"});
        } else if (state is KnowledgeAddSuccessState) {
          context.read<LabelCubit>().searchAllType({"type": "search"});
          knowledgeCubit?.reqSearchType(data: {"type": "search"});
          // knowledgeCubit?.add(KnowledgeInitEvent());
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
        } else if (state is KnowledgeEditTypeState) {
          // 编辑类型
          _edit = !_edit;
          // knowledgeCubit?.add(KnowledgeInitEvent());
          knowledgeCubit?.reqKnowledgeInit();
        } else if (state is KnowledgeSuccessState) {
          context.read<LabelCubit>().searchAllType({"type": "search"});
          knowledgeCubit?.reqSearchType(data: {"type": "child"});
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.msgSuccess)));
          });
        } else if (state is KnowledgeUploadIconSuccessState) {
          uploadLoading = false;
          imageUrl = state.imageUrl;
        } else if (state is KnowledgeUploadLoadingState) {
          uploadLoading = true;
        } else if (state is KnowledgeUploadIconFailState) {
          uploadLoading = false;
        }
        return _buildPage(context);
      },
    );
  }

  Widget _buildPage(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: true,
        onPopInvoked: (value) async {},
        child: Container(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              // 上方显示类型，
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        height: 200.h,
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("  ${S.of(context).one_menu}  "),
                                Expanded(
                                  child: customTextField(
                                      onChanged: (value) {
                                        oneMenuName = value;
                                      }),
                                ),
                              ],
                            ),
                            h(10),
                            ElevatedButton(
                              // style: ButtonStyle(
                              //   shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                              // ),
                                onPressed: () {
                                  knowledgeCubit?.reqKnowledgeTypeAdd(data: {
                                    "type": "add",
                                    "name": oneMenuName,
                                  });
                                },
                                child: textWidget(text: "${S.of(context).add_one_menu}",textStyle: TextStyle(fontSize: 14))),
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
                                        // knowledgeCubit?.add(KnowledgeEditTypeEvent(isEdit: _edit));
                                        knowledgeCubit?.editType(isEdit: _edit);
                                      },
                                      child: Text(
                                        (_edit) ? "${S.of(context).complete}" : "${S.of(context).edit}",
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          knowledgeCubit?.reqSearchType(data: {"type": "search"});
                                        },
                                        icon: Icon(Icons.refresh)),
                                  ],
                                ),
                              ),
                              // 表格列表选中
                              Expanded(
                                  child: GridView.builder(
                                gridDelegate: FixedSizeGridDelegate(100, 50, mainAxisSpacing: 10),
                                itemCount: typeChildData.length,
                                itemBuilder: (BuildContext context, int index) {
                                  TypeLabelBean selectValueTemp = typeChildData[index];
                                  return Stack(
                                    children: [
                                      Container(
                                        width: double.maxFinite,
                                        height: double.maxFinite,
                                        child: GestureDetector(
                                          onTap: () {
                                            // knowledgeCubit?.add(LabelTypeSelectChildEvent(typeBean: typeChildData[index]));
                                            knowledgeCubit?.selectKnowledgeType(typeBean: typeChildData[index]);
                                          },
                                          child: Container(
                                            height: 60,
                                            width: 60,
                                            padding: EdgeInsets.only(left: 6, right: 6),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: (selectChildValue != null && selectChildValue!.id == selectValueTemp.id) ? Colors.blue : Colors.white,
                                                border: Border.all(color: (selectChildValue != null && selectChildValue!.id == selectValueTemp.id) ? Colors.white : Colors.grey, width: 1)),
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
                                      Positioned(
                                          right: 0,
                                          top: 0,
                                          child: AnimatedSwitcher(
                                              duration: Duration(seconds: 1),
                                              child: (_edit)
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        knowledgeCubit?.delType(data: {"id": selectValueTemp.id,"type":"del"});
                                                      },
                                                      child: Icon(
                                                        Icons.cancel_outlined,
                                                        color: Colors.red,
                                                        size: 20,
                                                      ),
                                                    )
                                                  : Container()))
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
                                  decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2))),
                                  onChanged: (value) {
                                    _textEditingController.text = value;

                                    _textEditingController.selection = TextSelection(baseOffset: _textEditingController.text.length, extentOffset: _textEditingController.text.length);
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
                                  decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2))),
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
                                  decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2))),
                                  onChanged: (value) {
                                    _labelEditingController.text = value;
                                    _labelEditingController.selection = TextSelection(baseOffset: _labelEditingController.text.length, extentOffset: _labelEditingController.text.length);
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
                                  decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2))),
                                  onChanged: (value) {
                                    _describeEditingController.text = value;
                                    _describeEditingController.selection = TextSelection(baseOffset: _describeEditingController.text.length, extentOffset: _describeEditingController.text.length);
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
                        Text('图标：'),
                        // 预览
                        (imageUrl != "")
                            ? Container(
                                margin: EdgeInsets.only(left: 8, right: 8),
                                width: 80,
                                height: 80,
                                child: Image.network(
                                  imageUrl,
                                  width: 80,
                                  height: 80,
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.only(left: 8, right: 8),
                                width: 80,
                                height: 80,
                              ),
                        Expanded(
                          child: Text(imageUrl, style: TextStyle(color: Colors.blue, fontSize: 12)),
                        ),
                        (uploadLoading)
                            ? CircularProgressIndicator()
                            : TextButton(
                                onPressed: () async {
                                  FilePickerResult? result = await FilePicker.platform.pickFiles();
                                  if (result != null) {
                                    File file = File(result.files.toString());
                                    // File file = File(result.files, result.files.single.name);
                                    printRed(file.path);
                                    // 进行图片上传
                                    Map<String, dynamic> data = {"image": await MultipartFile.fromBytes(result.files.single.bytes as List<int>, filename: result.files.single.name)};
                                    knowledgeCubit?.uploadIcon(data: data);
                                  }
                                },
                                child: Text("选择")),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          knowledgeCubit?.reqAddKnowledgeData(data: {
                            "type": "add",
                            "text": "${_textEditingController.text}",
                            "url": "${_urlEditingController.text}",
                            "label": "${_labelEditingController.text}",
                            "img_url": "$imageUrl",
                            "type_id": selectChildValue?.id,
                            "describe": "${selectChildValue?.id}",
                          });
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
