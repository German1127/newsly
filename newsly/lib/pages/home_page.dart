import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/news_cubit.dart';
import '../core/constants.dart';
import '../widgets/news_list.dart';

/// The main page that displays the list of top headlines.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger the initial news load if the state is NewsInitial.
    final cubit = context.read<NewsCubit>();
    if (cubit.state is NewsInitial) {
      cubit.loadTopHeadlines();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(kAppTitle),
        backgroundColor: kPrimaryColor,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Force a refresh of the news list.
              context.read<NewsCubit>().loadTopHeadlines(forceRefresh: true);
            },
          ),
        ],
      ),
      body: Container(
        color: kBackgroundColor,
        child: BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state) {
            if (state is NewsLoading || state is NewsInitial) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: kPrimaryColor),
                    SizedBox(height: 10),
                    Text(kLoadingMessage),
                  ],
                ),
              );
            }

            if (state is NewsError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, color: Colors.red, size: 50),
                      const SizedBox(height: 10),
                      Text(
                        '${kErrorMessage}\nDetalles: ${state.message}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Retry loading.
                          context.read<NewsCubit>().loadTopHeadlines(forceRefresh: true);
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor),
                        child: const Text('Reintentar'),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is NewsLoaded) {
              return NewsList(articles: state.articles);
            }
            
            // Default state (should never be reached).
            return const Center(child: Text('Estado desconocido.'));
          },
        ),
      ),
    );
  }
}