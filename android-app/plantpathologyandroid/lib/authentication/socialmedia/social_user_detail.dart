//import 'package:social_login/social_login.dart';

//class SocialUserDetail extends StatelessWidget {
//  final SocialUser _socialUser;
//
//  static const String DEFAULT_IMAGE_URL =
//      "https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png";
//
//  SocialUserDetail(this._socialUser);
//
//  @override
//  Widget build(BuildContext context) {
//    return Row(
//      crossAxisAlignment: CrossAxisAlignment.center,
//      children: <Widget>[
//        Image.network(
//          _socialUser?.pictureUrl ?? DEFAULT_IMAGE_URL,
//          height: 60.0,
//          width: 60.0,
//        ),
//        Expanded(
//          child: Padding(
//            padding: const EdgeInsets.only(left: 8.0),
//            child: Text(_socialUser?.email ?? "-"),
//          ),
//        )
//      ],
//    );
//  }
//}
