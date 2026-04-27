#!/bin/bash

set -e

echo "== إنشاء المشروع =="
flutter create gold_field_app
cd gold_field_app

echo "== استبدال pubspec.yaml =="
cat > pubspec.yaml << 'EOF'
name: gold_field_app
description: Professional autonomous gold field exploration app
publish_to: "none"
version: 1.0.0+1

environment:
  sdk: ">=3.3.0 <4.0.0"

dependencies:
  flutter:
    sdk: flutter
  camera: ^0.10.5+5
  tflite_flutter: ^0.10.4
  image: ^4.1.3
  geolocator: ^11.0.0
  provider: ^6.1.2
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  flutter_map: ^7.0.2
  latlong2: ^0.9.1

flutter:
  uses-material-design: true
  assets:
    - assets/target_pack.json
    - assets/models/seg_model.tflite
EOF

echo "== إنشاء المجلدات =="
mkdir -p lib
mkdir -p assets/models

echo "== main.dart =="
cat > lib/main.dart << 'EOF'
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gold Field App',
      home: Scaffold(
        appBar: AppBar(title: const Text('Gold Field App')),
        body: Center(
          child: ElevatedButton(
            onPressed: () {},
            child: const Text("Start Mission"),
          ),
        ),
      ),
    );
  }
}
EOF

echo "== target_pack.json =="
cat > assets/target_pack.json << 'EOF'
[
  {
    "id": "T001",
    "title": "Red Sea Target",
    "lat": 19.8501,
    "lng": 36.7201,
    "mapProb": 0.85,
    "priority": "HIGH"
  }
]
EOF

echo "== نموذج وهمي tflite =="
head -c 100 /dev/zero > assets/models/seg_model.tflite

echo "== تثبيت الحزم =="
flutter pub get

echo "== بناء APK =="
flutter build apk --release

echo "=================================="
echo "تم إنشاء التطبيق بنجاح"
echo "ملف APK هنا:"
echo "build/app/outputs/flutter-apk/app-release.apk"
echo "=================================="