import 'package:flutter/material.dart';
import 'package:flutter_lab1/provider/MyInfoModel.dart';
import 'package:flutter_lab1/screen/myinfo/MyInfoScreen.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,// 패딩 기본값을 아예 없애버림
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Consumer<MyInfoModel>(
                builder: (context,model,child){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        // child: Icon(Icons.person, size : 40, color: Colors.blue,),
                        child: Container(
                          width: 40,
                          height: 40,
                          child: Image.asset(model.userImage, fit:BoxFit.cover),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        model.email,
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  );
                }
            ),
          ),
          ListTile(
            leading: Icon(Icons.home,),
              title: Text('My Info'),
              onTap: (){

              //  Navigator.push(context, MaterialPageRoute(builder: (context)=> MyInfoScreen()));
                Navigator.pushNamed(context, '/myinfo');
              },
          ),
          ListTile(
            leading: Icon(Icons.access_time,),
            title: Text('DIO'),
            onTap: (){

              //  Navigator.push(context, MaterialPageRoute(builder: (context)=> MyInfoScreen()));
              Navigator.pushNamed(context, '/dio');
            },
          ),
          ListTile(
            leading: Icon(Icons.home,),
            title: Text('Provider'),
            onTap: (){

              Navigator.pushNamed(context, '/provider');
            },
          ),
          ListTile(
            leading: Icon(Icons.home,),
            title: Text('Bloc'),
            onTap: (){

              Navigator.pushNamed(context, '/bloc');
            },
          ),
          ListTile(
            leading: Icon(Icons.home,),
            title: Text('Platform'),
            onTap: (){

              Navigator.pushNamed(context, '/platform');
            },
          ),
        ],

      ),
    );
  }
}