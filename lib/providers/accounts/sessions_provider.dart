import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:z_tutor_suganta/repository/authentication_repo.dart';
import 'package:z_tutor_suganta/utils/helpers/logger_helper.dart';

import '../../models/accounts/sessions_model.dart';
import '../../utils/constants/text_strings.dart';
import '../../widgets/dialog/custom_dialog.dart';


class SessionsProvider with ChangeNotifier{

  final AuthenticationRepo authenticationRepo = AuthenticationRepo();

  List<SessionData> _allSessions = [];
  int _currentPage = 1;
  int _lastPage = 1;
  bool _isLoading = false;

  List<SessionData> get allSessions => _allSessions;
  bool get isLoading => _isLoading;
  int get currentPage => _currentPage;
  int get lastPage => _lastPage;


  List<SessionData> get activeSessions =>
      _allSessions.where((e) => e.isActive).toList();
  List<SessionData> get inactiveSessions =>
      _allSessions.where((e) => !e.isActive).toList();

  Future<void> fetchSessions(BuildContext context, {bool loadMore = false}) async {
    if (_isLoading) return;
    if (loadMore && _currentPage >= _lastPage) return;
    _isLoading = true;
    notifyListeners();

    if (!loadMore) _currentPage = 1;

    try {
      final response = await authenticationRepo.getSessions(page: _currentPage);
      final sessionsModel = SessionsModel.fromJson(response['data']?? {});

      if (loadMore) {
        _allSessions.addAll(sessionsModel.data);
        _currentPage++;
      } else {
        _allSessions = sessionsModel.data;
        _currentPage = sessionsModel.currentPage;
      }

      _lastPage = sessionsModel.lastPage;

    } catch (e) {
      LoggerHelper.info("Error fetching sessions: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }



  Future<void> deleteSession(BuildContext context, int sessionId) async {
    _isLoading = true;
    notifyListeners();
    try{
      final response = await authenticationRepo.deleteSession({"session_id":sessionId});
      if(response['success'] == true){
        CustomDialog.show(
            context,
            title: AppText.success,
            message: response['message'],
            positiveButtonText: AppText.ok,
            onPositivePressed: () async{

              await fetchSessions(context);
              },
            dismissible: false,
            icon: FontAwesomeIcons.checkCircle
        );
    }else{
        String backendMessage = response['message'] ?? "Something went wrong";
        if (response['raw']?['errors'] != null && response['raw']['errors'] is Map) {
          final errors = response['raw']['errors'] as Map<String, dynamic>;
          if (errors.isNotEmpty) {
            final allMessages = errors.values
                .whereType<List>()
                .expand((list) => list)
                .map((e) => e.toString())
                .toList();

            if (allMessages.isNotEmpty) {
              backendMessage = allMessages.join("\n");
            }
          }
        }
        CustomDialog.show(
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