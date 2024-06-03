
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:website_nav/base/config.dart';
import 'package:website_nav/bean/result_bean.dart';
import 'package:website_nav/http/dio_manager.dart';

abstract class IKnowledgeRepository {

  Future<dynamic> addKnowledge(dynamic map);

  Future<dynamic> updateKnowledge(dynamic map);

  Future<dynamic> delKnowledge(dynamic map);

  Future<dynamic> searchKnowledge(dynamic map);

  Future<dynamic> uploadIcon(dynamic map);
}

class KnowledgeRepository extends IKnowledgeRepository{
  @override
  Future addKnowledge(map) async {
    dynamic addTypeRead = await DioManager.getInstant().post(
      path: "${Config.baseUrl}/knowledge_operation",
      data: map,
      options: Options(
        contentType: "application/json",
        headers: {"Access-Control-Allow-Credentials": true, "Access-Control-Allow-Origin": "*"},
      ),
    );
    dynamic dataRes = {};
    if (addTypeRead.data is Map) {
      dataRes = addTypeRead.data;
    } else {
      dataRes = json.decode(addTypeRead.data);
    }
    if (dataRes["code"] == 0) {
      return ResultBean(code: dataRes["code"], msg: dataRes["msg"], data: null);
    } else {
      return ResultBean(code: dataRes["code"], msg: dataRes["msg"]);
    }
  }


  @override
  Future delKnowledge(map) async {
    dynamic addTypeRead = await DioManager.getInstant().post(
      path: "${Config.baseUrl}/knowledge",
      data: map,
      options: Options(
        contentType: "application/json",
        headers: {"Access-Control-Allow-Credentials": true, "Access-Control-Allow-Origin": "*"},
      ),
    );
    dynamic dataRes = {};
    if (addTypeRead.data is Map) {
      dataRes = addTypeRead.data;
    } else {
      dataRes = json.decode(addTypeRead.data);
    }
    if (dataRes["code"] == 0) {
      return ResultBean(code: dataRes["code"], msg: dataRes["msg"], data: null);
    } else {
      return ResultBean(code: dataRes["code"], msg: dataRes["msg"]);
    }
  }

  @override
  Future searchKnowledge(dynamic map) async {
    dynamic addTypeRead = await DioManager.getInstant().post(
      path: "${Config.baseUrl}/knowledge_operation",
      data: map,
      options: Options(
        contentType: "application/json",
        headers: {"Access-Control-Allow-Credentials": true, "Access-Control-Allow-Origin": "*"},
      ),
    );
    dynamic dataRes = {};
    if (addTypeRead.data is Map) {
      dataRes = addTypeRead.data;
    } else {
      dataRes = json.decode(addTypeRead.data);
    }
    if (dataRes["code"] == 0) {
      return ResultBean(code: dataRes["code"], msg: dataRes["msg"], data: dataRes["data"]);
    } else {
      return ResultBean(code: dataRes["code"], msg: dataRes["msg"]);
    }
  }

  @override
  Future updateKnowledge(map) {
    // TODO: implement updateKnowledge
    throw UnimplementedError();
  }

  @override
  Future uploadIcon(map,{onSendProgress,onReceiveProgress}) async {
    dynamic fileUploadResult = await DioManager.getInstant().postFile(
      path: "https://api.imgbb.com/1/upload?expiration=600&key=2a3e1f7911d0220b807d8e6811a39b7f",
      data: map,
      options: Options(
        // contentType: "application/json",
        // headers: {"Access-Control-Allow-Credentials": true, "Access-Control-Allow-Origin": "*"},
      ),
      onSendProgress:(int count, int total)=>onSendProgress,
      onReceiveProgress:(int count, int total)=>onReceiveProgress,
    );
    dynamic dataRes = {};
    if (fileUploadResult.data is Map) {
      dataRes = fileUploadResult.data;
    } else {
      dataRes = json.decode(fileUploadResult.data);
    }
    if(dataRes["status"]==200 && dataRes["success"]==true){
      String imgUrl = dataRes['data']["url"];
      return ResultBean(code: 0, msg: "上传成功", data: imgUrl);
    }else{
      return ResultBean(code: 0, msg: "上传失败");
    }
  }



}