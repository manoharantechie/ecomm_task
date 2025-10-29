import 'dart:convert';
import 'package:e_comm/src/core/utills/const_value.dart';
import 'package:e_comm/src/features/data/cart_list_model.dart';
import 'package:e_comm/src/features/domain/api_utils.dart';
import 'package:e_comm/src/features/domain/cubit/cart/cart_state.dart';
import 'package:http/http.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInit());


  getCardsList() async {
    CartsListModel output;

    emit(CartLoading());

    SharedPreferences preferences = await SharedPreferences.getInstance();
    final Response response =
    await get(Uri.parse(ConstantValues().baseURl + ApiUtils().cartsUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer ${preferences.getString("token")}"
      },
    );

    try {
      output = CartsListModel.fromJson(jsonDecode(response.body));

      if (output!= null || output!= "") {
        emit(CartSucceed(response: output));

      } else {

        emit(CartFailed(message: "Response are missing"));
      }
    } catch (e) {
      print(e);
      emit(CartFailed(message: e.toString()));
    }

  }



}