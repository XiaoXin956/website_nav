import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:website_nav/base/config.dart';
import 'package:website_nav/bean/type_bean.dart';
import 'package:website_nav/http/dio_manager.dart';

import '../bean/result_bean.dart';

abstract class ITypeRepository {
  Future<dynamic> addType(dynamic map);

  Future<dynamic> updateType(dynamic map);

  Future<dynamic> delType(dynamic map);

  Future<dynamic> searchTypeChild(dynamic map);

  Future<dynamic> searchType(dynamic map);

}

class TypeRepository extends ITypeRepository {
  // 添加子
  @override
  Future<dynamic> addType(dynamic map) async {
    dynamic addTypeRead = await DioManager.getInstant().post(
      path: "${Config.baseUrl}/add_type",
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
    if (dataRes["code"] == "0") {
      return ResultBean(code: int.parse(dataRes["code"]), msg: dataRes["msg"], data: null);
    } else {
      return ResultBean(code: dataRes["code"], msg: dataRes["msg"]);
    }
  }

  // 查询
  @override
  Future<dynamic> searchTypeChild(dynamic map) async {
    dynamic searchTypeRead = await DioManager.getInstant().post(
      path: "${Config.baseUrl}/search_type",
      data: map,
      options: Options(
        contentType: "application/json",
        headers: {"Access-Control-Allow-Credentials": true, "Access-Control-Allow-Origin": "*"},
      ),
    );
    dynamic dataRes = {};
    if (searchTypeRead.data is Map) {
      dataRes = searchTypeRead.data;
    } else {
      dataRes = json.decode(searchTypeRead.data);
    }
    if (dataRes["code"] == "0") {
      return ResultBean(code: int.parse(dataRes["code"]), msg: dataRes["msg"], data: null);
    } else {
      return ResultBean(code: dataRes["code"], msg: dataRes["msg"]);
    }
  }

  // 修改
  @override
  Future<dynamic> updateType(dynamic map) async {
    dynamic updateTypeRead = await DioManager.getInstant().post(
      path: "${Config.baseUrl}/update_type",
      data: map,
      options: Options(
        contentType: "application/json",
        headers: {"Access-Control-Allow-Credentials": true, "Access-Control-Allow-Origin": "*"},
      ),
    );
    dynamic dataRes = {};
    if (updateTypeRead.data is Map) {
      dataRes = updateTypeRead.data;
    } else {
      dataRes = json.decode(updateTypeRead.data);
    }
    if (dataRes["code"] == 0) {
      return ResultBean(code: dataRes["code"], msg: dataRes["msg"], data: TypeBean.fromJson(dataRes['data']));
    } else {
      return ResultBean(code: dataRes["code"], msg: dataRes["msg"]);
    }
  }

  // 删除
  @override
  Future<dynamic> delType(dynamic map) async {
    dynamic delTypeRead = await DioManager.getInstant().post(
      path: "${Config.baseUrl}/del_type",
      data: map,
      options: Options(
        contentType: "application/json",
        headers: {"Access-Control-Allow-Credentials": true, "Access-Control-Allow-Origin": "*"},
      ),
    );
    dynamic dataRes = {};
    if (delTypeRead.data is Map) {
      dataRes = delTypeRead.data;
    } else {
      dataRes = json.decode(delTypeRead.data);
    }
    if (dataRes["code"] == "0") {
      return ResultBean(code: int.parse(dataRes["code"]), msg: dataRes["msg"], data: null);
    } else {
      return ResultBean(code: dataRes["code"], msg: dataRes["msg"]);
    }
  }


  @override
  Future<ResultBean> searchType(dynamic map) async {
    try {
      Response searchTypeRead = await DioManager.getInstant().post(
          path: "${Config.baseUrl}/search_type",
          data: map,
          options: Options(contentType: "application/json", headers: {"Access-Control-Allow-Credentials": true, "Access-Control-Allow-Origin": "*"}));
      dynamic dataRes = {};
      if (searchTypeRead.data is Map) {
        dataRes = searchTypeRead.data;
      } else {
        dataRes = json.decode(searchTypeRead.data);
      }
      if (dataRes["code"] == 0) {
        List<TypeBean> data = (json.decode(dataRes['data']) as List<dynamic>).map((e) => TypeBean.fromJson(e)).toList();
        return ResultBean(code: dataRes["code"], msg: dataRes["msg"], data: data);
      } else {
        return ResultBean(code: dataRes["code"], msg: dataRes["msg"]);
      }
    } catch (error) {
      return ResultBean(code: -1, msg: '服務器異常');
    }
  }
}
