import 'package:concoin/screens/edit_profile.dart';
import 'package:concoin/utils/common.dart';
import 'package:concoin/utils/constant.dart';
import 'package:concoin/utils/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'wallet.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var titleStyle = TextStyle(
    fontSize: 20,
  );
  String deliveryLocation = "", name = "", email = "", mobile = "", image = "";
  @override
  void initState() {
    super.initState();
    getSaved();
  }

  getSaved() async {
    await App.init();
    if (App.localStorage.getString("address") != null) {
      setState(() {
        deliveryLocation = App.localStorage.getString("address").toString();
      });
    }
    if (App.localStorage.getString("image") != null) {
      setState(() {
        image = App.localStorage.getString("image").toString();
      });
    }
    if (App.localStorage.getString("name") != null) {
      setState(() {
        name = App.localStorage.getString("name").toString();
      });
    }
    if (App.localStorage.getString("email") != null) {
      setState(() {
        email = App.localStorage.getString("email").toString();
      });
    }
    if (App.localStorage.getString("phone") != null) {
      setState(() {
        mobile = App.localStorage.getString("phone").toString();
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF004879),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: h*.01,),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Center(
                    child: Text(
                      "My Profile",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: h*.01,),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                    child:  ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        height: getHeight(174),
                        width: getHeight(174),
                        child: commonImage(
                            image,
                            174.0,
                            174.0,
                            "assets/profile.png",
                            context,
                            "assets/profile.png"),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: h*.1,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 19),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.orange,
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: ListTile(
                              title: Text(
                                "Name",
                                style: TextStyle(fontSize: 12, color: Colors.black,
                                    fontWeight: FontWeight.bold),

                              ),
                              trailing: Text(
                                name!=null&&name!=""?name:"Hi Guest",
                                style: TextStyle(fontSize: 12, color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(height: h*.006,),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15,),
                            child: ListTile(
                              title: Text(
                                "Email",
                                style: TextStyle(fontSize: 12, color: Colors.black,fontWeight: FontWeight.bold),
                              ),
                              trailing: Text(
                                email!=null&&email!=""?email:"N/A",
                                style: TextStyle(fontSize: 12, color: Colors.black,fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(height: h*.006,),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: ListTile(
                              onTap: ()
                              {
                                Navigator.of(context).pop();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) => Wallet()));
                              },
                              title: Text(
                                "Mobile Number",
                                style: TextStyle(fontSize: 12, color: Colors.black,fontWeight: FontWeight.bold),
                              ),
                              trailing: Text(
                                mobile!=null&&mobile!=""?mobile:"Hi Guest",
                                style: TextStyle(fontSize: 12, color: Colors.black,fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                boxHeight(100),
                ElevatedButton(
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
                      'Edit Profile',
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  onPressed: () async{
                    var result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile()));
                    if(result!=null){
                      getSaved();
                    }

                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
