import 'package:flutter/material.dart';
import 'package:kaiteki/ui/pages/customization/customization_basic_page.dart';

class CustomizationSettingsScreen extends StatefulWidget {
  const CustomizationSettingsScreen({Key? key}) : super(key: key);

  @override
  _CustomizationSettingsScreenState createState() =>
      _CustomizationSettingsScreenState();
}

class _CustomizationSettingsScreenState
    extends State<CustomizationSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Customization")),
      body: const CustomizationBasicPage(),
    );
  }
}
