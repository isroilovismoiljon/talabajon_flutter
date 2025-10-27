import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/colors.dart';
import '../../../core/routing/routes.dart';

enum OtpState { neutral, error, success }

class OtpInput extends StatefulWidget {
  final int length;
  final String correctOtp;
  final double? fieldWidth;
  final double? fieldHeight;

  const OtpInput({
    super.key,
    this.length = 4,
    this.correctOtp = '1122', // Default for testing
    this.fieldWidth = 56,
    this.fieldHeight = 56,
  });

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  OtpState _state = OtpState.neutral;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());

    for (int i = 0; i < widget.length; i++) {
      _controllers[i].addListener(() => _onTextChanged(i));
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onTextChanged(int index) {
    final text = _controllers[index].text;

    if (text.isEmpty) {
      if (index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    } else if (text.length == 1) {
      if (index < widget.length - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
        _validateOtp();
      }
    } else if (text.length > 1) {
      _handlePaste(index, text);
    }
  }

  void _handlePaste(int startIndex, String pastedText) {
    final digits = pastedText.replaceAll(RegExp(r'\D'), '');

    for (int i = 0; i < digits.length && (startIndex + i) < widget.length; i++) {
      _controllers[startIndex + i].text = digits[i];
    }

    // Focus the last filled field or the next empty one
    final lastIndex = (startIndex + digits.length - 1).clamp(0, widget.length - 1);
    if (lastIndex < widget.length - 1) {
      _focusNodes[lastIndex + 1].requestFocus();
    } else {
      _focusNodes[lastIndex].unfocus();
      // Validate if all fields are filled
      if (_getOtpCode().length == widget.length) {
        _validateOtp();
      }
    }
  }

  void _validateOtp() {
    final code = _getOtpCode();
    if (code.length != widget.length) return;

    if (code == widget.correctOtp) {
      // Success
      setState(() {
        _state = OtpState.success;
      });
      
      // Wait 2 seconds then navigate to login
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          context.go(Routes.login);
        }
      });
    } else {
      // Error
      setState(() {
        _state = OtpState.error;
      });
      
      // Wait a moment to show error, then clear and reset
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          _clearFields();
          setState(() {
            _state = OtpState.neutral;
          });
        }
      });
    }
  }

  void _clearFields() {
    for (var controller in _controllers) {
      controller.clear();
    }
    _focusNodes[0].requestFocus();
  }

  String _getOtpCode() {
    return _controllers.map((c) => c.text).join();
  }

  Color _getBorderColor() {
    switch (_state) {
      case OtpState.error:
        return AppColors.otpErrorBorder;
      case OtpState.success:
        return AppColors.otpSuccessBorder;
      case OtpState.neutral:
        return AppColors.otpNeutralBorder;
    }
  }

  Color _getTextColor() {
    switch (_state) {
      case OtpState.error:
        return AppColors.otpErrorText;
      case OtpState.success:
        return AppColors.otpSuccessText;
      case OtpState.neutral:
        return AppColors.otpNeutralText;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: widget.fieldWidth,
          height: widget.fieldHeight,
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: _getTextColor(),
            ),
            decoration: InputDecoration(
              counterText: '',
              filled: true,
              fillColor: AppColors.otpBackground,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: _getBorderColor(),
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: _getBorderColor(),
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: _getBorderColor(),
                  width: 2,
                ),
              ),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onTap: () {
              // Place cursor at the end
              _controllers[index].selection = TextSelection.fromPosition(
                TextPosition(offset: _controllers[index].text.length),
              );
            },
          ),
        );
      }),
    );
  }
}
