import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:z_tutor_suganta/models/classes/class_detailed_model.dart';
import 'package:z_tutor_suganta/models/classes/class_list_model.dart';
import 'package:z_tutor_suganta/repository/authentication_repo.dart';
import 'package:z_tutor_suganta/utils/helpers/logger_helper.dart';

import '../../utils/constants/text_strings.dart';
import '../../widgets/dialog/custom_dialog.dart';

class AllClassesProvider extends ChangeNotifier{
  final AuthenticationRepo authenticationRepo = AuthenticationRepo();

  List<ClassList> _allClasses = [];
  int _currentPage = 1;
  int _lastPage = 1;
  bool _isLoading = false;

  List<ClassList> get allClasses => _allClasses;
  bool get isLoading => _isLoading;
  int get currentPage => _currentPage;
  int get lastPage => _lastPage;

  Future<void> fetchClasses(BuildContext context, {bool loadMore = false}) async {
    if(_isLoading) return;
    if(_isLoading && _currentPage >= _lastPage) return;
    _isLoading = true;
    notifyListeners();

    if(!loadMore) _currentPage = 1;
    final pageToFetch = loadMore ? _currentPage + 1 : 1;

    try{
      final response = await authenticationRepo.getClasses(page: pageToFetch);
      final classModel = ClassModelList.fromJson(response['data']);


      if(loadMore){
        _allClasses.addAll(classModel.data);
        _currentPage = pageToFetch;
      }else{
        _allClasses = classModel.data;
        _currentPage = 1;
      }

      _lastPage = classModel.pagination.lastPage;
    }catch(e){
      LoggerHelper.info("Error fetching all classes : $e");
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }



  List<ClassList> _upcomingClasses = [];
  int _upcomingCurrentPage = 1;
  int _upcomingLastPage = 1;
  bool _upcomingLoading = false;

  List<ClassList> get upcomingClasses => _upcomingClasses;
  bool get upcomingLoading => _upcomingLoading;
  int get upcomingCurrentPage => _upcomingCurrentPage;
  int get upcomingLastPage => _upcomingLastPage;

  Future<void> fetchUpcomingClasses(BuildContext context, {bool loadMore = false}) async {
    if(_upcomingLoading) return;
    if(_upcomingLoading && _upcomingCurrentPage >= _upcomingLastPage) return;
    _upcomingLoading = true;
    notifyListeners();

    if(!loadMore) _upcomingCurrentPage = 1;
    final pageToFetch = loadMore ? _upcomingCurrentPage + 1 : 1;

    try{
      final response = await authenticationRepo.getUpcomingClasses(page: pageToFetch);
      final classModel = ClassModelList.fromJson(response['data']);


      if(loadMore){
        _upcomingClasses.addAll(classModel.data);
        _upcomingCurrentPage = pageToFetch;
      }else{
        _upcomingClasses = classModel.data;
        _upcomingCurrentPage = 1;
      }

      _upcomingLastPage = classModel.pagination.lastPage;
    }catch(e){
      LoggerHelper.info("Error fetching upcoming classes : $e");
    }finally{
      _upcomingLoading = false;
      notifyListeners();
    }
  }


  List<ClassList> _completedClasses = [];
  int _completedCurrentPage = 1;
  int _completedLastPage = 1;
  bool _completedLoading = false;

  List<ClassList> get completedClasses => _completedClasses;
  bool get completedLoading => _completedLoading;
  int get completedCurrentPage => _completedCurrentPage;
  int get completedLastPage => _completedLastPage;

  Future<void> fetchCompletedClasses(BuildContext context, {bool loadMore = false}) async {
    if(_completedLoading) return;
    if(_completedLoading && _completedCurrentPage >= _completedLastPage) return;
    _completedLoading = true;
    notifyListeners();

    if(!loadMore) _completedCurrentPage = 1;
    final pageToFetch = loadMore ? _completedCurrentPage + 1 : 1;

    try{
      final response = await authenticationRepo.getCompletedClasses(page: pageToFetch);
      final classModel = ClassModelList.fromJson(response['data']);


      if(loadMore){
        _completedClasses.addAll(classModel.data);
        _completedCurrentPage = pageToFetch;
      }else{
        _completedClasses = classModel.data;
        _completedCurrentPage = 1;
      }

      _completedLastPage = classModel.pagination.lastPage;
    }catch(e){
      LoggerHelper.info("Error fetching completed classes : $e");
    }finally{
      _completedLoading = false;
      notifyListeners();
    }
  }

  List<ClassList> _cancelledClasses = [];
  int _cancelledCurrentPage = 1;
  int _cancelledLastPage = 1;
  bool _cancelledLoading = false;

  List<ClassList> get cancelledClasses => _cancelledClasses;
  bool get cancelledLoading => _cancelledLoading;
  int get cancelledCurrentPage => _cancelledCurrentPage;
  int get cancelledLastPage => _cancelledLastPage;


  Future<void> fetchCancelledClasses(BuildContext context, {bool loadMore = false}) async {
    if(_cancelledLoading) return;
    if(_cancelledLoading && _cancelledCurrentPage >= _cancelledLastPage) return;
    _cancelledLoading = true;
    notifyListeners();

    if(!loadMore) _cancelledCurrentPage = 1;
    final pageToFetch = loadMore ? _cancelledCurrentPage + 1 : 1;

    try{
      final response = await authenticationRepo.getCancelledClasses(page: pageToFetch);
      final classModel = ClassModelList.fromJson(response['data']);


      if(loadMore){
        _cancelledClasses.addAll(classModel.data);
        _cancelledCurrentPage = pageToFetch;
      }else{
        _cancelledClasses = classModel.data;
        _cancelledCurrentPage = 1;
      }

      _cancelledLastPage = classModel.pagination.lastPage;
    }catch(e){
      LoggerHelper.info("Error fetching cancelled classes : $e");
    }finally{
      _cancelledLoading = false;
      notifyListeners();
    }
  }


  ClassDetailedModel? _classDetails;
  ClassDetailedModel? get classDetails => _classDetails;

  Future<ClassDetailedModel?> fetchClassDetails(BuildContext context, {required int classId}) async {
    _isLoading = true;
    notifyListeners();
    ClassDetailedModel? details;
    try{
      final response = await authenticationRepo.getClassDetails(classId: classId);
      if(response['success'] == true){

        final sessionJson = response['data']['session']?? {};
        final enrollmentJson = response['data']['enrollments'] ?? [];

        _classDetails = ClassDetailedModel.fromJson(
            {
              ...sessionJson,
              'enrollments': enrollmentJson,
              'is_completed': response['data']['is_completed'],
              'is_cancelled': response['data']['is_cancelled'],
            }
        );

        details = _classDetails;
      }else{
        CustomDialog.show(
          context,
          title: AppText.error,
          message: response['message'] ?? "something went wrong",
          positiveButtonText: AppText.retry,
          onPositivePressed: (){},
          icon: FontAwesomeIcons.triangleExclamation,
        );
      }
    }catch(e){
      LoggerHelper.info("Error fetching class details : $e");
      CustomDialog.show(
        context,
        title: AppText.error,
        message: e.toString(),
        positiveButtonText: AppText.retry,
        onPositivePressed: (){},
        icon: FontAwesomeIcons.triangleExclamation,

      );
    }finally{
      _isLoading = false;
      notifyListeners();
    }
    return details;
  }


  Future<void> completeClass(BuildContext context, {required int classId}) async {
    _isLoading = true;
    notifyListeners();

    try{
      final response = await authenticationRepo.completeClass(classId: classId);

      if(response['success'] == true){
        CustomDialog.show(
            context,
            title: AppText.success,
            message: response['message'],
            positiveButtonText: AppText.ok,
            onPositivePressed: () async{
              await fetchClassDetails(context, classId: classId);
            },
            dismissible: true,
            backButtonBlock: true,
            icon: FontAwesomeIcons.checkCircle
        );
      }else{
        String backendMessage = response['message'] ?? "Something went wrong";
        if(response['raw']?['errors'] != null && response['raw']['errors'] is Map){
          final errors = response['raw']['errors'] as Map<String, dynamic>;
          if(errors.isNotEmpty){
            final firstFiled = errors.keys.first;
            final firstErrorList = errors[firstFiled];
            if(firstErrorList is List && firstErrorList.isNotEmpty){
              backendMessage = firstErrorList.first.toString();
            }
          }
        }
        CustomDialog.show(
          backButtonBlock: true,
          context,
          title: AppText.error,
          message: backendMessage,
          positiveButtonText: AppText.retry,
          onPositivePressed: (){},
          icon: FontAwesomeIcons.triangleExclamation,
        );
      }
    }catch(e){
      CustomDialog.show(
        context,
        title: AppText.error,
        message: e.toString(),
        positiveButtonText: AppText.retry,
        onPositivePressed: (){},
        icon: FontAwesomeIcons.triangleExclamation,
      );
    }finally{
      _isLoading = false;
      notifyListeners();
    }
    }


    Future<void> cancelClass(BuildContext context, {required int classId}) async {
      _isLoading = true;
      notifyListeners();
      try{
        final response = await authenticationRepo.cancelClass(classId: classId);

        if(response['success'] == true){
          CustomDialog.show(
              context,
              title: AppText.success,
              message: response['message'],
              positiveButtonText: AppText.ok,
              onPositivePressed: () async{
                await fetchClassDetails(context, classId: classId);
              },
              dismissible: true,
              backButtonBlock: true,
              icon: FontAwesomeIcons.checkCircle
          );
        }else{
          String backendMessage = response['message'] ?? "Something went wrong";
          if(response['raw']?['errors'] != null && response['raw']['errors'] is Map){
            final errors = response['raw']['errors'] as Map<String, dynamic>;
            if(errors.isNotEmpty){
              final firstFiled = errors.keys.first;
              final firstErrorList = errors[firstFiled];
              if(firstErrorList is List && firstErrorList.isNotEmpty){
                backendMessage = firstErrorList.first.toString();
              }
            }
          }
          CustomDialog.show(
            backButtonBlock: true,
            context,
            title: AppText.error,
            message: backendMessage,
            positiveButtonText: AppText.retry,
            onPositivePressed: (){},
            icon: FontAwesomeIcons.triangleExclamation,
          );
        }
      }catch(e){
        CustomDialog.show(
          context,
          title: AppText.error,
          message: e.toString(),
          positiveButtonText: AppText.retry,
          onPositivePressed: (){},
          icon: FontAwesomeIcons.triangleExclamation,
        );
      }finally{
        _isLoading = false;
        notifyListeners();
      }

}

}