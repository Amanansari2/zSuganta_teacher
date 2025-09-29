import 'package:flutter/cupertino.dart';
import 'package:z_tutor_suganta/models/accounts/tickets/ticket_model_list.dart';
import 'package:z_tutor_suganta/repository/authentication_repo.dart';
import 'package:z_tutor_suganta/utils/helpers/logger_helper.dart';


class AllTicketProvider extends ChangeNotifier{

  final AuthenticationRepo authenticationRepo = AuthenticationRepo();

  List<TicketData> _allTickets =[];
  int _currentPage = 1;
  int _lastPage = 1;
  bool _isLoading = false;

  List<TicketData> get allTickets => _allTickets;
  bool get isLoading => _isLoading;
  int get currentPage => _currentPage;
  int get lastPage => _lastPage;

  List<TicketData> get openTickets =>
        _allTickets.where((e)=> e.status.toLowerCase() == 'open' ||
            e.status.toLowerCase()  == 'waiting_for_user'
        ).toList();


  List<TicketData> get resolvedTickets =>
      _allTickets.where((e)=> e.status.toLowerCase() == 'closed' ||
          e.status.toLowerCase()  == 'resolved'
      ).toList();


  List<TicketData> get urgentTickets =>
      _allTickets.where((e)=> e.priority.toLowerCase() == 'urgent').toList();

      Future<void> fetchTickets(BuildContext context, {bool loadMore = false}) async {
        if(_isLoading) return;
        if(loadMore && _currentPage >= _lastPage) return;
        _isLoading = true;
        notifyListeners();

        if(!loadMore) _currentPage = 1;
        final pageToFetch = loadMore ? _currentPage + 1 : 1;

        try{
          final response = await authenticationRepo.getTickets(page: pageToFetch);
          final ticketModel = TicketModelList.fromJson(response['data'] ?? {});

          if(loadMore){
            _allTickets.addAll(ticketModel.data);
            _currentPage = pageToFetch;
          }else{
            _allTickets = ticketModel.data;
            _currentPage = 1;
          }

          _lastPage = ticketModel.lastPage;
        }catch(e){
          LoggerHelper.info("Error fetching tickets: $e");
        }finally{
          _isLoading = false;
          notifyListeners();
        }
      }


}