import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_zeen/common_widget/cancel_dialog.dart';
import 'package:hello_zeen/features/auth/state/auth_notifier.dart';
import 'package:hello_zeen/features/home/state/home_notifier.dart';
import '../../../routing/app_router.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.read(homeNotifierProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
              onTap: () {
                ConfirmDialog.show(
                    context: context,
                    title: 'Confirmation',
                    content: 'Are you sure want to logout?',
                    leftTitleButton: 'Ok',
                    onPressedOk: () async {
                      final authNotifier =
                          ref.read(authNotifierProvider.notifier);
                      final success = await authNotifier.logout();
                      if (success && mounted) {
                        context.pushReplacementNamed(AppRoute.login.name);
                      }
                    });
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.power_settings_new_rounded),
              ))
        ],
      ),
      body: Center(
        child: FutureBuilder(
            future: state.getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final str = snapshot.data as String;
                return Text(str);
              }
              return const Text('No Data');
            }),
      ),
    );
  }
}
