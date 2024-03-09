import 'package:blueprint/modules/current_account/current_account.repository.dart';
import 'package:blueprint/modules/current_account/current_account.store.dart';
import 'package:blueprint/widgets/buttons/app_async_button.dart';
import 'package:blueprint/widgets/form/app_password_form.dart';
import 'package:blueprint/widgets/form/app_text_form.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailFieldKey = GlobalKey<FormFieldState<String>>();
  final _passwordFieldKey = GlobalKey<FormFieldState<String>>();

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<bool> signupByEmail() async {
    try {
      final account = await CurrentAccountRepository().signupByEmail(
          email: _emailController.text,
          password: _passwordController.text,
      );
      context.read<CurrentAccountStore>().setAccount(account);
      print("成功");
      return true;
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        showSnackbar('すでに登録されているメールアドレスです');
      }
      if (e.response!.statusCode! >= 500) {
        showSnackbar('サーバーエラーが発生しました');
      }
      return false;
    }
  }

  void _validateCurrentField(GlobalKey<FormFieldState<String>> fieldKey) {
    if (fieldKey.currentState != null) {
      fieldKey.currentState!.validate();
    }
  }

  bool _isFormFilled() {
    return _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

  bool _validate() {
    bool isEmailValid = _emailFieldKey.currentState?.validate() ?? false;
    bool isPasswordValid = _passwordFieldKey.currentState?.validate() ?? false;

    return isEmailValid &&
        isPasswordValid;
  }

  @override
  void initState() {
    super.initState();

    _emailController.addListener(_handleChange);
    _passwordController.addListener(_handleChange);
  }

  void _handleChange() {
    setState(() {});
  }

  @override
  void dispose() {
    _emailController.removeListener(_handleChange);
    _passwordController.removeListener(_handleChange);

    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading:
            IconButton(icon: const Icon(Icons.arrow_back), onPressed: () {}),
        centerTitle: false,
        title: const Text(
          'アカウント登録',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        // フォーム外タップでキーボードが閉じるのを防ぐ
        onTap: () {},
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Focus(
                      child: AppTextForm(
                        fieldKey: _emailFieldKey,
                        label: 'メールアドレス',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: _validateEmail,
                      ),
                      onFocusChange: (hasFocus) => hasFocus
                          ? null
                          : _validateCurrentField(_emailFieldKey),
                    ),
                    const SizedBox(height: 32),
                    Focus(
                      child: AppPasswordForm(
                        fieldKey: _passwordFieldKey,
                        label: 'パスワード',
                        controller: _passwordController,
                      ),
                      onFocusChange: (hasFocus) => hasFocus
                          ? null
                          : _validateCurrentField(_passwordFieldKey),
                    ),
                    const SizedBox(height: 48),
                    AppAsyncButton(
                      radius: 100,
                      onPressed: _isFormFilled() ? signupByEmail : null,
                      text: '新規登録をはじめる',
                    ),
                  ],
                ),
              ),
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
