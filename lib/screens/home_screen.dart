import 'package:flutter/material.dart';
import 'package:zini_pay_demo/core/colors.dart';
import 'package:zini_pay_demo/core/extensions.dart';
import 'package:zini_pay_demo/core/strings.dart';
import 'package:zini_pay_demo/core/typography.dart';
import 'package:zini_pay_demo/screens/widgets.dart/active_check_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSyncing = false;

  void _toggleSync() {
    setState(() {
      _isSyncing = !_isSyncing;
    });
    // if (_isSyncing) {
    //   BackgroundService.startService();
    // } else {
    //   BackgroundService.stopService();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ActiveCheckWidget(
                isActive: _isSyncing,
              ),
              18.0.height,
              Text(
                _isSyncing ? Strings.active : Strings.inActive,
                style: AppTypography.acmeH1,
              ),
              168.0.height,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    backgroundColor: AppColors.primary,
                  ),
                  onPressed: _toggleSync,
                  child: Text(
                    _isSyncing ? Strings.stop : Strings.start,
                    style:
                        AppTypography.acmeH1.copyWith(color: AppColors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
