

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:website_nav/base/config.dart';
import 'package:website_nav/bean/result_bean.dart';
import 'package:website_nav/bean/user_bean.dart';
import 'package:website_nav/http/dio_manager.dart';
import 'package:website_nav/utils/sp_utils.dart';

abstract class IUserRepository{

  Future<ResultBean> userOperation(dynamic map);

  Future<ResultBean> userReg(dynamic map);
  Future<ResultBean> userLogin(dynamic map);

}

class UserRepository extends IUserRepository{

  @override
  Future<ResultBean> userOperation(map) async {
    dynamic userReg = await DioManager.getInstant().post(
      path: "${Config.baseUrl}/user_operation",
      data: map,
      options: Options(
        contentType: "application/json",
        headers: {"Access-Control-Allow-Credentials": true, "Access-Control-Allow-Origin": "*"},
      ),
    );
    dynamic dataRes = {};
    if (userReg.data is Map) {
      dataRes = userReg.data;
    } else {
      dataRes = json.decode(userReg.data);
    }
    if (dataRes["code"] == 0) {
      return ResultBean(code: dataRes["code"], msg: dataRes["msg"], data: UserBean.fromJson(dataRes['data']));
    } else {
      return ResultBean(code: dataRes["code"], msg: dataRes["msg"]);
    }
  }

  @override
  Future<ResultBean> userReg(map) async {
    dynamic userReg = await DioManager.getInstant().post(
      path: "${Config.baseUrl}/user_operation",
      data: map,
      options: Options(
        contentType: "application/json",
        headers: {"Access-Control-Allow-Credentials": true, "Access-Control-Allow-Origin": "*"},
      ),
    );
    dynamic dataRes = {};
    if (userReg.data is Map) {
      dataRes = userReg.data;
    } else {
      dataRes = json.decode(userReg.data);
    }
    if (dataRes["code"] == 0) {
      saveData("local_user", dataRes['data']);
      return ResultBean(code: dataRes["code"], msg: dataRes["msg"], data: UserBean.fromJson(dataRes['data']));
    } else {
      return ResultBean(code: dataRes["code"], msg: dataRes["msg"]);
    }
  }

  @override
  Future<ResultBean> userLogin(map) async {
    dynamic userLogin = await DioManager.getInstant().post(
      path: "${Config.baseUrl}/user_operation",
      data: map,
      options: Options(
        contentType: "application/json",
        headers: {"Access-Control-Allow-Credentials": true, "Access-Control-Allow-Origin": "*"},
      ),
    );
    dynamic dataRes = {};
    if (userLogin.data is Map) {
      dataRes = userLogin.data;
    } else {
      dataRes = json.decode(userLogin.data);
    }
    if (dataRes["code"] == 0) {
      saveData("local_user", json.encode(dataRes['data']));
      return ResultBean(code: dataRes["code"], msg: dataRes["msg"], data: UserBean.fromJson(dataRes['data']));
    } else {
      return ResultBean(code: dataRes["code"], msg: dataRes["msg"]);
    }
  }


}