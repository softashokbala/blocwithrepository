import 'package:blocwithrepository/model/usermodel.dart';
import 'package:dio/dio.dart';

class UserProvider {
  final Dio dio = Dio(BaseOptions(baseUrl: "https://reqres.in/api/"));

  Future<UserModel> getUsers() async {
    try {
      final response = await dio.get("users?page=1");
      return userModelFromMap(response.toString());
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
