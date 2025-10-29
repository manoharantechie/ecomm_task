import 'dart:convert';
import 'package:e_comm/src/core/utills/const_value.dart';
import 'package:e_comm/src/features/data/login_model.dart';
import 'package:e_comm/src/features/domain/api_utils.dart';
import 'package:e_comm/src/features/domain/cubit/login/login_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';

import 'package:flutter_bloc/flutter_bloc.dart';


class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInit());

  login({ required String username, required String password}) async {

    String message() {
      if (username.isEmpty) {
        return 'Enter user is required';
      } else {
        return 'Something went wrong. Please try again!';
      }
    }

    emit(LoginLoading());

    try {
      // 🔹 Make API call
      final Response response = await post(
        Uri.parse(ConstantValues().baseURl + ApiUtils().loginUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'password': password,
        }),
      );
      //
      print(response.body);

      // 🔹 Parse response
      LoginModel output = LoginModel.fromJson(
        jsonDecode(response.body),
      );

      if (output.token != null) {
        emit(LoginSucceed(response: output));
      } else {
        emit(LoginFailed(message: "Enter valid Login details"));
      }
    } catch (e) {
      print("Login error: ${e.toString()}");

      emit(LoginFailed(message: message()));
    }
  }



  // deleteAccount({required String user_id,}) async {
  //   // 🔹 Local validation
  //   if (user_id.isEmpty) {
  //     emit(LoginFailed(message: 'User ID is required'));
  //     return;
  //   }
  //
  //   emit(LoginLoading());
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //
  //   final Response response = await post(
  //
  //     Uri.parse('${ConstantValues().baseURl}${ApiUtils().deleteAccountUrl}'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //       'Authorization': "Bearer ${preferences.getString("token")}"
  //     },
  //     body: jsonEncode(<String, String>{'user_id': user_id}),
  //   );
  //
  //   try {
  //     CommonDataModel output = CommonDataModel.fromJson(jsonDecode(response.body));
  //
  //     if (output.success) {
  //       // 🔹 Emit success with full model
  //       emit(LoginSucceed(response: output));
  //     } else {
  //       emit(LoginFailed(message: output.message ?? "User ID verification failed"));
  //     }
  //   } catch (e) {
  //     print('User ID verification error: $e');
  //     emit(LoginFailed(message: 'Something went wrong. Please try again!'));
  //   }
  // }



  StoreData(String token)async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.setString("token", token);

  }
  StoreDatas(String token)async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    preferences.setString("token", token);

  }


}
