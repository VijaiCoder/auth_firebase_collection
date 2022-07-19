// // ignore_for_file: library_private_types_in_public_api

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:healr_fit/utils/color.dart';
// import 'package:healr_fit/widgets/custom_button.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import '../res/following_followers.dart';
// import '../utils/show_snackbar.dart';

// class ProfileScreen extends StatefulWidget {
//   final String uid;
//   const ProfileScreen({Key? key, required this.uid}) : super(key: key);

//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   var userData = {};
//   int postLen = 0;
//   int followers = 0;
//   int following = 0;
//   bool isFollowing = false;
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }

//   getData() async {
//     setState(() {
//       isLoading = true;
//     });
//     try {
//       var userSnap = await FirebaseFirestore.instance
//           .collection('users')
//           .doc(widget.uid)
//           .get();

//       // get post lENGTH
//       var postSnap = await FirebaseFirestore.instance
//           .collection('posts')
//           .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//           .get();

//       postLen = postSnap.docs.length;
//       userData = userSnap.data()!;
//       followers = userSnap.data()!['followers'].length;
//       following = userSnap.data()!['following'].length;
//       isFollowing = userSnap
//           .data()!['followers']
//           .contains(FirebaseAuth.instance.currentUser!.uid);
//       setState(() {});
//     } catch (e) {
//       showSnackBar(
//         context,
//         e.toString(),
//       );
//     }
//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return isLoading
//         ? const Center(
//             child: CircularProgressIndicator(),
//           )
//         : Scaffold(
//             body: SafeArea(
//             child: Container(
//               height: double.infinity,
//               width: double.infinity,
//               alignment: Alignment.topCenter,
//               decoration: const BoxDecoration(
//                 color: borderclr,
//               ),
//               child: ListView(children: [
//                 FollowingFollowers(
//                   followerstext: '$followers',
//                   followingtext: '$following',
//                 ),
//                 CircleAvatar(
//                   radius: 65.r,
//                   backgroundImage: NetworkImage(
//                     userData['photoUrl'],
//                   ),
//                 ),
//                 Container(
//                   width: 411.w,
//                   decoration: BoxDecoration(
//                       color: liteblue,
//                       borderRadius: BorderRadius.only(
//                           topRight: Radius.circular(50.r),
//                           topLeft: Radius.circular(50.r))),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         SizedBox(height: 60.h),
//                         Text(
//                           '${userData['name']}',
//                           style: TextStyle(
//                               color: textclr,
//                               fontSize: 18.sp,
//                               fontWeight: FontWeight.w700),
//                         ),
//                         Text(
//                           '@${userData['username']}',
//                           style: TextStyle(
//                               color: textclr,
//                               fontSize: 18.sp,
//                               fontWeight: FontWeight.w400),
//                         ),
//                         SizedBox(height: 15.h),
//                         SizedBox(
//                           width: 230.w,
//                           child: Text(
//                             '${userData['bio']}',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: 18.sp,
//                                 fontWeight: FontWeight.w400),
//                           ),
//                         ),
//                         SizedBox(height: 15.h),
//                         FirebaseAuth.instance.currentUser!.uid == widget.uid
//                             ? Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Icon(
//                                     Icons.settings,
//                                     size: 20.sp,
//                                     color: textclr,
//                                   ),
//                                   CustomButton(
//                                     color: liteblue,
//                                     ontap: () {},
//                                     fontSize: 18.sp,
//                                     textcolor: textclr,
//                                     text: 'Profile Settings',
//                                     width: 120.w,
//                                     height: 19.h,
//                                   ),
//                                 ],
//                               )
//                             : isFollowing
//                                 ? CustomButton(
//                                     ontap: () {},
//                                     text: 'following',
//                                     width: 111,
//                                     color: Colors.white,
//                                     height: 38,
//                                   )
//                                 : CustomButton(
//                                     ontap: () {},
//                                     text: 'follow',
//                                     width: 111,
//                                     height: 38,
//                                   ),
//                         // FutureBuilder(
//                         //   future: FirebaseFirestore.instance
//                         //       .collection('posts')
//                         //       .orderBy('datePublished')
//                         //       .get(),
//                         //   builder: (context, snapshot) {
//                         //     if (!snapshot.hasData) {
//                         //       return const Center(
//                         //         child: CircularProgressIndicator(),
//                         //       );
//                         //     }

//                         //     return ClipRRect(
//                         //         borderRadius: BorderRadius.only(
//                         //             topRight: Radius.circular(50.r),
//                         //             topLeft: Radius.circular(50.r)),
//                         //         child: Container(
//                         //           height: 1000.h,
//                         //           child: StaggeredGridView.countBuilder(
//                         //             crossAxisCount: 2,
//                         //             itemCount:
//                         //                 (snapshot.data! as dynamic).docs.length,
//                         //             itemBuilder: (context, index) => Container(
//                         //               decoration: BoxDecoration(
//                         //                   image: DecorationImage(
//                         //                     image: NetworkImage(
//                         //                       (snapshot.data! as dynamic)
//                         //                           .docs[index]['postUrl'],
//                         //                     ),
//                         //                     fit: BoxFit.cover,
//                         //                   ),
//                         //                   color: backgroundclr,
//                         //                   borderRadius: BorderRadius.all(
//                         //                       Radius.circular(50.r))),
//                         //             ),
//                         //             staggeredTileBuilder: (index) =>
//                         //                 // MediaQuery.of(context)
//                         //                 //             .size
//                         //                 //             .width
//                         //                 //     411
//                         //                 // ? StaggeredTile.count(
//                         //                 //     (index % 7 == 0) ? 1 : 1, (index % 7 == 0) ? 1 : 1)
//                         //                 // :
//                         //                 StaggeredTile.count(
//                         //                     (index % 7 == 0) ? 2 : 1,
//                         //                     (index % 7 == 0) ? 2 : 1),
//                         //             mainAxisSpacing: 8.0,
//                         //             crossAxisSpacing: 8.0,
//                         //           ),
//                         //         ));
//                         //   },
//                         // ),

//                         FutureBuilder(
//                           future: FirebaseFirestore.instance
//                               .collection('posts')
//                               .where('uid', isEqualTo: widget.uid)
//                               .get(),
//                           builder: (context, snapshot) {
//                             if (snapshot.connectionState ==
//                                 ConnectionState.waiting) {
//                               return const Center(
//                                 child: CircularProgressIndicator(),
//                               );
//                             }

//                             return GridView.builder(
//                               keyboardDismissBehavior:
//                                   ScrollViewKeyboardDismissBehavior.onDrag,
//                               physics: const AlwaysScrollableScrollPhysics(),
//                               shrinkWrap: true,
//                               itemCount:
//                                   (snapshot.data! as dynamic).docs.length,
//                               gridDelegate:
//                                   const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 2,
//                                 crossAxisSpacing: 5,
//                                 mainAxisSpacing: 10,
//                                 childAspectRatio: 1,
//                               ),
//                               itemBuilder: (context, index) {
//                                 DocumentSnapshot snap =
//                                     (snapshot.data! as dynamic).docs[index];

//                                 return Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                         image: DecorationImage(
//                                           image: NetworkImage(snap['postUrl']),
//                                           fit: BoxFit.cover,
//                                         ),
//                                         color: liteblue,
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(30.r))),
//                                   ),
//                                 );
//                               },
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ]),
//             ),
//           ));
//   }
// }