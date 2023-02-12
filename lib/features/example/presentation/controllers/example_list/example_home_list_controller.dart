import 'package:jbbase_app/base/base.dart';
import 'package:jbbase_app/features/authentication/authentication.dart';
import 'package:jbbase_app/features/example/example.dart';

class ExampleHomeListController extends BaseController {
  final fetchDataState = BaseState();

  // If u already put this usecase, just call find to get, don't need to inject via binding
  final UserUseCase _userUseCase;

  GetUsersDataUseCase get _getUsersDataUseCase => _userUseCase.getUsersDataUseCase;

  CommonPagingController<User> get pagingController => _pagingController;

  final _pagingController = CommonPagingController<User>();
  final _users = <User>[];

  ExampleHomeListController(this._userUseCase);

  @override
  void onInit() {
    super.onInit();

    getUserData(0);
    _pagingController.disposeBy(disposeBag);
    _pagingController.listen(
      onLoadMore: () {
        getUserData(_users.length);
      },
    );
  }

  Future<void> getUserData(int startIndex) {
    return _getUsersDataUseCase.execute(
      observer: Observer(
        onSubscribe: () {
          fetchDataState.onLoading();
        },
        onSuccess: (data) {
          fetchDataState.onSuccess();
          _users.addAll(data);
          _pagingController.appendLoadMoreOutput(
            LoadMoreOutput(data, isRefreshSuccess: startIndex == 0),
          );
        },
        onError: (AppException e) {
          fetchDataState.onError(e.message);
          // _showToastMessage(e.message);
        },
      ),
      input: startIndex,
    );
  }

  Future<void> onRefresh() async {
    await getUserData(0);
  }
}
