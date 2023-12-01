import 'package:amazon_mobile/data/network/dio_helper.dart';
import 'package:amazon_mobile/presentation/resources/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'payment_cubit_state.dart';

class PaymentCubitCubit extends Cubit<PaymentCubitState> {
  PaymentCubitCubit() : super(PaymentCubitInitial());
  static PaymentCubitCubit get(context) => BlocProvider.of(context);
  



  // AuthenticationRequestModel? authTokenModel;
  Future<void> getAuthToken() async {
    emit(PaymentAuthLoadingState());
    DioHelper.postDataDio(url: ApiContest.getAuthToken, data: {
      'api_key': ApiContest.getPaymentApiKey,

    }).then((value) {
      // authTokenModel = AuthenticationRequestModel.fromJson(value.data);
      ApiContest.paymentFirstToken = value.data['token'];
      print('The token ${ApiContest.paymentFirstToken}');
      emit(PaymentAuthSuccessState());
    }).catchError((error) {
      print('Error in auth token 🤦‍♂️');
      emit(
        PaymentAuthErrorState(error.toString()),
      );
    });
  }



 Future getOrderRegistrationID({
    required String price,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) async {
    emit(PaymentOrderIdLoadingStates());
    DioHelper.postDataDio(url: ApiContest.getOrderId, data: {
      'auth_token': ApiContest.paymentFirstToken,
      "delivery_needed": "false",
      "amount_cents": price,
      "currency": "EGP",
      "items": [],
    }).then((value) {
      // OrderRegistrationModel orderRegistrationModel = 
      //     OrderRegistrationModel.fromJson(value.data);
      ApiContest.paymentOrderId = value.data['id'];
      getPaymentRequest(price, firstName, lastName, email, phone);
      print('The order id 🍅 =${ApiContest.paymentOrderId}');
      emit(PaymentOrderIdSuccessStates());
    }).catchError((error) {
      print('Error in order id 🤦‍♂️');
      emit(
        PaymentOrderIdErrorStates(error.toString()),
      );
    });
  }


Future<void> getPaymentRequest(
    String price,
    String firstName,
    String lastName,
    String email,
    String phone,
  ) async {
    emit(PaymentRequestTokenLoadingStates());
    DioHelper.postDataDio(
      url: ApiContest.getPaymentId,
      data: {
        "auth_token": ApiContest.paymentFirstToken,
        "amount_cents": price,
        "expiration": 3600,
        "order_id": ApiContest.paymentOrderId,
        "billing_data": {
          "apartment": "NA",
          "email": email,
          "floor": "NA",
          "first_name": firstName,
          "street": "NA",
          "building": "NA",
          "phone_number": phone,
          "shipping_method": "NA",
          "postal_code": "NA",
          "city": "NA",
          "country": "NA",
          "last_name": lastName,
          "state": "NA"
        },
        "currency": "EGP",
        "integration_id": ApiContest.integrationIdCard,
        "lock_order_when_paid": "false"
      },
    ).then((value) {
      // PaymentRequestModel paymentRequestModel =
      //     PaymentRequestModel.fromJson(value.data);
      ApiContest.finalToken = value.data.token;
      print('Final token 🚀 ${ApiContest.finalToken}');
      emit(PaymentRequestTokenSuccessStates());
    }).catchError((error) {
      print('Error in final token 🤦‍♂️');
      emit(
        PaymentRequestTokenErrorStates(error.toString()),
      );
    });
  }


  Future getRefCode() async {
    emit(PaymentRefCodeLoadingStates());
    DioHelper.postDataDio(
      url: ApiContest.getRefCode,
      data: {
        "source": {
          "identifier": "AGGREGATOR",
          "subtype": "AGGREGATOR",
        },
        "payment_token": ApiContest.finalToken,
      },
    ).then((value) {
      ApiContest.refCode = value.data['id'].toString();
      print('The ref code 🍅${ApiContest.refCode}');
      emit(PaymentRefCodeSuccessStates());
    }).catchError((error) {
      print("Error in ref code 🤦‍♂️");
      emit(PaymentRefCodeErrorStates(error.toString()));
    });
  }








}
