import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:unicons/unicons.dart';

import '../../../core/controllers/states.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/typography.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_text_field.dart';
import '../../../core/widgets/loading_dialog.dart';
import '../controllers/registration/registration_bloc.dart';
import '../controllers/registration/registration_events.dart';
import '../controllers/registration/registration_states.dart';

class RegistrationPage extends StatelessWidget {
  final registrationBloc = Modular.get<RegistrationBloc>();
  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) {
            return IconButton(
              tooltip: 'Voltar',
              splashRadius: 24,
              onPressed: () => Modular.to.maybePop(),
              icon: const Icon(
                UniconsLine.arrow_left,
                size: 28,
              ),
            );
          },
        ),
      ),
      body: BlocConsumer<RegistrationBloc, AppState>(
        bloc: registrationBloc,
        listener: (context, state) async {
          if (state is RegistratingUserState) {
            await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const LoadingDialog(text: 'Cadastrando usuário'),
            );
            return;
          }

          Navigator.of(context, rootNavigator: true).pop();

          if (state is SuccessfullyRegistratedUserState) {
            final successSnackBar = SnackBar(
              backgroundColor: AppColors.blue,
              content: Text(
                'Bem vindo, ${state.userName}!',
                style: AppTypography.textHeadline(color: AppColors.darkWhite),
              ),
            );

            ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
          }

          if (state is ErrorState && state is! UserInputErrorState) {
            final errorSnackBar = SnackBar(
              backgroundColor: AppColors.red,
              content: Text(
                'Um erro desconhecido ocorreu',
                style: AppTypography.textHeadline(color: AppColors.darkWhite),
              ),
            );

            ScaffoldMessenger.of(context).showSnackBar(errorSnackBar);
          }
        },
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(32),
            children: [
              AppTextField(
                controller: nameTextController,
                hintText: 'Nome',
                errorText: state is InvalidUserNameState ? 'O nome inserido não é válido' : null,
              ),
              const SizedBox(height: 16),
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
              AppButton(
                onTap: () => registrationBloc.add(
                  RegisterWithCredentials(
                    name: nameTextController.text,
                    email: emailTextController.text,
                    password: passwordTextController.text,
                  ),
                ),
                text: 'Cadastre-se',
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
                onTap: () => registrationBloc.add(const RegisterWithGoogle()),
                text: 'Continuar com o Google',
                color: AppColors.googleBlue,
              ),
            ],
          );
        },
      ),
    );
  }
}
