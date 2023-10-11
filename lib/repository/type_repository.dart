import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:website_nav/bean/type_bean.dart';
import 'package:website_nav/http/dio_manager.dart';

import '../bean/result_bean.dart';

class TypeRepository {
  Future<ResultBean> getSearchType(dynamic map) async {
    Response searchTypeRead = await DioManager.getInstant().post(
      path: "http://localhost:4500/search_type",
      data: map,
      options: Options(
        contentType: "application/json",
        headers: {
          "Access-Control-Allow-Credentials":true,
          "Access-Control-Allow-Origin":"*"
        }
      )
    );
    try{
      dynamic dataRes = {};
      if(searchTypeRead.data is Map){
        dataRes = searchTypeRead.data;
      }else{
        dataRes = json.decode(searchTypeRead.data);
      }
      if(dataRes["code"]=="0"){
        List<TypeBean> data = (json.decode(dataRes['data']) as List<dynamic>)
            .map((e) => TypeBean.fromJson(e))
            .toList();
        return ResultBean(code: int.parse(dataRes["code"]),msg: dataRes["msg"],data: data);
      }else{
        return ResultBean(code: dataRes["code"],msg: dataRes["msg"]);
      }
    }catch(error){
      return ResultBean(code: -1,msg: '服務器異常');
    }

  }
}
