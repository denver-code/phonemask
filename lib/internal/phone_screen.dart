import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({Key? key}) : super(key: key);

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final textController = TextEditingController();

  int charLength = 0;

  bool status = false;

  var maskFormatter = MaskTextInputFormatter(
      mask: '(###) ###-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  _onChanged(String value) {
    setState(() {
      charLength = maskFormatter.getUnmaskedText().length;
    });

    if (charLength == 10) {
      setState(() {
        status = true;
      });
    } else {
      setState(() {
        status = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 4,
          ),
          Container(
            // height: MediaQuery.of(context).size.height / 14,
            alignment: Alignment.center,
            child: const Text("Get Started",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600)),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 15,
          ),
          Expanded(
              child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  inputFormatters: [maskFormatter],
                  controller: textController,
                  autocorrect: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: '(201) 555-0123',
                    helperText: "Enter your phone number",
                    suffixIcon: IconButton(
                      onPressed: textController.clear,
                      icon: const Icon(Icons.clear),
                    ),
                  ),
                  onChanged: _onChanged,
                )
              ],
            ),
          )),
          Visibility(
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: status,
              child: Container(
                  alignment: Alignment.bottomRight,
                  margin: const EdgeInsets.only(top: 20, right: 20, bottom: 20),
                  child: RawMaterialButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Row(
                          children: [
                            Text(
                                "Masked: ${maskFormatter.getMaskedText()} UnMasked: ${maskFormatter.getUnmaskedText()}"),
                          ],
                        )),
                      );
                    },
                    elevation: 2.0,
                    fillColor: Colors.blue,
                    child: const Icon(
                      Icons.arrow_right,
                      size: 35.0,
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(15.0),
                    shape: const CircleBorder(),
                  ))),
        ],
      )),
    );
  }
}
