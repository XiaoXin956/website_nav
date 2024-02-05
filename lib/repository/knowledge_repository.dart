
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
}

class KnowledgeRepository extends IKnowledgeRepository{
  @override
  Future addKnowledge(map) async {
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



}