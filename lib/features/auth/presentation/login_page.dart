import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hello_zeen/utils/async_value_ui.dart';
import 'package:hello_zeen/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common_widget/primary_button.dart';
import '../../../common_widget/responsive_scrollable_card.dart';
import '../../../routing/app_router.dart';
import '../../../utils/app_constant.dart';
import '../state/auth_notifier.dart';

class LoginPage extends HookWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = useTextEditingController(text: '');
    final passwordController = useTextEditingController(text: '');

    final fieldsEmpty = useState<bool>(true);

    bool areFieldsEmpty() {
      return usernameController.text.toString().isEmpty ||
          passwordController.text.toString().isEmpty;
    }

    useEffect(() {
      usernameController.addListener(() {
        fieldsEmpty.value = areFieldsEmpty();
      });
      passwordController.addListener(() {
        fieldsEmpty.value = areFieldsEmpty();
      });
      return null;
    }, [
      usernameController,
      passwordController,
    ]);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 0,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          alignment: Alignment.center,
          margin: 10.horizontalPadding,
          child: Center(
            child: ResponsiveScrollableCard(child: Consumer(
              builder: (context, ref, child) {
                ref.listen<AsyncValue>(
                  authNotifierProvider,
                  (_, state) => state.showAlertDialogOnError(context),
                );
                final state = ref.watch(authNotifierProvider);

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                          hintText: AppLabels.username,
                          prefixIcon: Icon(Icons.person)),
                      autocorrect: false,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      keyboardAppearance: Brightness.light,
                    ),
                    8.height,
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        hintText: AppLabels.password,
                        prefixIcon: Icon(Icons.lock),
                      ),
                      autocorrect: false,
                      textInputAction: TextInputAction.done,
                      keyboardAppearance: Brightness.light,
                    ),
                    15.height,
                    PrimaryButton(
                        text: AppLabels.login,
                        isLoading: state.isLoading,
                        onPressed: areFieldsEmpty()
                            ? null
                            : () async {
                                final authNotifier =
                                    ref.read(authNotifierProvider.notifier);

                                final success = await authNotifier.login(
                                  username: usernameController.text,
                                  password: passwordController.text,
                                );
                                if (success) {
                                  context.replaceNamed(AppRoute.home.name);
                                }
                              }),
                  ],
                );
              },
            )),
          ),
        ),
      ),
    );
  }
}
