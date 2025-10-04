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

  Future<Map<String, dynamic>> getTickets({int page = 1}) async {
    try {
      final response = await getMethod.getRequest(
        endpoint: "${ApiUrls.getTicketUrl}?page=$page",
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

  Future<Map<String, dynamic>> getTicketDetails({required int ticketId}) async {
    try {
      final response = await getMethod.getRequest(
        endpoint: "${ApiUrls.getTicketDetailsUrl}/$ticketId",
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


  Future<Map<String, dynamic>>  replyTicket(FormData formData, {required int ticketId}) async {
    try {
      final response = await postMethod.postFormDataRequest(
          endpoint: "${ApiUrls.replyTicketUrl}/$ticketId/replies",
          formData: formData,
      requireAuth: true
      );
      return response ;
    } catch(e){
      return {
        'status': 'error',
        'code': 500,
        'message': 'Exception during get sessions: $e',
      };
    }
  }

  Future<Map<String, dynamic>>  closeTicket({required int ticketId}) async {
    try{
      final response = await postMethod.postRequest(
          endpoint: "${ApiUrls.closeTicketUrl}/$ticketId/close",
          data: {},
          requireAuth: true
      );
      return response;
    } catch(e){
      return {
        'status': 'error',
        'code': 500,
        'message': 'Exception during get sessions: $e',
      };
    }
  }


  //-------------------------------->>>>>>>>>>>>>Home Section<<<<<<<<<<<<<<


  Future<Map<String, dynamic>> getProfileCompletePercentage() async{
    try{
      final response = await getMethod.getRequest(
          endpoint: ApiUrls.profileCompletionUrl,
      requireAuth: true
      );
      return response;
    }catch(e){
      return {
        'status': 'error',
        'code': 500,
        'message': 'Exception during get sessions: $e',
      };
    }
  }


  //-------------------------------->>>>>>>>>>>>>Class Section<<<<<<<<<<<<<<

  Future<Map<String, dynamic>> getClassOptions() async{
    try{
      final response = await getMethod.getRequest(
          endpoint: ApiUrls.classOptionsUrl,
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

  Future<Map<String, dynamic>> createClass(Map<String, dynamic> data) async{
    try{
      final response = await postMethod.postRequest(
          endpoint: ApiUrls.createClassUrl,
          requireAuth: true,
          data: data
      );
      return response;
    }catch(e){
      return{
        'status' : 'error',
        'code' : '500',
        'message' : 'Exception during create Classes : $e'
      };
    }
  }

  Future<Map<String, dynamic>> getClasses({int page = 1}) async {
    try {
      final response = await getMethod.getRequest(
        endpoint: "${ApiUrls.getAllClassUrl}?page=$page",
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

  Future<Map<String, dynamic>> getUpcomingClasses({int page = 1}) async {
    try {
      final response = await getMethod.getRequest(
        endpoint: "${ApiUrls.getupComingClassUrl}?page=$page",
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

  Future<Map<String, dynamic>> getCompletedClasses({int page = 1}) async {
    try {
      final response = await getMethod.getRequest(
        endpoint: "${ApiUrls.getCompletedClassUrl}?page=$page",
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


  Future<Map<String, dynamic>> getCancelledClasses({int page = 1}) async {
    try {
      final response = await getMethod.getRequest(
        endpoint: "${ApiUrls.getCancelledClassUrl}?page=$page",
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

  Future<Map<String, dynamic>> getClassDetails({required int classId}) async {
    try {
      final response = await getMethod.getRequest(
        endpoint: "${ApiUrls.getAllClassUrl}/$classId",
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

  Future<Map<String, dynamic>> completeClass({required int classId}) async {
    try {
      final response = await postMethod.postRequest(
        data: {},
        endpoint: "${ApiUrls.completeClassUrl}/$classId/complete",
        requireAuth: true,
      );
      return response;
    } catch (e) {
      return {
        'status': 'error',
        'code': 500,
        'message': 'Exception during complete sessions: $e',
      };
    }
  }

  Future<Map<String, dynamic>> cancelClass({required int classId}) async {
    try {
      final response = await postMethod.postRequest(
        data: {},
        endpoint: "${ApiUrls.cancelClassUrl}/$classId",
        requireAuth: true,
      );
      return response;
    } catch (e) {
      return {
        'status': 'error',
        'code': 500,
        'message': 'Exception during cancel sessions: $e',
      };
    }
  }

  Future<Map<String, dynamic>> editClass(Map<String, dynamic> data,{required int classId}) async {
    try {
      final response = await postMethod.postRequest(
        data: data,
        endpoint: "${ApiUrls.editClassUrl}/$classId",
        requireAuth: true,
      );
      return response;
    } catch (e) {
      return {
        'status': 'error',
        'code': 500,
        'message': 'Exception during edit sessions: $e',
      };
    }
  }

  Future<Map<String, dynamic>> logoutFromCurrentDevice() async {
    try{
      final response = await postMethod.postRequest(
          endpoint:ApiUrls.logoutCurrentDeviceUrl,
          data: {},
      requireAuth:  true
      );
      return response;

    }catch (e) {
      return {
        'status': 'error',
        'code': 500,
        'message': 'Exception during logout current device : $e',
      };
    }
  }

  Future<Map<String, dynamic>> logoutFromAllDevices() async{
    try{
      final response = await postMethod.postRequest(
          endpoint: ApiUrls.logoutAllDevicesUrl,
          data: {},
      requireAuth: true
      );
      return response;
    }catch (e) {
      return {
        'status': 'error',
        'code': 500,
        'message': 'Exception during logout current device : $e',
      };
    }

  }




}



