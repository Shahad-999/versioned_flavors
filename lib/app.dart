import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'flavors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder(
          future: PackageInfo.fromPlatform(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("App Name: ${snapshot.data?.appName}"),
                    Text('Version: ${snapshot.data?.version}'),
                    Text('Build Number: ${snapshot.data?.buildNumber}'),
                    Text('Flavor: ${F.name}'),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
