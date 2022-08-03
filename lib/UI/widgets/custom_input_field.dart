import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

class CustomInputField extends StatefulWidget {
  final void Function(String)? onChanged;
  final String label;
  final TextInputType? inputType;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  const CustomInputField({
    Key? key,
    this.onChanged,
    required this.label,
    this.inputType,
    this.isPassword = false,
    this.validator,
    this.controller}) : super(key: key);

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late bool _obscureText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
        validator: widget.validator,
        autovalidateMode: AutovalidateMode.always,
        builder: (state){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            TextField(
              cursorColor: Colors.brown,
              controller: widget.controller,
              obscureText: _obscureText,
              keyboardType: widget.inputType,
              onChanged: (text){
                if(widget.validator != null){
                  // ignore: invalid_use_of_protected_member
                  state.setValue(text);
                  state.validate();
                }
                if(widget.onChanged != null){
                  widget.onChanged!(text);
                }
              },
              decoration: InputDecoration(
                labelText: widget.label,
                floatingLabelStyle: MaterialStateTextStyle.resolveWith((states) {
                  return const TextStyle(color: Colors.brown);
                }),
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
                suffixIcon: widget.isPassword? CupertinoButton(
                    child: Icon(_obscureText? Icons.visibility_off : Icons.visibility, color: Colors.orange,),
                    onPressed: (){
                      _obscureText = !_obscureText;
                      setState((){});
                    }
                    )
                    : Container(
                       width: 0,
                )
              ),
            ),
              state.hasError?
                Text(
                  state.errorText!,
                  style: const TextStyle(color: Colors.red)) : const Text('')
            ]
          );
        }
    );



  }
}


