import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/app_assets.dart';
import '../../core/app_colors.dart';
import '../../core/router/app_router_names.dart';

const _testAdUnitID = 'ca-app-pub-3940256099942544/6300978111';

class PhotoPreviewPage extends StatefulWidget {
  final XFile? image;

  const PhotoPreviewPage({super.key, required this.image});

  @override
  State<PhotoPreviewPage> createState() => _PhotoPreviewPageState();
}

class _PhotoPreviewPageState extends State<PhotoPreviewPage> {
  late BannerAd _bannerAd;
  bool? _isBannerAdLoaded;
  bool _isAppUnlocked = false;

  @override
  void initState() {
    super.initState();
    _loadValues();

    _bannerAd = BannerAd(
      adUnitId: _testAdUnitID,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() => _isBannerAdLoaded = true);
        },
        onAdFailedToLoad: (ad, error) {
          setState(() => _isBannerAdLoaded = false);
          log('Banner ad failed to load: $error');
        },
      ),
    );

    _bannerAd.load();
  }

  Future<void> _loadValues() async {
    final prefs = await SharedPreferences.getInstance();
    _isAppUnlocked = prefs.getBool('is_app_unlocked') ?? false;
    setState(() {});
  }

  void _onCancelButtonPressed() {
    context.push(AppRouterNames.settings, extra: true);
  }

  @override
  void didUpdateWidget(covariant PhotoPreviewPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _loadValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: widget.image == null
                ? const Text("No photo captured")
                : Image.file(
                    File(widget.image!.path),
                    fit: BoxFit.contain,
                  ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 12, right: 25, left: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: SvgPicture.asset(
                      SvgAssets.icBack,
                      colorFilter: ColorFilter.mode(AppColors.greyCC, BlendMode.srcIn),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => context.push(AppRouterNames.settings),
                    child: SvgPicture.asset(SvgAssets.icSettings),
                  ),
                ],
              ),
            ),
          ),
          if (!_isAppUnlocked)
            Positioned(
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
                      child: _isBannerAdLoaded == true
                          ? AdWidget(ad: _bannerAd)
                          : _isBannerAdLoaded == null
                              ? CircularProgressIndicator(color: AppColors.white)
                              : Text("Could not load the ads"),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }
}