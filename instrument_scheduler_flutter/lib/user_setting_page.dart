import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSettingPage extends StatefulWidget {
  const UserSettingPage({super.key});

  @override
  State<UserSettingPage> createState() => _UserSettingPageState();
}

class _UserSettingPageState extends State<UserSettingPage> {
  String _userName = '';
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) {
      _userName = prefs.getString('userName') ?? '';
      _controller.text = _userName;
    });
  }

  Future<void> _finishSetting(BuildContext context) async {
    if (_userName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User Name cannot be empty'),
        ),
      );
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', _userName);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Input your name'),
              onChanged: (value) {
                setState(() {
                  _userName = value;
                });
              },
              autofocus: true,
              onSubmitted: (value) async {
                setState(() {
                  _userName = value;
                });
                await _finishSetting(context);
              },
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                await _finishSetting(context);
              },
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}
