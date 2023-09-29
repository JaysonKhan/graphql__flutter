import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/providers/characters_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text("GRAPHQL example")),
      body: ref.watch(charactersProvider).maybeWhen(
        fetched: (characters) {
          return ListView(
            children: characters
                .map((item) => ListTile(
                      title: Text(item.name!),
                      leading: Image.network(
                        item.image!,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      subtitle: Text(item.status!),
                    ))
                .toList(),
          );
        },
        orElse: () {
          return Container();
        },
      ),
    );
    ;
  }
}
