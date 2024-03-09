import 'package:blueprint/modules/current_account/current_account.repository.dart';
import 'package:blueprint/modules/current_account/current_account.store.dart';
import 'package:blueprint/widgets/buttons/app_async_button.dart';
import 'package:blueprint/widgets/form/app_password_form.dart';
import 'package:blueprint/widgets/form/app_text_form.dart';
import 'package:blueprint/widgets/buttons/app_text_button.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SigninScreen extends StatefulWidget {
  static const routeName = '/signin';
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFieldKey = GlobalKey<FormFieldState<String>>();
  final _passwordFieldKey = GlobalKey<FormFieldState<String>>();

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFFBA1A1A),
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  bool _isFormFilled() {
    return _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

  bool _validate() {
    bool isEmailValid = _emailFieldKey.currentState?.validate() ?? false;
    bool isPasswordValid = _passwordFieldKey.currentState?.validate() ?? false;

    return isEmailValid && isPasswordValid;
  }

  //パスワード再設定画面へ遷移
  void _moveToResetPasswordEmailScreen() {}

  void _moveToSignUpScreen() {
    Navigator.of(context).pushNamed('/signup');
  }

  Future<void> _signinByEmail() async {
    if (!_validate()) return;
    try {
      final account = await CurrentAccountRepository().signinByEmail(
        email: _emailController.text,
        password: _passwordController.text,
      );
      context.read<CurrentAccountStore>().setAccount(account);
      print('ログイン成功');
    } on DioException catch (e) {
      _showSnackBar(e.message.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_handleChanged);
    _passwordController.addListener(_handleChanged);
  }

  @override
  void dispose() {
    _emailController.removeListener(_handleChanged);
    _passwordController.removeListener(_handleChanged);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: const Text(
          'ログイン',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: GestureDetector(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Focus(
                    child: AppTextForm(
                      fieldKey: _emailFieldKey,
                      label: 'メールアドレス',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: _validateEmail,
                    ),
                    onFocusChange: (hasFocus) {
                      if (!hasFocus) {
                        _emailFieldKey.currentState?.validate();
                      }
                    },
                  ),
                  const SizedBox(height: 32),
                  Focus(
                    child: AppPasswordForm(
                      fieldKey: _passwordFieldKey,
                      label: 'パスワード',
                      hintText: '英数字のみ、8文字以上',
                      controller: _passwordController,
                    ),
                    onFocusChange: (hasFocus) {
                      if (!hasFocus) {
                        _passwordFieldKey.currentState?.validate();
                      }
                    },
                  ),
                  const SizedBox(height: 32),
                  AppAsyncButton(
                    text: 'ログイン',
                    onPressed: _isFormFilled() ? _signinByEmail : null,
                  ),
                  const SizedBox(height: 16),
                  AppTextButton(
                      text: '新規登録はこちら',
                      color: const Color(0xFF3F6375),
                      onPressed: _moveToSignUpScreen),
                  AppTextButton(
                      text: 'パスワードを忘れた方はこちら',
                      color: const Color(0xFF3F6375),
                      onPressed: _moveToResetPasswordEmailScreen),
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'メールアドレスを入力してください';
    }

    String pattern = r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    RegExp regExp = RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return '有効なメールアドレスを入力してください';
    }

    return null;
  }
}
