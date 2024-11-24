import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:camera/camera.dart';

import '../../core/app_assets.dart';
import '../../core/app_colors.dart';
import '../../core/app_paddings.dart';
import '../../core/router/app_router_names.dart';
import 'widgets/camera_not_found_state.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late List<CameraDescription> cameras;

  bool _isCameraAvailable = true;
  bool _isCameraInitialized = false;
  int _selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isCameraAvailable) {
      return Scaffold(
        body: Center(
          child: Stack(
            children: [
              CameraNotFoundState(),
              _configurationItems(false),
            ],
          ),
        ),
      );
    }

    if (!_isCameraInitialized) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            CameraPreview(_controller),
            _configurationItems(true),
          ],
        ),
      ),
    );
  }

  Widget _configurationItems(bool showTakePhoto) {
    return Positioned.fill(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SafeArea(
            child: Padding(
              padding: AppPaddings.horizontalTop,
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
                    onTap: _switchCamera,
                    child: Image.asset(width: 44, height: 44, PngAssets.icReverse),
                  ),
                ],
              ),
            ),
          ),
          if (showTakePhoto)
            GestureDetector(
              onTap: _takePhoto,
              child: SvgPicture.asset(SvgAssets.takePhotoButton),
            ),
        ],
      ),
    );
  }

  Future<void> _initializeCamera() async {
    try {
      cameras = await availableCameras();

      if (cameras.isEmpty) {
        setState(() => _isCameraAvailable = false);
        return;
      }

      await _setCamera(cameras[_selectedCameraIndex]);
    } catch (e) {
      log("Error initializing camera: $e");
      setState(() => _isCameraAvailable = false);
    }
  }

  Future<void> _setCamera(CameraDescription camera) async {
    _controller = CameraController(camera, ResolutionPreset.high);

    try {
      await _controller.initialize();
      setState(() => _isCameraInitialized = true);
    } catch (e) {
      log("Error initializing selected camera: $e");
      setState(() => _isCameraAvailable = false);
    }
  }

  Future<void> _takePhoto() async {
    try {
      if (!_controller.value.isInitialized) return;

      final XFile photo = await _controller.takePicture();

      if (mounted) {
        context.push(AppRouterNames.photoPreview, extra: photo);
      }
    } catch (e) {
      log("Error capturing photo: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error capturing photo")),
        );
      }
    }
  }

  void _switchCamera() async {
    if (cameras.length > 1) {
      setState(() {
        _isCameraInitialized = false;
        _selectedCameraIndex = (_selectedCameraIndex + 1) % cameras.length;
      });

      await _setCamera(cameras[_selectedCameraIndex]);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No other camera available")),
      );
    }
  }

  @override
  void dispose() {
    if (_isCameraAvailable) {
      _controller.dispose();
    }
    super.dispose();
  }
}
