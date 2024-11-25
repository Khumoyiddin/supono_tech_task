import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_text_styles.dart';
import '../../../core/network/shared_prefs.dart';
import '../widgets/nickname_text_field.dart';

class NicknameScreen extends StatefulWidget {
  final Function() onPressed;

  const NicknameScreen({super.key, required this.onPressed});

  @override
  State<NicknameScreen> createState() => _NicknameScreenState();
}

class _NicknameScreenState extends State<NicknameScreen> with AutomaticKeepAliveClientMixin {
  final _controller = TextEditingController();
  bool? showErrorMessage;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_removeErrorMessage);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choose your \nnickname',
          style: AppTextStyles.onboarding30,
        ),
        SizedBox(height: showErrorMessage == true ? 20 : 58),
        NicknameTextField(controller: _controller),
        if (showErrorMessage == true) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Please enter a nickname to proceed.',
              style: AppTextStyles.onboarding16.copyWith(color: Colors.red),
            ),
          ),
        ],
        const Spacer(),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: IconButton(
              onPressed: () async {
                if (_isInputValid()) {
                  setState(() => showErrorMessage = false);
                  FocusScope.of(context).unfocus();

                  await _saveNickname();

                  widget.onPressed();
                } else {
                  setState(() => showErrorMessage = true);
                }
              },
              style: IconButton.styleFrom(
                fixedSize: const Size(50, 50),
                backgroundColor: AppColors.white,
                shape: const CircleBorder(),
              ),
              icon: const Center(child: Icon(CupertinoIcons.arrow_right)),
            ),
          ),
        ),
        const SizedBox(height: 17),
      ],
    );
  }

  void _removeErrorMessage() {
    if (showErrorMessage == true) {
      setState(() => showErrorMessage = false);
    }
  }

  bool _isInputValid() {
    return _controller.text.trim().isNotEmpty;
  }

  Future<void> _saveNickname() async {
    try {
      final prefs = SharedPreferencesHelper.instance;
      await prefs.setNickname(_controller.text.trim());
    } catch (e) {
      log('Exception caught in nickname screen $e');
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_removeErrorMessage);
    _controller.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
