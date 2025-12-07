import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/telaSplash.dart';
import 'package:myapp/provider/userProvider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        title: 'Tela de Usuário',
        theme: ThemeData(primarySwatch: Colors.green),
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
      ),
    ),
  );
}
