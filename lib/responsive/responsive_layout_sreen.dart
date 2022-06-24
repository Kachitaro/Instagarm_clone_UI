import 'package:flutter/material.dart';
import 'package:instagram_mid/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ReponsiveLayout extends StatefulWidget {
  final Widget mobileScreenLayout;

  const ReponsiveLayout({Key? key, required this.mobileScreenLayout})
      : super(key: key);

  @override
  State<ReponsiveLayout> createState() => _ReponsiveLayoutState();
}

class _ReponsiveLayoutState extends State<ReponsiveLayout> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return widget.mobileScreenLayout;
      },
    );
  }
}
