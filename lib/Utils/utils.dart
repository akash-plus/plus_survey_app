import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

void onLocalSetup(data) async {
  debugPrint("CITYYYY - onLocalSetup--> ${data['user']['city']}");
  final storage = GetStorage();
  final id = data['user']['id'];
  final user_UniqueId = data['user']['unique_id'];
  await storage.write('id', id);
  await storage.write('user_uniqueId', user_UniqueId);
  await storage.write('token', data['token']);
  await storage.write('name', data['user']['name']);
  await storage.write('profile_image', data['user']['profile_image']);
  await storage.write('city', data['user']['city']);
  await storage.write('age', data['user']['age']);
  await storage.write('mobile', data['user']['mobile']);
  await storage.write('gender', data['user']['gender']);
  await storage.write('referral_code', data['user']['referral_code']);
  await storage.write('is_register', 1);
  // await storage.write(isLOGGEDIN, true);
  // Get.offAllNamed(Routes.HOME_PAGE);
}

void onClearLocalSetup() async {
  final storage = GetStorage();
  final id = storage.read('id');
  final user_UniqueId = storage.read('user_uniqueId');
  await storage.remove('id');
  await storage.remove('user_uniqueId');
  await storage.remove('token');
  await storage.remove('city');
  // await storage.remove('user_image');
  await storage.remove('name');
  await storage.remove('age');
  await storage.remove('mobile');
  await storage.remove('gender');
  await storage.remove('referral_code');
  await storage.remove('is_register');

  // Get.offAllNamed(Routes.MOBILE_NUMBER_SCREEN);
}

hexCode(String colorCode) {
  String newColorCode = '0xff' + colorCode;
  newColorCode = newColorCode.replaceAll("#", '');
  int colorInt = int.parse(newColorCode);
  return colorInt;
}

dateParse(date) {
  return DateTime.parse(date).toLocal();
}

askForPermissionWithAlter(context) {
  showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: Text('Location Permission'),
            content: Text('App needs location access to show location'),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text("Don't Allow"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              CupertinoDialogAction(
                child: Text('Settings'),
                onPressed: null,
                // () async => await Geolocator.openLocationSettings(),
              ),
            ],
          ));
}

class RadioGroupItem {
  final String title;
  final String value;

  RadioGroupItem(this.title, this.value);
}

class RadioGroup extends StatefulWidget {
  bool? horizontal;
  String? initValue;
  List<RadioGroupItem>? items;
  Function? onSelect;

  RadioGroup(
      {Key? key,
      this.horizontal = false,
      @required this.items,
      @required this.onSelect,
      this.initValue})
      : super(key: key);

  @override
  _RadioGroupState createState() => _RadioGroupState();
}

class _RadioGroupState extends State<RadioGroup> {
  String? groupValue;

  @override
  void initState() {
    super.initState();
    setState(() {
      groupValue = widget.initValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.items!
          .map((e) => Row(
                children: [
                  Radio(
                    value: e.value,
                    groupValue: groupValue,
                    onChanged: (val) {
                      setState(() {
                        groupValue = val.toString();
                      });
                      widget.onSelect!(val);
                    },
                  ),
                  Text(
                    e.title,
                    style: new TextStyle(fontSize: 17.0),
                  ),
                ],
              ))
          .toList(),
    );
  }
}
