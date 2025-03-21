import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/extensions/string.dart';
import '../../utils/extensions/num.dart';
import '../../theme/app_pallete.dart';
import '../classes/thousands_seperator_input_formatter.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final bool isNumericField;
  final bool readOnly;
  final int? limit;
  final bool isPasswordField;
  final bool isPinField;
  final bool isAmountField;
  final num? maxAllowedNumValue;
  final num? minAllowedNumValue;

  const CustomTextField({
    super.key,
    required this.textEditingController,
    required this.hintText,
    this.isNumericField = false,
    this.readOnly = false,
    this.limit,
    this.isPasswordField = false,
    this.isPinField = false,
    this.isAmountField = false,
    this.maxAllowedNumValue,
    this.minAllowedNumValue,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  FocusNode focusNode = FocusNode();
  var hintText = "";
  var _passwordVisible = false;

  _CustomTextFieldState();

  @override
  void initState() {
    super.initState();
    _passwordVisible = widget.isPasswordField;
    focusNode.addListener(() {
      hintText = focusNode.hasFocus ? '' : widget.hintText;
      setState(() {});
    });
  }

  TextInputType _inputType() {
    if (widget.isNumericField) {
      return const TextInputType.numberWithOptions(decimal: true, signed: true);
    } else {
      return TextInputType.text;
    }
  }

  List<TextInputFormatter>? _textInputFormatter() {
    if (widget.isAmountField) {
      return [
        ThousandsSeparatorInputFormatter()
      ];
    } else if (widget.isNumericField) {
      return [
        FilteringTextInputFormatter.allow(
          RegExp(
            //r'^[-]{0,1}[0-9]*[,]?[0-9]*', //signed regex
            r'^[0-9]*[.]?[0-9]*',
          ),
        ),
      ];
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.readOnly,
      focusNode: focusNode,
      controller: widget.textEditingController,
      keyboardType: widget.isPinField ? TextInputType.number : _inputType(),
      inputFormatters: _textInputFormatter(),
      maxLength: widget.limit,
      obscureText: _passwordVisible,
      validator: (value) {
        if (value!.isEmpty) {
          return "${widget.hintText} is required";
        }
        else if (widget.isNumericField && !widget.readOnly && ((widget.isAmountField ? value.amountValue : value).toDouble() == 0)) {
          return "${widget.hintText} can't be zero";
        }
        else if (widget.isNumericField && widget.maxAllowedNumValue != null && value.amountValue.toNum() > (widget.maxAllowedNumValue ?? double.maxFinite)) {
          return "${widget.hintText} can't exceed from ${widget.maxAllowedNumValue?.toISFormatNumber()}";
        }
        else if (widget.isNumericField && widget.minAllowedNumValue != null && value.amountValue.toNum() < (widget.minAllowedNumValue ?? 0)) {
          return "${widget.hintText} can't below from ${widget.minAllowedNumValue?.toISFormatNumber()}";
        }
        else
          return null;
      },
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: InputDecoration(
        counterText: '',
        labelText: widget.hintText,
        hintText: hintText,
        suffixIcon: !widget.isPasswordField
            ? null
            : IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: AppPalette.primaryButtonTextColor,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
    );
  }
}
