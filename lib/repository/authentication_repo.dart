import 'package:dio/dio.dart';
import 'package:z_tutor_suganta/configs/url.dart';
import 'package:z_tutor_suganta/networks/get_method.dart';
import 'package:z_tutor_suganta/networks/post_method.dart';
import 'package:z_tutor_suganta/utils/helpers/logger_helper.dart';

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
        'message' : 'Exception during verify email: $e'
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
        'message' : 'Exception during get user profile : $e'
      };
    }
  }

  Future<Map<String, dynamic>> updateUserProfile(FormData  formData) async{

    try{
      final response = await postMethod.postFormDataRequest(
          endpoint: ApiUrls.updateProfileUrl,
          formData: formData,
         requireAuth: true
      );
     return response;
    } catch(e){
      LoggerHelper.info("Exception during profile update : $e");
      return {
        'status' : 'error',
        'code' : '500',
        'message' : 'Exception during profile update : $e'
      };
    }
  }

  Future<Map<String, dynamic>> getSocialProfile() async {
    try{
      final response = await getMethod.getRequest(
          endpoint: ApiUrls.getSocialUrl,
      requireAuth: true
      );
      return response;
    } catch(e) {
      return{
        'status' : 'error',
        'code' : '500',
        'message' : 'Exception during get Social Urls : $e'
      };
    }
  }

  Future<Map<String, dynamic>> updateSocialProfile(Map<String, dynamic>data) async {
    try{
      final response = await postMethod.postRequest(
          endpoint: ApiUrls.updateSocialUrl,
          data: data,
      requireAuth: true
      );
      return response;
    } catch(e) {
      return{
        'status' : 'error',
        'code' : '500',
        'message' : 'Exception during update social url : $e'
      };
    }
  }

  Future<Map<String, dynamic>> emailPhone(Map<String, dynamic>data) async {
    try {
      final response = await postMethod.postRequest(
          endpoint: ApiUrls.updateEmailMobileUrl,
          data: data,
      requireAuth:  true
      );
      return response;
    } catch(e){
      return{
        'status' : 'error',
        'code' : '500',
        'message' : 'Exception during update email & mobile : $e'
      };
    }
  }

  Future<Map<String, dynamic>> resetPassword(Map<String, dynamic>data) async {
    try{
      final response = await postMethod.postRequest(
          endpoint: ApiUrls.resetPasswordUrl,
          data: data,
      requireAuth: true
      );
      return response;
    } catch(e){
      return{
        'status' : 'error',
        'code' : '500',
        'message' : 'Exception during update social url : $e'
      };
    }
  }

  Future<Map<String, dynamic>> getSessions({int page = 1}) async {
    try {
      final response = await getMethod.getRequest(
        endpoint: "${ApiUrls.sessionUrl}?page=$page",
        requireAuth: true,
      );
      return response;
    } catch (e) {
      return {
        'status': 'error',
        'code': 500,
        'message': 'Exception during get sessions: $e',
      };
    }
  }


  Future<Map<String,dynamic>> deleteSession(Map<String, dynamic>data) async{
    try{
      final response = await postMethod.postRequest(
          endpoint: ApiUrls.deleteSessionUrl,
          data: data,
         requireAuth: true
      );
      return response;
    }catch(e){
      return{
        'status': 'error',
        'code': 500,
        'message': 'Exception during delete sessions: $e',
      };
    }
  }

  //-------------------------------->>>>>>>>>>>>>Teacher Section<<<<<<<<<<<<<<

  Future<Map<String, dynamic>> getTeacherOptions() async{
    try{
      final response = await getMethod.getRequest(
          endpoint: ApiUrls.teacherOptionsUrl,
      requireAuth: true
      );
     return response;
    }catch(e){
      return{
        'status' : 'error',
        'code' : '500',
        'message' : 'Exception during get Social Urls : $e'
      };
    }
  }

  Future<Map<String, dynamic>> getTeacherSubjects() async {
    try{
      final response = await getMethod.getRequest(
          endpoint: ApiUrls.teacherSubjectsUrl,
         requireAuth: true
      );
      return response;
    }catch(e){
      return{
        'status' : 'error',
        'code' : '500',
        'message' : 'Exception during get Social Urls : $e'
      };
    }
  }

  Future<Map<String, dynamic>> updateTeachingInformation(Map<String,dynamic>data) async{
    try{
      final response = await postMethod.postRequest(
          endpoint: ApiUrls.updateTeacherInfoUrl,
          data: data,
          requireAuth: true
      );
      return response;
    }catch(e) {
      return{
        'status' : 'error',
        'code' : '500',
        'message' : 'Exception during update social url : $e'
      };
    }
  }

  Future<Map<String, dynamic>> getTeacherProfile() async {
    try{
      final response = await getMethod.getRequest(
          endpoint: ApiUrls.getTeacherInfoUrl,
          requireAuth: true
      );
      return response;
    } catch(e) {
      return{
        'status' : 'error',
        'code' : '500',
        'message' : 'Exception during get Social Urls : $e'
      };
    }
  }


//-------------------------------->>>>>>>>>>>>>Institute Section<<<<<<<<<<<<<<
  Future<Map<String, dynamic>> getInstituteOptions() async {
    try{
      final response = await getMethod.getRequest(
          endpoint: ApiUrls.instituteOptionsUrl,
          requireAuth:  true
      );
      return response;
    }catch(e){
      return {
        'status' : 'error',
        'code' : '500',
        'message' : 'Exception during get Institute Options Urls : $e'
      };
    }
  }


  Future<Map<String, dynamic>> getInstituteProfile() async {
    try{
      final response = await getMethod.getRequest(
          endpoint: ApiUrls.getInstituteProfileUrl,
      requireAuth: true
       );
      return response;
    }catch(e){
      return {
        'status' : 'error',
        'code' : '500',
        'message' : 'Exception during get institute profile Urls : $e'
      };
    }
  }

  Future<Map<String, dynamic>> updateInstituteProfile (Map<String, dynamic>data) async{
    try{
      final response = await postMethod.postRequest(
          endpoint: ApiUrls.updateInstituteProfileUrl,
          data: data,
          requireAuth: true
      );
      return response;
    }catch(e){
      return {
        'status' : 'error',
        'code' : '500',
        'message' : 'Exception during update institute url : $e'
      };
    }
  }

  //-------------------------------->>>>>>>>>>>>>Ticket Section<<<<<<<<<<<<<<
  Future<Map<String, dynamic>> getTicketOptions() async {
    try{
      final response = await getMethod.getRequest(
          endpoint: ApiUrls.ticketOptionsUrl,
          requireAuth:  true
      );
      return response;
    }catch(e){
      return {
        'status' : 'error',
        'code' : '500',
        'message' : 'Exception during get Institute Options Urls : $e'
      };
    }
  }

  Future<Map<String, dynamic>> submitTicket(FormData formData) async {
    try{
      final response = await postMethod.postFormDataRequest(
          endpoint: ApiUrls.submitTicketUrl,
          formData: formData,
           requireAuth:  true
      );
      return response;
    }catch(e){
      LoggerHelper.info("Exception during submit ticket : $e");
      return {
        'status' : 'error',
        'code' : '500',
        'message' : 'Exception during submit ticket : $e'
      };
    }
  }

}



