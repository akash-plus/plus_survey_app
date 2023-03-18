import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:plus/Utils/constant_color.dart';
import 'package:PLUS/views/SurveyForm/submit_survey.dart';
import 'dart:async';

class SurveyFormScreen extends StatefulWidget {
  const SurveyFormScreen({super.key});

  @override
  State<SurveyFormScreen> createState() => _SurveyFormScreenState();
}

class _SurveyFormScreenState extends State<SurveyFormScreen> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final cityController = TextEditingController();
  final maritalStatusController = TextEditingController();
  final monthlyIncomeController = TextEditingController();
  final workingStatusController = TextEditingController();
  final savingPlanController = TextEditingController();
  final joinWhatsappGroupController = TextEditingController();

  final firstPageformKey = GlobalKey<FormState>();
  final secondPageformKey = GlobalKey<FormState>();
  String? marriedStatus;
  String? income;
  String? working;
  bool isFirstPage = true;
  bool isLoading = false;
  List<String> yesNo = ["Yes", "No"];
  List<MaritalStatus> maritalStatus = [
    MaritalStatus(key: "married", value: "Married"),
    MaritalStatus(key: "unmarried", value: "Unmarried"),
    MaritalStatus(key: "married_with_kids", value: "Married With Kids"),
    MaritalStatus(key: "other", value: "Other"),
  ];

  List<MonthlyIncome> monthlyIncome = [
    MonthlyIncome(key: "less_than_30k", value: "Less than 30000"),
    MonthlyIncome(key: "30k_60k", value: "30000 - 60000"),
    MonthlyIncome(key: "61k_120k", value: "60000 - 120000"),
    MonthlyIncome(key: "greater_than_120K", value: "More than 120000"),
  ];
  List<WorkingStatus> workingStatus = [
    WorkingStatus(key: "private_sector", value: "Private sector"),
    WorkingStatus(key: "public_sector", value: "Public sector"),
    WorkingStatus(key: "business", value: "Business"),
    WorkingStatus(key: "housemaker", value: "Housemaker"),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          body: SizedBox(
            height: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          "assets/allimages/splash_image_4.png",
                          height: 150,
                        ),
                        Text(
                          "User Survey | Powered by GetPlus",
                          textScaleFactor: 1.0,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    if (isFirstPage) formOneWidget(),
                    if (!isFirstPage) formTwoWidget(),
                    if (isFirstPage)
                      Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.blue,
                            ),
                          ),
                          onPressed: () {
                            if (firstPageformKey.currentState!.validate()) {
                              isFirstPage = false;
                              setState(() {});
                              debugPrint("IS FIRST PAGE -> $isFirstPage");
                            }
                          },
                          child: Text(
                            "Next",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    if (!isFirstPage)
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(vertical: 20.0)
                                  .copyWith(left: 20, right: 5.0),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.blue,
                                  ),
                                ),
                                onPressed: () {
                                  isFirstPage = true;
                                  setState(() {});
                                  debugPrint("IS FIRST PAGE -> $isFirstPage");
                                },
                                child: Text(
                                  "Previous",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(vertical: 20.0)
                                  .copyWith(left: 5.0, right: 20.0),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.blue,
                                  ),
                                ),
                                onPressed: () {
                                  if (secondPageformKey.currentState!
                                      .validate()) {
                                    isLoading = true;
                                    setState(() {});
                                    apiCall(context);
                                  }
                                },
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                  ],
                ),
              ),
            ),
          ),
        ),
        if (isLoading)
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            ),
          )
      ],
    );
  }

  Widget formOneWidget() => Form(
        key: firstPageformKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Name",
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              TextFormField(
                cursorWidth: 1.0,
                controller: nameController,
                cursorColor: Colors.black,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      // color: Colors.black,
                      color: Colors.amber,
                      width: 1,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter name";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Age",
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              TextFormField(
                controller: ageController,
                cursorWidth: 1.0,
                cursorColor: Colors.black,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      // color: Colors.black,
                      color: Colors.amber,
                      width: 1,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter age";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Phone",
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              TextFormField(
                controller: phoneController,
                cursorWidth: 1.0,
                cursorColor: Colors.black,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      // color: Colors.black,
                      color: Colors.amber,
                      width: 1,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter phone";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Email",
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              TextFormField(
                cursorWidth: 1.0,
                cursorColor: Colors.black,
                controller: emailController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      // color: Colors.black,
                      color: Colors.amber,
                      width: 1,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter email";
                  } else if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                    return "Please enter valid email";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "City",
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              TextFormField(
                cursorWidth: 1.0,
                controller: cityController,
                cursorColor: Colors.black,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      // color: Colors.black,
                      color: Colors.amber,
                      width: 1,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter city";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Marital Status:",
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              TextFormField(
                readOnly: true,
                cursorWidth: 1.0,
                controller: maritalStatusController,
                cursorColor: Colors.black,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.arrow_drop_down,
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      // color: Colors.black,
                      color: Colors.amber,
                      width: 1,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please select marital status";
                  }
                  return null;
                },
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => SimpleDialog(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 15.0),
                                child: Text(
                                  "Please select",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              ...maritalStatus.map((e) {
                                return GestureDetector(
                                  onTap: () {
                                    marriedStatus = e.key;
                                    maritalStatusController.text =
                                        e.value.toString();
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 10),
                                    child: Text(
                                      e.value.toString(),
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList()
                            ],
                          ));
                },
              ),
              SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ),
      );

  Widget formTwoWidget() => Form(
        key: secondPageformKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Your Monthly Income",
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              TextFormField(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => SimpleDialog(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 15.0),
                                child: Text(
                                  "Please select",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              ...monthlyIncome.map((e) {
                                return GestureDetector(
                                  onTap: () {
                                    income = e.key;
                                    monthlyIncomeController.text =
                                        e.value.toString();
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 10),
                                    child: Text(
                                      e.value.toString(),
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList()
                            ],
                          ));
                },
                readOnly: true,
                cursorWidth: 1.0,
                controller: monthlyIncomeController,
                cursorColor: Colors.black,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  hintText: "Select your income range",
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      // color: Colors.black,
                      color: Colors.amber,
                      width: 1,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: Icon(
                    Icons.arrow_drop_down,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please Select your income range";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Working Status",
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              TextFormField(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => SimpleDialog(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 15.0),
                                child: Text(
                                  "Please select",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              ...workingStatus.map((e) {
                                return GestureDetector(
                                  onTap: () {
                                    working = e.key;
                                    workingStatusController.text =
                                        e.value.toString();
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 10),
                                    child: Text(
                                      e.value.toString(),
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList()
                            ],
                          ));
                },
                readOnly: true,
                cursorWidth: 1.0,
                controller: workingStatusController,
                cursorColor: Colors.black,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  hintText: "Select your working status",
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                  suffixIcon: Icon(
                    Icons.arrow_drop_down,
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      // color: Colors.black,
                      color: Colors.amber,
                      width: 1,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please select your working status";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Have you purchased jewellery savings plan before?",
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              TextFormField(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => SimpleDialog(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 15.0),
                                child: Text(
                                  "Please select",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              ...yesNo.map((e) {
                                return GestureDetector(
                                  onTap: () {
                                    savingPlanController.text = e.toString();
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 10),
                                    child: Text(
                                      e.toString(),
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList()
                            ],
                          ));
                },
                readOnly: true,
                controller: savingPlanController,
                cursorWidth: 1.0,
                cursorColor: Colors.black,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  hintText: "Select your option",
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      // color: Colors.black,
                      color: Colors.amber,
                      width: 1,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: Icon(
                    Icons.arrow_drop_down,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please select your option";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Would you like to join our Whatsapp group to know about Jewelery brands discount in your city?",
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              TextFormField(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => SimpleDialog(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 15.0),
                                child: Text(
                                  "Please select",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              ...yesNo.map((e) {
                                return GestureDetector(
                                  onTap: () {
                                    joinWhatsappGroupController.text =
                                        e.toString();
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 10),
                                    child: Text(
                                      e.toString(),
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList()
                            ],
                          ));
                },
                readOnly: true,
                controller: joinWhatsappGroupController,
                cursorWidth: 1.0,
                cursorColor: Colors.black,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  hintText: "Select your option",
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                  contentPadding: const EdgeInsets.all(10),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      // color: Colors.black,
                      color: Colors.amber,
                      width: 1,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: Icon(
                    Icons.arrow_drop_down,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please select your option";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 15.0,
              ),
            ],
          ),
        ),
      );

  apiCall(BuildContext context) async {
    Map request = {
      "name": nameController.text.toString(),
      "age": ageController.text.toString(),
      "email": emailController.text.toString(),
      "city": cityController.text.toString(),
      "phone_number": phoneController.text.toString(),
      "marital_status": marriedStatus,
      "monthly_income": income,
      "working_status": workingStatusController.text.toString(),
      "plan_purchased_before": savingPlanController.text.toString(),
      "join_whatsapp_group": joinWhatsappGroupController.text.toString(),
    };
    try {
      var url = "https://apijs.getplus.in/api/v1/feedback";
      debugPrint("Survey API URL -> $url");
      var response = await Dio().post(
        url,
        data: request,
      );
      isLoading = false;
      setState(() {});
      if (response.data["created_at"] != null) {
        navigate(context);
      }
    } catch (e) {
      debugPrint("Catch Error -> $e");
    }
  }
}

void navigate(BuildContext context) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => SurveySubmitted(),
      ),
      (route) => false);
}

class MonthlyIncome {
  String? key;
  String? value;
  MonthlyIncome({
    this.key,
    this.value,
  });
}

class MaritalStatus {
  String? key;
  String? value;
  MaritalStatus({
    this.key,
    this.value,
  });
}

class WorkingStatus {
  String? key;
  String? value;
  WorkingStatus({
    this.key,
    this.value,
  });
}
