import 'package:easacc_task/core/helper_fun/error_snack_bar.dart';
import 'package:easacc_task/core/services/shared_preferences_singleton.dart';
import 'package:easacc_task/features/settings/presentation/views/webview_screen.dart';
import 'package:flutter/material.dart';

class URLTextField extends StatefulWidget {
  const URLTextField({
    super.key, required this.controller,  this.onSaved,
  });

  final TextEditingController controller;
  final ValueChanged<String?>? onSaved;

  @override
  State<URLTextField> createState() => _URLTextFieldState();
}

class _URLTextFieldState extends State<URLTextField> {
  final _formKey = GlobalKey<FormState>();
  final scrollController = ScrollController();
  bool readOnly = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      scrollController.jumpTo(0);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            onTap: (){
              if (_formKey.currentState!.validate()) {
                showErrorBar(context, "VALID URL: ${widget.controller.text}");
                if(readOnly && widget.controller.text.isNotEmpty) Navigator.pushNamed(context, WebviewScreen.routeName, arguments: widget.controller.text.trim());
              }
            },
            style: readOnly? TextStyle(color: Colors.grey.shade500): null,
            controller: widget.controller,
            scrollController: scrollController,
            onSaved: widget.onSaved,
            readOnly: readOnly,
            keyboardType: TextInputType.url,
            cursorColor: Colors.black,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'URL is required';
              }
              if (!isValidUrl(value)) {
                return 'Enter a valid URL (must start with http/https)';
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: 'Enter The URL...',
              hintStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey.shade500),
              suffixIcon: InkWell(onTap:(){
                setState(() {
                  readOnly = !readOnly;
                  if(readOnly){
                    AppPrefs.setString('url', widget.controller.text.trim());
                  }
                  widget.controller.selection = TextSelection.collapsed(offset: 0);
                  scrollController.jumpTo(0);
                });
              },child: Icon(Icons.edit, color: readOnly? Colors.grey.shade500 : null,)),
              filled: true,
              fillColor: Color(0xffF9FAFA),
              border: buildBorder(),
              enabledBorder:  buildBorder(),
              focusedBorder:  buildBorder(),
            ),
          ),
        ],
      ),
    );
  }
}

OutlineInputBorder buildBorder(){
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: BorderSide(
        color: Color(0xffE6E9EA),
        width: 1
    ),
  );
}

bool isValidUrl(String url) {
  final uri = Uri.tryParse(url);
  return uri != null &&
      (uri.isScheme("http") || uri.isScheme("https")) &&
      uri.host.isNotEmpty;
}