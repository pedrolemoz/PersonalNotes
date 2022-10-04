import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/controllers/states.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/typography.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/loading_dialog.dart';
import '../../../core/widgets/unfocus_widget.dart';
import '../controllers/login/login_bloc.dart';
import '../controllers/login/login_events.dart';
import '../controllers/login/login_states.dart';

class LoginPage extends StatelessWidget {
  final loginBloc = Modular.get<LoginBloc>();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return UnfocusWidget(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: BlocConsumer<LoginBloc, AppState>(
              bloc: loginBloc,
              listener: (context, state) async {
                if (state is AuthenticatingUserState) {
                  await showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const LoadingDialog(text: 'Autenticando usuário'),
                  );
                  return;
                }

                Navigator.of(context, rootNavigator: true).pop();

                if (state is SuccessfullyAuthenticatedUserState) {
                  final successSnackBar = SnackBar(
                    backgroundColor: AppColors.blue,
                    content: Text(
                      'Olá, ${state.userName}!',
                      style: AppTypography.textHeadline(color: AppColors.darkWhite),
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
                }

                if (state is ErrorState && state is! UserInputErrorState) {
                  late final String snackBarMessage;

                  if (state is UserNotFoundState) {
                    snackBarMessage = 'O usuário não existe no sistema';
                  } else {
                    snackBarMessage = 'Um erro desconhecido ocorreu';
                  }

                  final errorSnackBar = SnackBar(
                    backgroundColor: AppColors.red,
                    content: Text(
                      snackBarMessage,
                      style: AppTypography.textHeadline(color: AppColors.darkWhite),
                    ),
                  );

                  ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
                }
              },
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Personal Notes',
                        style: AppTypography.title(),
                      ),
                    ),
                    const SizedBox(height: 56),
                    AppTextField(
                      controller: emailTextController,
                      hintText: 'Email',
                      errorText: state is InvalidUserEmailState || state is InvalidUserCredentialsState
                          ? 'O email inserido não é válido'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      isPassword: true,
                      controller: passwordTextController,
                      hintText: 'Senha',
                      errorText: state is InvalidUserPasswordState || state is InvalidUserCredentialsState
                          ? 'A senha inserida não é válida'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: AppButton(
                            onTap: () => Modular.to.pushNamed('/registration'),
                            text: 'Cadastre-se',
                          ),
                        ),
                        const VerticalDivider(),
                        Expanded(
                          child: AppButton(
                            onTap: () => loginBloc.add(
                              LoginWithCredentials(
                                email: emailTextController.text,
                                password: passwordTextController.text,
                              ),
                            ),
                            text: 'Entrar',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'ou',
                        style: AppTypography.textHeadline(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    AppButton(
                      onTap: () => loginBloc.add(const LoginWithGoogle()),
                      text: 'Continuar com o Google',
                      color: AppColors.googleBlue,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
