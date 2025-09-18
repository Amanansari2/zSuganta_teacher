class ApiUrls{


  static const String baseUrl = "https://www.suganta.com/api";
  static const String mediaUrl = "https://www.suganta.com/storage/";

  //Authentications
 static const String signUpUrl = "/auth/register";
 static const String signInUrl = "/auth/login";
 static const String forgotPasswordUrl = "/auth/forgot-password";
 static const String verifyEmailUrl = "/auth/email/verification-notification";
 static const String getProfileUrl = "/auth/profile";
 static const String updateProfileUrl = "/auth/profile";
 static const String getSocialUrl = "/social-links";
 static const String updateSocialUrl = "/social-links";
 static const String updateEmailMobileUrl = "/auth/update-email-mobile";
 static const String resetPasswordUrl = "/auth/password";

 //Teacher
 static const String teacherOptionsUrl = "/options/2";
 static const String teacherSubjectsUrl = "/subjects";
 static const String updateTeacherInfoUrl = "/teaching";
 static const String getTeacherInfoUrl = "/teaching";

 //Institute
 static const String instituteOptionsUrl = "/options/3";
 static const String getInstituteProfileUrl = "/institute";
 static const String updateInstituteProfileUrl = "/institute";


//Sessions
 static const String sessionUrl = "/auth/sessions";
 static const String deleteSessionUrl = "/auth/sessions/delete";

//tickets
 static const String ticketOptionsUrl = "/options/4";
 static const String submitTicketUrl = "/support-tickets";



}