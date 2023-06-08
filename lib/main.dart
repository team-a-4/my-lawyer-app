import 'dart:math';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:my_lawyer/chat.dart';

import 'home.dart';

const double _kSize = 100;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DynamicColorBuilder(
    builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
        themeMode: ThemeMode.system,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: lightDynamic?.primary ?? Colors.green,
          ),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: darkDynamic?.primary ?? Colors.green,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
      );
    },
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _createAnonymousUserAndNavigate();
  }

  Future<void> _createAnonymousUserAndNavigate() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential userCredential = await auth.signInAnonymously();
    User user = userCredential.user!;

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('users').doc(user.uid).set({
      'anonymous': true,
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final listOfAnimations = [
      AppBody(
        'waterydesert.com',
        const Text(
          'Total animations: 20',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      AppBody(
        'waveDots',
        LoadingAnimationWidget.waveDots(
          color: Theme.of(context).colorScheme.primary,
          size: _kSize,
        ),
      ),
      AppBody(
        'inkDrop',
        LoadingAnimationWidget.inkDrop(
          color: Theme.of(context).colorScheme.primary,
          size: _kSize,
        ),
      ),
      AppBody(
        'twistingDots',
        LoadingAnimationWidget.twistingDots(
          leftDotColor: Theme.of(context).colorScheme.primary,
          rightDotColor: Theme.of(context).colorScheme.secondary,
          size: _kSize,
        ),
      ),
      AppBody(
        'threeRotatingDots',
        LoadingAnimationWidget.threeRotatingDots(
          color: Theme.of(context).colorScheme.primary,
          size: _kSize,
        ),
      ),
      AppBody(
        'staggeredDotsWave',
        LoadingAnimationWidget.staggeredDotsWave(
          color: Theme.of(context).colorScheme.primary,
          size: _kSize,
        ),
      ),
      AppBody(
        'fourRotatingDots',
        LoadingAnimationWidget.fourRotatingDots(
          color: Theme.of(context).colorScheme.primary,
          size: _kSize,
        ),
      ),
      AppBody(
        'fallingDot',
        LoadingAnimationWidget.fallingDot(
          color: Theme.of(context).colorScheme.primary,
          size: _kSize,
        ),
      ),
      AppBody(
        'prograssiveDots',
        LoadingAnimationWidget.prograssiveDots(
          color: Theme.of(context).colorScheme.primary,
          size: _kSize,
        ),
      ),
      AppBody(
        'discreteCircle',
        LoadingAnimationWidget.discreteCircle(
            color: Theme.of(context).colorScheme.primary,
            size: _kSize,
            secondRingColor: Theme.of(context).colorScheme.primary,
            thirdRingColor: Theme.of(context).colorScheme.secondary),
      ),
      AppBody(
        'threeArchedCircle',
        LoadingAnimationWidget.threeArchedCircle(
          color: Theme.of(context).colorScheme.primary,
          size: _kSize,
        ),
      ),
      AppBody(
        'bouncingBall',
        LoadingAnimationWidget.bouncingBall(
          color: Theme.of(context).colorScheme.primary,
          size: _kSize,
        ),
      ),
      AppBody(
        'flickr',
        LoadingAnimationWidget.flickr(
          leftDotColor: Theme.of(context).colorScheme.primary,
          rightDotColor: Theme.of(context).colorScheme.secondary,
          size: _kSize,
        ),
      ),
      AppBody(
        'hexagonDots',
        LoadingAnimationWidget.hexagonDots(
          color: Theme.of(context).colorScheme.primary,
          size: _kSize,
        ),
      ),
      AppBody(
        'beat',
        LoadingAnimationWidget.beat(
          color: Theme.of(context).colorScheme.primary,
          size: _kSize,
        ),
      ),
      AppBody(
        'twoRotatingArc',
        LoadingAnimationWidget.twoRotatingArc(
          color: Theme.of(context).colorScheme.primary,
          size: _kSize,
        ),
      ),
      AppBody(
        'horizontalRotatingDots',
        LoadingAnimationWidget.horizontalRotatingDots(
          color: Theme.of(context).colorScheme.primary,
          size: _kSize,
        ),
      ),
      AppBody(
        'newtonCradle',
        LoadingAnimationWidget.newtonCradle(
          color: Theme.of(context).colorScheme.primary,
          size: 2 * _kSize,
        ),
      ),
      AppBody(
        'stretchedDots',
        LoadingAnimationWidget.stretchedDots(
          color: Theme.of(context).colorScheme.primary,
          size: _kSize,
        ),
      ),
      AppBody(
        'halfTriangleDot',
        LoadingAnimationWidget.halfTriangleDot(
          color: Theme.of(context).colorScheme.primary,
          size: _kSize,
        ),
      ),
      AppBody(
        'dotsTriangle',
        LoadingAnimationWidget.dotsTriangle(
          color: Theme.of(context).colorScheme.primary,
          size: _kSize,
        ),
      ),
      // Add more animations here...
    ];
    return Scaffold(
      body: Center(
        child:
            listOfAnimations[Random().nextInt(listOfAnimations.length)].widget,
      ),
    );
  }
}

class AppBody {
  final String title;
  final Widget widget;

  AppBody(
    this.title,
    this.widget,
  );
}
