import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:real_estates_app/models/house.dart';
import 'package:real_estates_app/providers/home_provier.dart';
import 'package:real_estates_app/services/api_service.dart';

import '../widgets/my_app_bar.dart';
import '../widgets/drop_down_card.dart';
import '../services/image_getter.dart';

class NewPostScreen extends StatefulWidget {
  static const routeName = '/new-post';
  @override
  _NewPostScreenState createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final _priceController = TextEditingController();
  final _latController = TextEditingController();
  final _longController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> authData = {};
  Size size;
  Color primaryColor;
  List<FilePickerResult> images = [];
  List<String> urlImages = [];
  FilePickerResult image;
  String urlMain;
  String badRoomsNum;
  String bathRoomsNum;
  String floorsNum;

  void _saveForm() async {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    authData['base_image'] = urlMain;
    authData['other_image'] = urlImages;
    authData['bedrooms'] = int.parse(badRoomsNum);
    authData['bathrooms'] = int.parse(bathRoomsNum);
    authData['floors'] = int.parse(floorsNum);
    await Provider.of<HomeProvider>(context, listen: false)
        .storeHouse(3, authData);
    // log(authData.toString());
    // log(urlMain);
    // log(urlImages.toString());
  }

  @override
  void dispose() {
    _priceController.dispose();
    _latController.dispose();
    _longController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    badRoomsNum = '1';
    bathRoomsNum = '1';
    floorsNum = '1';

    super.initState();
  }

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    primaryColor = Theme.of(context).primaryColor;
    super.didChangeDependencies();
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
          child: Form(
            key: _formKey,
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
                      dropDownValue: bathRoomsNum,
                    ),
                    DropDownCard<String>(
                      dropList: ['1', '2', '3', '4', '5', '6', '7', '8'],
                      title: "Bedrooms",
                      dropDownValue: badRoomsNum,
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
                      dropDownValue: floorsNum,
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
                      name: 'sqft_living',
                      context: context),
                ),
                SizedBox(
                  height: 16,
                ),
                Center(
                  child: customTextField(
                      hint: 'Enter the basement area in (sq ft)',
                      label: 'Basement area',
                      name: 'sqft_basement',
                      context: context),
                ),
                SizedBox(
                  height: 16,
                ),
                Center(
                  child: customTextField(
                      hint: 'The area above the ground in (sq ft)',
                      label: 'Above ground area',
                      context: context,
                      name: 'sqft_above'),
                ),
                SizedBox(
                  height: 16,
                ),
                Center(
                  child: customTextField(
                      hint: 'Zipcode example \"98178\" ',
                      label: 'Zipcode',
                      name: 'zipcode',
                      context: context),
                ),
                SizedBox(
                  height: 16,
                ),
                Center(
                  child: Container(
                    width: size.width * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customTextField(
                            label: 'Lattitude',
                            context: context,
                            name: 'lattitude',
                            controller: _latController,
                            widthFraction: 0.4),
                        customTextField(
                            label: 'Longitude',
                            context: context,
                            name: 'longitude',
                            controller: _longController,
                            widthFraction: 0.4),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: size.width * 0.9,
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
                      name: 'street_address',
                      isLetterInput: true,
                      hint: 'Example \"Boston-132Ast\"'),
                ),
                SizedBox(
                  height: 16,
                ),
                Center(
                  child: Container(
                    // height: size.height * 0.4,
                    child: customTextField(
                      label: 'Description',
                      name: 'description',
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
                    name: 'price',
                    controller: _priceController,
                  ),
                ),
                Center(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: size.width * 0.9,
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
                Center(
                  child: Container(
                    width: size.width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Main Image:",
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
                          Center(
                            child: GestureDetector(
                              onTap: () async {
                                FilePickerResult result =
                                    await ImageGetter().getImage();
                                String url;
                                if (result != null)
                                  url =
                                      await ImageGetter().uploadImageToFirebase(
                                    context: context,
                                    pickedFile: result,
                                    folderName: 'Main House Images',
                                  );
                                setState(
                                  () {
                                    if (result != null) {
                                      image = result;
                                      urlMain = url;
                                    }
                                  },
                                );
                              },
                              child: Container(
                                width: size.width * 0.8,
                                height: size.width * 0.8,
                                margin: EdgeInsets.all(8),
                                padding: EdgeInsets.all(
                                    (image == null) ? size.width * 0.25 : 0),
                                decoration: BoxDecoration(
                                  border: (image == null)
                                      ? Border.all(
                                          width: 1,
                                          color: primaryColor,
                                        )
                                      : null,
                                  image: (image != null)
                                      ? DecorationImage(
                                          image: Image.file(
                                            File(
                                              image.files.first.path,
                                            ),
                                          ).image,
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: (image == null)
                                    ? Icon(
                                        Icons.add,
                                        color: primaryColor,
                                      )
                                    : Container(),
                              ),
                            ),
                          ),
                          Text(
                            'Room Images:',
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.w400,
                                fontSize: 18),
                          ),
                          Container(
                            height: 175,
                            width: size.width * .8,
                            child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1),
                              itemBuilder: (_, index) {
                                return Center(
                                  child: (images.length - 1 < index)
                                      ? GestureDetector(
                                          onTap: () async {
                                            FilePickerResult filePickerResult =
                                                await ImageGetter().getImage();
                                            String url;
                                            if (filePickerResult != null)
                                              url = await ImageGetter()
                                                  .uploadImageToFirebase(
                                                context: context,
                                                pickedFile: filePickerResult,
                                                folderName: 'Room Images',
                                              );
                                            setState(() {
                                              if (filePickerResult != null) {
                                                images.add(filePickerResult);
                                                urlImages.add(url);
                                              }
                                            });
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(8),
                                            padding: EdgeInsets.all(
                                                size.width * 0.2),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 1,
                                                color: primaryColor,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.add,
                                                color: primaryColor,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          margin: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: Image.file(
                                                File(
                                                  images[index]
                                                      .files
                                                      .first
                                                      .path,
                                                ),
                                              ).image,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                );
                              },
                              itemCount: images.length + 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Center(
                  child: Container(
                    width: size.width * 0.5,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _saveForm,
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
      ),
    );
  }

  String notEmptyValidator(String input) {
    if (input.isEmpty) return "Please provide a value.";
    return null;
  }

  Widget customTextField({
    @required String label,
    @required BuildContext context,
    @required String name,
    String hint = '',
    double widthFraction = 0.9,
    bool isLetterInput = false,
    bool isMultiLine = false,
    TextEditingController controller,
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
        validator: notEmptyValidator,
        controller:
            (name == 'price' || name == 'lattitude' || name == 'longitude')
                ? controller
                : null,

        keyboardType: isLetterInput
            ? (isMultiLine ? TextInputType.multiline : TextInputType.text)
            : TextInputType.number,
        maxLines: isMultiLine ? null : 1,
        onSaved: (value) {
          (isLetterInput || name == 'lattitude' || name == 'longitude')
              ? authData[name] = value
              : authData[name] = int.parse(value);
          ;
        },
        // inputFormatters: <TextInputFormatter>[
        //   FilteringTextInputFormatter
        // ],
      ),
    );
  }

  getPriceEstimates(
      {double thetaBedrooms,
      double thetaBathrooms,
      double thetaSqftLiving,
      double thetafloors,
      double thetaWaterFront,
      double thetaView,
      double thetaSqftLot,
      double thetaCondition,
      double thetaGrade,
      double thetaSqftAbove,
      double thetaSqftBasement,
      double thetaYrBuilt,
      double thetaYearRenovated,
      double thetaZipcode,
      double thetaLat,
      double thetaLong,
      double thetaSqftLiving15,
      double thetaSqftLot15}) {}
}
