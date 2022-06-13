import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rss/providers/database_provider.dart';
import 'package:rss/views/home/cubit/home_cubit.dart';
import 'package:rss/views/home/home_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseProvider.init();
  WebView.platform = SurfaceAndroidWebView();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: BlocProvider(
        create: (context) => HomeCubit(),
        child: const HomeScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
