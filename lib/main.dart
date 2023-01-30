import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/app/app.dart';
import 'core/firebase/firebase_options.dart';

//this file should be responsible to everything related to project initializations.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MakharejApp());
}
