import 'package:blueprint/lib/base_store.dart';
import 'package:blueprint/modules/current_account/current_account.entity.dart';

class CurrentAccountStore extends Notifier {
  CurrentAccount? account;

  void reset() {
    account = null;
    notifyListeners();
  }

  void setAccount(CurrentAccount? account) {
    this.account = account;
    notifyListeners();
  }
}
