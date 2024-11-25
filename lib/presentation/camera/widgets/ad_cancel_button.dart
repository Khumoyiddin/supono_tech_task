import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../core/app_assets.dart';
import '../../../core/app_colors.dart';
import '../../../core/router/app_router_names.dart';

class AdCancelButton extends StatefulWidget {
  final bool? isBannerAdLoaded;
  final BannerAd bannerAd;

  const AdCancelButton({super.key, required this.isBannerAdLoaded, required this.bannerAd});

  @override
  State<AdCancelButton> createState() => _AdCancelButtonState();
}

class _AdCancelButtonState extends State<AdCancelButton> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Column(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: _onCancelButtonPressed,
              child: Image.asset(
                height: 22,
                width: 72,
                PngAssets.cancelButton,
              ),
            ),
          ),
          Container(
            height: 92,
            color: AppColors.black,
            child: Center(
              child: widget.isBannerAdLoaded == true
                  ? AdWidget(ad: widget.bannerAd)
                  : widget.isBannerAdLoaded == null
                      ? CircularProgressIndicator(color: AppColors.white)
                      : Text("Could not load the ads"),
            ),
          ),
        ],
      ),
    );
  }

  void _onCancelButtonPressed() {
    context.push(AppRouterNames.settings, extra: true);
  }
}
