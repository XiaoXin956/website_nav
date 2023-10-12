import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:website_nav/base/config.dart';
import 'package:website_nav/bean/type_bean.dart';
import 'package:website_nav/http/dio_manager.dart';

import '../bean/result_bean.dart';

abstract class ITypeRepository {
  Future<dynamic> addTypeChild(dynamic map);

  Future<dynamic> searchTypeChild(dynamic map);

  Future<dynamic> updateTypeChild(dynamic map);

  Future<dynamic> delTypeChild(dynamic map);

  Future<dynamic> addTypeParent(dynamic map);

  Future<dynamic> searchTypeParent(dynamic map);

  Future<dynamic> updateTypeParent(dynamic map);

  Future<dynamic> delTypeParent(dynamic map);
}


class TypeRepository extends ITypeRepository {


  // 添加
  Future<dynamic> addTypeChild(dynamic map) async {
  }

  // 查询
  Future<dynamic> searchTypeChild(dynamic map) async {
  }

  // 更新
  Future<dynamic> updateTypeChild(dynamic map) async {
  }

  // 修改
  Future<dynamic> delTypeChild(dynamic map) async {

  }


  ///////////////// 父级

  // 添加父级
  Future<dynamic> addTypeParent(dynamic map) async {
  }

  // 查询
  Future<dynamic> searchTypeParent(dynamic map) async {

  }

  // 更新
  Future<dynamic> updateTypeParent(dynamic map) async {

  }

  // 修改
  Future<dynamic> delTypeParent(dynamic map) async {

  }

  Future<ResultBean> getSearchType(dynamic map) async {
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
      if (dataRes["code"] == "0") {
        List<TypeBean> data = (json.decode(dataRes['data']) as List<dynamic>).map((e) => TypeBean.fromJson(e)).toList();
        return ResultBean(code: int.parse(dataRes["code"]), msg: dataRes["msg"], data: data);
      } else {
        return ResultBean(code: dataRes["code"], msg: dataRes["msg"]);
      }
    } catch (error) {
      return ResultBean(code: -1, msg: '服務器異常');
    }
  }
}
