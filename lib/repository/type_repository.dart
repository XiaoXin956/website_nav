import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:website_nav/http/dio_manager.dart';

import '../bean/result_bean.dart';

class TypeRepository {
  Future<ResultBean> getSearchType(dynamic map) async {
    Response searchTypeRead = await DioManager.getInstant().post(
      path: "",
      data: map,
    );

    dynamic dataType = json.decode(searchTypeRead.data);
    if(dataType["code"]==0){
      dynamic data = dataType['data'];

      return ResultBean(code: dataType["code"],msg: dataType["msg"],data: data);
    }else{
      return ResultBean(code: dataType["code"],msg: dataType["msg"]);
    }
  }
}
