import 'package:cicd_tools/config/config_onesdk/operator_repo_impl.dart';
import 'package:cicd_tools/domain/usecases/operator_login.dart';
import 'package:flutter/material.dart';

class LoginDialog extends StatefulWidget {
  const LoginDialog({super.key});

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode focusNodeUser = FocusNode();
  final FocusNode focusNodePwd = FocusNode();
  OperatorUseCase? _useCase;

  @override
  void initState() {
    super.initState();
    _useCase = OperatorUseCase(repo: OperatorRepoImpl());
    _usernameController.text = _useCase!.curr?.name ?? '';
    if (_usernameController.text.isNotEmpty) {
      focusNodePwd.requestFocus();
    } else {
      focusNodeUser.requestFocus();
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    bool login = (await _useCase?.login(username, password)) ?? false;

    if (!mounted) {
      return;
    }

    Navigator.of(context).pop(login);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Record Operator'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _usernameController,
            focusNode: focusNodeUser,
            decoration: const InputDecoration(
              labelText: 'Username',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _passwordController,
            focusNode: focusNodePwd,
            decoration: const InputDecoration(
              labelText: 'Password',
            ),
            obscureText: true,
            onSubmitted: (v) {
              _handleLogin();
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            _handleLogin();
          },
          child: const Text('Record'),
        ),
      ],
    );
  }
}
