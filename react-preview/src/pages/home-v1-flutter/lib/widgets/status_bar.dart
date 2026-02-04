import 'package:flutter/material.dart';
import '../constants/app_images.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 30.548,
            height: 8.991,
            child: Image.network(
              AppImages.statusTime,
              fit: BoxFit.contain,
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 18,
                height: 18,
                child: Image.network(
                  AppImages.statusWifi,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 3.068),
              SizedBox(
                width: 18,
                height: 18,
                child: Image.network(
                  AppImages.statusSignal,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 3.068),
              SizedBox(
                width: 18.75,
                height: 18.75,
                child: Image.network(
                  AppImages.statusBattery,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
