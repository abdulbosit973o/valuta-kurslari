import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'features/valuta/lang/codegen_loader.g.dart';
import 'features/valuta/ui/currency_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('uz')],
      path: 'assets/language',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
      assetLoader: CodegenLoader(),
    ),
  );
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CurrencyScreen(),
    );
  }
}
