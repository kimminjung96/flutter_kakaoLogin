import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_login/kakao_login.dart';
import 'package:kakao_login/main_view_model.dart';

void main() {
  KakaoSdk.init(nativeAppKey: '1afa20907207e80d503534b79a616461');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Check Your Profile',
      theme: ThemeData(),
      home: const MyHomePage(title: 'hagunLab::Check your Profile'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final viewModel = MainViewModel(KakaoLogin());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade500,
        title: Text(
          widget.title,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            viewModel.user?.kakaoAccount?.profile?.profileImageUrl != null
                ? Image.network(
                viewModel.user!.kakaoAccount!.profile!.profileImageUrl!)
                : const Text(
              '로그인해보세요',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 120,
            ),
            Text(
              viewModel.isLogined
                  ? '${viewModel.user?.kakaoAccount?.profile?.nickname} 로그인되었습니다.'
                  : '로그인전입니다.',
              style: const TextStyle(
                color: Colors.black87,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await viewModel.login();
                    setState(() {});
                  },
                  child: const Text('login'),
                ),
                const SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await viewModel.logout();
                    setState(() {});
                  },
                  child: const Text('log Out'),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
