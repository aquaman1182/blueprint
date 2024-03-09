import 'package:blueprint/modules/current_account/current_account.store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> generateProviders() {
  return [
    ChangeNotifierProvider(create: (_) => CurrentAccountStore()),
  ];
}

void resetStores(BuildContext context) {
  context.read<CurrentAccountStore>().reset();
}
