import 'package:z_tutor_suganta/configs/url.dart';
import 'package:z_tutor_suganta/networks/get_method.dart';
import 'package:z_tutor_suganta/networks/post_method.dart';

class AuthenticationRepo {
  final PostMethod postMethod = PostMethod();
  final GetMethod getMethod = GetMethod();

  Future<Map<String, dynamic>> signup(Map<String, dynamic> data) async {
    try {
      final response = await postMethod.postRequest(
        endpoint: ApiUrls.signUpUrl,
        data: data,
        requireAuth: false,
      );
      return response;
    } catch (e) {
      return {
        'status': 'error',
        'code': 500,
        'message': 'Exception during signup: $e',
      };
    }
  }


  Future<Map<String, dynamic>> signIn(Map<String, dynamic> data) async {
    try{
      final response = await postMethod.postRequest(
          endpoint: ApiUrls.signInUrl,
          data: data,
          requireAuth: false
      );
      return response;
    } catch(e){
      return {
        'status' : 'error',
        'code' : '500',
        'message' : 'Exception during signin: $e'
      };
    }
  }

  Future<Map<String, dynamic>> verifyEmail(Map<String, dynamic> data) async{
    try{
      final response = await postMethod.postRequest(
          endpoint: ApiUrls.verifyEmailUrl,
          data: data,
         requireAuth: false
      );
      return response;
    } catch(e){
      return {
        'status' : 'error',
        'code' : '500',
        'message' : 'Exception during signin: $e'
      };
    }
  }


  Future<Map<String, dynamic>> forgotPassword(Map<String, dynamic> data) async {
    try{
      final response = await postMethod.postRequest(
          endpoint: ApiUrls.forgotPasswordUrl,
          data: data,
        requireAuth: false
      );
      return response;
    } catch(e) {
      return {
        'status' : 'error',
        'code' : '500',
        'message' : 'Exception during forgot password : $e'
      };
    }
  }


  Future<Map<String, dynamic>> getUserProfile() async {
    try{
      final response = await getMethod.getRequest(
          endpoint: ApiUrls.getProfileUrl,
      requireAuth: true
      );
      return response;
    } catch(e){
      return {
        'status' : 'error',
        'code' : '500',
        'message' : 'Exception during forgot password : $e'
      };
    }
  }


}



