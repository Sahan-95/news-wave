// import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'domain/use_cases/get_market_news.dart';
import 'presentation/bloc/news/bloc/news_bloc.dart';
import 'presentation/managers/injection_container.dart';
import 'presentation/pages/check_logged_in_status/check_logged_in_status.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await dotenv.load();

  runApp(const MyApp());

  //...... this is for Responsive check.....//

  // runApp(
  //   DevicePreview(
  //     builder: (context) => MyApp(),
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                NewsBloc(getIt<GetMarketNews>())..add(LoadNewsEvent('general')))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News Wave',

        // ....... This is for responsive check .........//
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,

        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => const CheckLoggedInStatus(),
        },
      ),
    );
  }
}
