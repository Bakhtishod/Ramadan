import 'package:drop_down_list/drop_down_list.dart';
import 'package:flutter/material.dart';
import 'package:ramadan/data/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({
    Key? key,
  }) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final List<SelectedListItem> _listOfCities = [
    SelectedListItem(false, "Toshkent"),
    SelectedListItem(false, "Buxoro"),
    SelectedListItem(false, "Farg'ona"),
    SelectedListItem(false, "Guliston"),
    SelectedListItem(false, "Jizzax"),
    SelectedListItem(false, "Navoiy"),
    SelectedListItem(false, "Nukus"),
    SelectedListItem(false, "Samarqand"),
    SelectedListItem(false, "Termiz"),
    SelectedListItem(false, "Qarshi"),
    SelectedListItem(false, "Andijon"),
    SelectedListItem(false, "Namangan"),
    SelectedListItem(false, "Urganch"),
  ];

  /// This is register text field controllers.
  final TextEditingController _fullNameTextEditingController =
      TextEditingController();
  final TextEditingController _cityTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _fullNameTextEditingController.dispose();
    _cityTextEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: _mainBody(),
      ),
    );
  }

  Widget _mainBody() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 30.0,
          ),
          Row(
            children: [
              Text(
                "Ro'yxatdan o'tish",
                style: TextStyle(
                  color: mainColor,
                  fontSize: 30,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Image.asset(
                "assets/images/logo.png",
                width: 30,
                height: 30,
              )
            ],
          ),
          const SizedBox(
            height: 15.0,
          ),
          AppTextField(
            textEditingController: _fullNameTextEditingController,
            title: "Ismingizni kiriting",
            hint: "Ism",
            isCitySelected: false,
          ),
          AppTextField(
            textEditingController: _cityTextEditingController,
            title: "Shaharni kiriting",
            hint: "Shahar",
            isCitySelected: true,
            cities: _listOfCities,
          ),
          const SizedBox(
            height: 15.0,
          ),
          _AppElevatedButton(
            name: _fullNameTextEditingController.text,
          ),
          Expanded(child: SizedBox()),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.blue, width: 1)),
            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
            alignment: Alignment.bottomCenter,
            child: RichText(
              softWrap: true,
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: "Dasturchi: ",
                  style: TextStyle(
                      fontFamily: "Roboto", color: mainColor, fontSize: 20),
                  children: [
                    TextSpan(
                        text: "</Bakhtishod",
                        style: TextStyle(
                            fontFamily: "Roboto",
                            color: mainColor,
                            fontSize: 20)),
                    TextSpan(
                        text: "Dev>",
                        style: TextStyle(
                            fontFamily: "Roboto",
                            color: Colors.greenAccent,
                            fontSize: 20)),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}

class AppTextField extends StatefulWidget {
  TextEditingController textEditingController = TextEditingController();
  final String title;
  final String hint;
  final bool isCitySelected;
  final List<SelectedListItem>? cities;

  AppTextField({
    required this.textEditingController,
    required this.title,
    required this.hint,
    required this.isCitySelected,
    this.cities,
    Key? key,
  }) : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  TextEditingController _searchTextEditingController = TextEditingController();

  void onTextFieldTap() {
    DropDownState(
      DropDown(
        submitButtonText: "Done",
        submitButtonColor: mainColor,
        searchHintText: "Qidirmoq",
        bottomSheetTitle: "Shaharlar",
        searchBackgroundColor: Colors.black12,
        dataList: widget.cities ?? [],
        selectedItems: (List<dynamic> selectedList) {
        },
        selectedItem: (String selected) async {
          widget.textEditingController.text = selected;
          final SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString("cityName", selected);
        },
        enableMultipleSelection: false,
        searchController: _searchTextEditingController,
      ),
    ).showModal(context);
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style:
              TextStyle(fontFamily: "Roboto", fontSize: 16, color: mainColor),
        ),
        const SizedBox(
          height: 5.0,
        ),
        TextFormField(
          controller: widget.textEditingController,
          cursorColor: mainColor,
          onTap: widget.isCitySelected
              ? () {
                  FocusScope.of(context).unfocus();
                  onTextFieldTap();
                }
              : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black12,
            contentPadding:
                const EdgeInsets.only(left: 8, bottom: 0, top: 0, right: 8),
            hintStyle: TextStyle(color: Colors.blueAccent),
            hintText: widget.hint,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: mainColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueAccent),
            ),
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
      ],
    );
  }
}

class _AppElevatedButton extends StatelessWidget {
  String name;
  _AppElevatedButton({Key? key, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 44.0,
        child: ElevatedButton(
          onPressed: () async {
            final SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.setString("name", name);
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return HomeScreen();
            }));
          },
          child: Text(
            "Ro'yxatdan o'tish".toUpperCase(),
            style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                fontFamily: "Roboto"),
          ),
          // style: ElevatedButton.styleFrom(
          //   primary: mainColor,
          //   textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          // ),
        ),
      ),
    );
  }
}
