import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/constants.dart';
import 'domain/usecases/get_top_headlines.dart';
import 'presentation/blocs/news_cubit.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/pages/news_detail_page.dart';
import 'routes.dart';
import 'locator.dart';

/// The main app widget which configures theme, routes, and state management.
class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Provide the NewsCubit to the widget tree, injecting the Repository dependency.
    return BlocProvider(
      create: (context) => NewsCubit(getTopHeadlines: locator<GetTopHeadlines>()),
      child: MaterialApp(
        title: kAppTitle,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.indigo,
            accentColor: kAccentColor,
            backgroundColor: kBackgroundColor,
          ).copyWith(
            secondary: kAccentColor,
          ),
          scaffoldBackgroundColor: kBackgroundColor,
          appBarTheme: const AppBarTheme(
            color: kPrimaryColor,
            elevation: 0,
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          useMaterial3: true,
        ),
        
        // Route definitions
        initialRoute: Routes.home,
        routes: {
          Routes.home: (context) => const HomePage(),
          Routes.detail: (context) => const NewsDetailPage(),
        },
      ),
    );
  }
}