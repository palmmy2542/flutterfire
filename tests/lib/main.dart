// Copyright 2022, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

late UserCredential user;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  user = await FirebaseAuth.instance.signInAnonymously();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    const username = 'test@example222.com';
    const password = '123456789';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: username,
                  password: password,
                );
              },
              child: Text('create an user'),
            ),
            ElevatedButton(
              onPressed: () async {
                final user = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: username, password: password);
                print(user);
              },
              child: Text('login'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (Platform.isIOS && kDebugMode) {
                  final user = FirebaseAuth.instance.currentUser;
                  final idToken = await user?.getIdTokenResult();

                  print(user);
                  print(idToken);
                }
              },
              child: const Text('Test macOS tests manually'),
            ),
          ],
        ),
      ),
    );
  }
}
