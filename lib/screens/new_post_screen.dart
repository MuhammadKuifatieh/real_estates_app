import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/my_app_bar.dart';
import '../widgets/drop_down_card.dart';

class NewPostScreen extends StatefulWidget {
  static const routName = '/new-post';
  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        context: context,
        title: 'New Post',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DropDownCard<String>(
                    dropList: ['1', '2', '3', '4', '5', '6', '7', '8'],
                    title: "Bathrooms",
                  ),
                  DropDownCard<String>(
                    dropList: ['1', '2', '3', '4', '5', '6', '7', '8'],
                    title: "Bedrooms",
                  )
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DropDownCard<String>(
                    dropList: ['1', '2', '3', '4'],
                    title: "Floors",
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Center(
                // mainAxisSize: MainAxisSize.max,
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                child: customTextField(
                    hint: 'Enter the living room area in (sq ft)',
                    label: 'Living room area',
                    context: context),
              ),
              SizedBox(
                height: 16,
              ),
              Center(
                child: customTextField(
                    hint: 'Enter the basement area in (sq ft)',
                    label: 'Basement area',
                    context: context),
              ),
              SizedBox(
                height: 16,
              ),
              Center(
                child: customTextField(
                    hint: 'The area above the ground in (sq ft)',
                    label: 'Above ground area',
                    context: context),
              ),
              SizedBox(
                height: 16,
              ),
              Center(
                child: customTextField(
                    hint: 'Zipcode example \"98178\" ',
                    label: 'Zipcode',
                    context: context),
              ),
              SizedBox(
                height: 16,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customTextField(
                          label: 'Latitude',
                          context: context,
                          widthFraction: 0.4),
                      customTextField(
                          label: 'Longitude',
                          context: context,
                          widthFraction: 0.4),
                    ],
                  ),
                ),
              ),
              Center(
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {},
                    child: Text('Get your location Automatically'),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Center(
                child: customTextField(
                    label: 'Streed Adderss',
                    context: context,
                    isLetterInput: true,
                    hint: 'Example \"Boston-132Ast\"'),
              ),
              SizedBox(
                height: 16,
              ),
              Center(
                child: Container(
                  // height: MediaQuery.of(context).size.height * 0.4,
                  child: customTextField(
                    label: 'Description',
                    context: context,
                    isLetterInput: true,
                    isMultiLine: true,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Center(
                child: customTextField(
                  label: 'Price',
                  hint: 'Enter the price in USD (\$)',
                  context: context,
                ),
              ),
              Center(
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: TextButton(
                    onPressed: () {},
                    child: Text('Estimate your house price'),
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'POST',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget customTextField({
  @required String label,
  @required BuildContext context,
  String hint = '',
  double widthFraction = 0.9,
  bool isLetterInput = false,
  bool isMultiLine = false,
}) {
  return Container(
    width: MediaQuery.of(context).size.width * widthFraction,
    child: TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.blueGrey,
        ),
      ),

      keyboardType: isLetterInput
          ? (isMultiLine ? TextInputType.multiline : TextInputType.text)
          : TextInputType.number,
      maxLines: isMultiLine ? null : 1,
      // inputFormatters: <TextInputFormatter>[
      //   FilteringTextInputFormatter
      // ],
    ),
  );
}
