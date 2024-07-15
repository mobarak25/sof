import 'package:flutter/material.dart';
import 'package:school_of_future/core/router/route_constents.dart';
import 'package:school_of_future/core/widgets/body.dart';
import 'package:school_of_future/core/widgets/text.dart';

Route<dynamic>? studentsRoutes(RouteSettings settings) {
  print(settings.name);
  WidgetBuilder builder;
  switch (settings.name) {
    case studentHome:
      builder = (BuildContext context) => const HomeScreen();
      break;
    case studentSearch:
      builder = (BuildContext context) => const SearchScreen();
      break;
    case studentProfile:
      builder = (BuildContext context) => const ProfileScreen();

      break;
    default:
      builder = (BuildContext context) => const Default();
  }
  return MaterialPageRoute(builder: builder, settings: settings);
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Body(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      child: const Center(
        child: TextB(text: "home"),
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SearchScreen'),
        leading: ModalRoute.of(context)?.canPop == true
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            : null,
      ),
      body: const Center(
        child: TextB(text: "SearchScreen"),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileScreen'),
        leading: ModalRoute.of(context)?.canPop == true
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            : null,
      ),
      body: const Center(
        child: TextB(text: "ProfileScreen"),
      ),
    );
  }
}

class Default extends StatelessWidget {
  const Default({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Default'),
        leading: ModalRoute.of(context)?.canPop == true
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            : null,
      ),
      body: const Center(
        child: TextB(text: "Default"),
      ),
    );
  }
}
