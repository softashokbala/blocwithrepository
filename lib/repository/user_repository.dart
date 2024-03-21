import 'package:blocwithrepository/model/usermodel.dart';
import 'package:blocwithrepository/provider/userprovider.dart';

abstract class IUserRepository {
  Future<UserModel> getUsers();
}

class UserRepository extends IUserRepository {
  final UserProvider userProvider;
  UserRepository(this.userProvider);
  @override
  Future<UserModel> getUsers() {
    return userProvider.getUsers();
  }
}
