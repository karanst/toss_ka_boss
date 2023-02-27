import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:concoin/utils/ApiBaseHelper.dart';
import 'package:concoin/utils/Session.dart';
import 'package:concoin/utils/colors.dart';
import 'package:concoin/utils/common.dart';
import 'package:concoin/utils/constant.dart';
import 'package:concoin/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController phoneController = new TextEditingController();

  TextEditingController emailController = new TextEditingController();

  TextEditingController nameController = new TextEditingController();

  TextEditingController addController = new TextEditingController();

  bool status = false;

  bool selected = false, enabled = false, edit1 = false;
  String deliveryLocation = "", name = "", email = "", mobile = "", image = "";

  String userId = '';
  @override
  void initState() {
    super.initState();
    userId = App.localStorage.getString("userId").toString();
    getSaved();
  }

  getSaved() async {
    await App.init();
    if (App.localStorage.getString("address") != null) {
      setState(() {
        addController.text = App.localStorage.getString("address").toString();
      });
    }
    if (App.localStorage.getString("image") != null) {
      setState(() {
        image = App.localStorage.getString("image").toString();
      });
    }
    if (App.localStorage.getString("name") != null) {
      setState(() {
        nameController.text = App.localStorage.getString("name").toString();
      });
    }
    if (App.localStorage.getString("email") != null) {
      setState(() {
        emailController.text = App.localStorage.getString("email").toString();
      });
    }
    if (App.localStorage.getString("phone") != null) {
      setState(() {
        phoneController.text = App.localStorage.getString("phone").toString();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColorName.appbarBg,
      body: SafeArea(
        child: SingleChildScrollView(
          child: AnimatedContainer(
            duration: Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
            width: 100.w,
            padding: MediaQuery.of(context).viewInsets,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  margin: EdgeInsets.only(top: 18.h),
                  width: 99.33.w,
                  height: 72.05.h,
                  child: firstSign(context),
                ),
                Container(
                  height: 17.89.h,
                  width: 100.w,
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(top: 3.h),
                  color: MyColorName.appbarBg,
                  child: Column(
                    children: [
                      Container(
                        width: 65.w,
                        child: text("Edit Profile",
                            textColor: Color(0xffffffff),
                            fontSize: 18.sp,
                            fontFamily: fontMedium,
                            isCentered: true),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 10.49.h,
                  child: InkWell(
                    onTap: (){
                      requestPermission(context);
                    },
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            height: getHeight(174),
                            width: getHeight(174),
                            child: _image!=null?Image.file(_image!,  height: getHeight(174),
                              width: getHeight(174),fit: BoxFit.fill,):commonImage(
                                image,
                                174.0,
                                174.0,
                                "assets/profile.png",
                                context,
                                "assets/profile.png"),
                          ),
                        ),
                        Container(
                          height: 4.39.h,
                          width: 4.39.h,
                          decoration: boxDecoration(
                              radius: 100, bgColor: MyColorName.colorTextFour),
                          child: Center(
                            child: Icon(
                              Icons.edit,
                              size: 2.39.h,
                            ),
                          ),
                        ),
                      ],
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

  Widget firstSign(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 9.92.h,
        ),
        Container(
          width: getWidth(590),
          child: TextFormField(
            controller: nameController,
            style: TextStyle(color:MyColorName.colorTextFour ),
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              fillColor: MyColorName.colorTextFour.withOpacity(0.3),
              filled: true,
              label: text("User Name"),
            ),
          ),
        ),
        boxHeight(53),
        Container(
          width: getWidth(590),
          child: TextFormField(
            style: TextStyle(color:MyColorName.colorTextFour ),
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            enabled: true,
            decoration: InputDecoration(
              fillColor: MyColorName.colorTextFour.withOpacity(0.3),
              filled: true,
              label: text("Email"),
            ),
          ),
        ),
        boxHeight(53),
        Container(
          width: getWidth(590),
          child: TextFormField(
            controller: phoneController,
            keyboardType: TextInputType.phone,

            style: TextStyle(color:MyColorName.colorTextFour ),
            decoration: InputDecoration(
              fillColor: MyColorName.colorTextFour.withOpacity(0.3),
              filled: true,
              enabled: false,
              label: text("Mobile"),
            ),
          ),
        ),
        boxHeight(53),
        SizedBox(
          height: 3.02.h,
        ),
        !selected?ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size.fromWidth(320),
            textStyle: TextStyle(
              color: Colors.orange,
              textBaseline: TextBaseline.alphabetic,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 12, 15),
            child: const Text(
              'Update Profile',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          onPressed: () {
            if (nameController.text == "") {
              setSnackbar("Please Enter Name", context);
              return;
            }
            if(validateEmail(emailController.text, "Please Enter Email","Please Enter Valid Email")!=null){
              setSnackbar(validateEmail(emailController.text, "Please Enter Email","Please Enter Valid Email").toString(), context);
              return;
            }
            setState(() {
              selected = true;
            });
            submitSubscription();
          },
        ):CircularProgressIndicator(),
      ],
    );
  }

  File? _image;
  Future getImage(ImgSource source, BuildContext context) async {
    var image = await ImagePickerGC.pickImage(
      context: context,
      source: source,
      cameraIcon: Icon(
        Icons.add,
        color: Colors.red,
      ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
    );
    setState(() {
      _image = File(image.path);
      getCropImage(context);
    });
  }

  void getCropImage(BuildContext context) async {
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: _image!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    setState(() {
      _image = croppedFile;
    });
  }

  ApiBaseHelper apiBase = new ApiBaseHelper();
  bool isNetwork = false;
  Future<void> submitSubscription() async {
    await App.init();

    ///MultiPart request
    isNetwork = await isNetworkAvailable();
    if (isNetwork) {
      try {
        if (_image != null) {
          var request = http.MultipartRequest(
            'POST',
            Uri.parse(baseUrl + "update_user"),
          );
          Map<String, String> headers = {
            "token": App.localStorage.getString("token").toString(),
            "Content-type": "multipart/form-data"
          };
          request.files.add(
            http.MultipartFile(
              'image',
              _image!.readAsBytes().asStream(),
              _image!.lengthSync(),
              filename: path.basename(_image!.path),
              contentType: MediaType('image', 'jpeg'),
            ),
          );
          request.headers.addAll(headers);
          request.fields.addAll({
            "username": nameController.text,

            "email": emailController.text.trim().toString(),
            "user_id": userId.toString()
            //curUserId.toString(),
          });
          print("request: " + request.toString());
          var res = await request.send();
          print("This is response:" + res.toString());
          setState(() {
            selected = false;
          });
          if (res.statusCode == 200) {
            final respStr = await res.stream.bytesToString();
            print(respStr.toString());
            Map data = jsonDecode(respStr.toString());

            if (!data['error']) {
              var image = data['data'];
              setState(() {
                App.localStorage.setString("image", image[0]['image']);
                App.localStorage.setString("name", nameController.text);
                App.localStorage.setString("email", emailController.text);
                name = nameController.text;
                email =emailController.text;
                image = image[0]['image'];
                setSnackbar(data['message'].toString(), context);
                Navigator.pop(context,"yes");
              });
            } else {
              setSnackbar(data['message'].toString(), context);
            }
          }
        }       else {
          Map data;
          data = {
            "username": nameController.text,
            "user_id": userId.toString(),
            //curUserId.toString(),
            "email": emailController.text.trim().toString(),
          };
          print(data);
          Map response = await apiBase.postAPICall(Uri.parse(baseUrl + "update_user"),data);
          print(response);
          bool status = true;
          String msg = response['message'];
          if (!response['error']) {
            setState(() {
              App.localStorage.setString("name", nameController.text);
              App.localStorage.setString("email", emailController.text);
              name = nameController.text;
              email =emailController.text;
              setSnackbar(response['message'].toString(), context);
              Navigator.pop(context,"yes");
            });
          } else {
            setSnackbar(response['message'].toString(), context);
          }

        }
      } on TimeoutException catch (_) {
        setSnackbar("Something Went Wrong", context);
        setState(() {
          selected = true;
        });
      }
    } else {
      setSnackbar("No Internet Connection", context);
      setState(() {
        selected = true;
      });
    }
  }
  void requestPermission(BuildContext context) async{
    if (await Permission.camera.isPermanentlyDenied||await Permission.storage.isPermanentlyDenied) {

      // The user opted to never again see the permission request dialog for this
      // app. The only way to change the permission's status now is to let the
      // user manually enable it in the system settings.
      openAppSettings();
    }
    else{
      Map<Permission, PermissionStatus> statuses = await [
        Permission.camera,
        Permission.storage,
      ].request();
// You can request multiple permissions at once.

      if(statuses[Permission.camera]==PermissionStatus.granted&&statuses[Permission.storage]==PermissionStatus.granted){
        getImage(ImgSource.Gallery, context);

      }else{
        if (await Permission.camera.isDenied||await Permission.storage.isDenied) {

          // The user opted to never again see the permission request dialog for this
          // app. The only way to change the permission's status now is to let the
          // user manually enable it in the system settings.
          openAppSettings();
        }else{
              setSnackbar("Oops you just denied the permission", context);
        }

      }
    }

  }
}
