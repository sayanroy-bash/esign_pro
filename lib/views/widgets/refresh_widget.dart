import 'package:flutter/material.dart';
import 'package:flutter_demo_provider/views/widgets/app_button.dart';

class RefreshWidget extends StatelessWidget {
  final String message;
  final VoidCallback callback;
  const RefreshWidget({required this.message, required this.callback, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(message),
          AppButton(
            'Refresh',
            height: 50,
            width: 150,
            textStyle: TextStyle(fontSize: 18, color: Colors.black),
            callback,
            isLoading: false,
          ),
        ],
      ),
    );
  }
}
