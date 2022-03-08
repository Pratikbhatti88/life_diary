// // import 'dart:async';
// //
// // import 'package:bloc/bloc.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:firebase_database/firebase_database.dart';
// // import 'package:meta/meta.dart';
// // import 'package:package_info/package_info.dart';
// //
// // part 'app_version_event.dart';
// // part 'app_version_state.dart';
// //
// // class AppVersionBloc extends Bloc<AppVersionEvent, AppVersionState> {
// //   AppVersionBloc() : super(AppVersionFetching());
// //
// //   @override
// //   Stream<AppVersionState> mapEventToState(AppVersionEvent event) async* {
// //     if (event is CheckAppVersion) {
// //       yield AppVersionFetching();
// //       yield await _mapAppVersionFetchedToState();
// //     }
// //   }
// //
// //   /// Manage app version
// //   Future<AppVersionState> _mapAppVersionFetchedToState() async {
// //     final firebaseApp = await Firebase.initializeApp();
// //     final reference = FirebaseDatabase(app: firebaseApp).reference();
// //     final packageInfo = await PackageInfo.fromPlatform();
// //
// //     return reference.child('update_management').once().then((snapshot) async {
// //       print('updatedata======================');
// //       print(snapshot.value);
// //       final minVersion = int.parse((snapshot.value['min_version'] as String)
// //           .replaceAll('.', '')
// //           .replaceAll('+', ''));
// //
// //       print('minversion$minVersion');
// //       final latestVersion = int.parse(
// //           (snapshot.value['latest_version'] as String)
// //               .replaceAll('.', '')
// //               .replaceAll('+', ''));
// //       print('latestversion');
// //       print(latestVersion);
// //
// //       final appVersion = int.parse(packageInfo.version.replaceAll('.', ''));
// //
// //       print('finalappVersion$appVersion');
// //       if (appVersion >= latestVersion) {
// //         return AppVersionValid();
// //       } else if (appVersion >= minVersion) {
// //         return AppHasSoftUpdate(
// //             title: snapshot.value['soft_update_title'],
// //             message: snapshot.value['soft_update_message']);
// //       } else {
// //         return AppHasForceUpdate(
// //             title: snapshot.value['force_update_title'],
// //             message: snapshot.value['force_update_message']);
// //       }
// //     }).catchError((onError) {
// //       print(onError);
// //       return AppVersionFetchingError(
// //           error: 'Something went wrong. please try again');
// //     }).onError((error, stackTrace) {
// //       print(error);
// //       return AppVersionFetchingError(
// //           error: 'Something went wrong. please try again');
// //     });
// //   }
// // }
// //
// //
// //
// //
// // part of 'app_version_bloc.dart';
// //
// // @immutable
// // abstract class AppVersionEvent {}
// //
// // /// To check app version with firebase realtime database
// // class CheckAppVersion extends AppVersionEvent {}
// //
// //
// // part of 'app_version_bloc.dart';
// //
// // @immutable
// // abstract class AppVersionState {}
// //
// // /// Checking version
// // class AppVersionFetching extends AppVersionState {}
// //
// // /// App has valid version
// // class AppVersionValid extends AppVersionState {}
// //
// // /// App has either soft or force update
// // class AppHasUpdate extends AppVersionState {
// //   final String title;
// //   final String message;
// //
// //   AppHasUpdate({required this.title, required this.message});
// // }
// //
// // /// Soft update
// // class AppHasSoftUpdate extends AppHasUpdate {
// //   final String title;
// //   final String message;
// //
// //   AppHasSoftUpdate({required this.title, required this.message})
// //       : super(title: title, message: message);
// // }
// //
// // /// Force update
// // class AppHasForceUpdate extends AppHasUpdate {
// //   final String title;
// //   final String message;
// //
// //   AppHasForceUpdate({required this.title, required this.message})
// //       : super(title: title, message: message);
// // }
// //
// // /// Error in fetching app version
// // class AppVersionFetchingError extends AppHasUpdate {
// //   final String error;
// //
// //   AppVersionFetchingError({required this.error})
// //       : super(title: '', message: '');
// // }
//
//
// //splashscreen-----------------------//
//
//
// import 'package:big_news/blocs/app_version/app_version_bloc.dart';
// import 'package:big_news/core/firebase_ads_services.dart';
// import 'package:big_news/core/firebase_services.dart';
// import 'package:big_news/core/preferences.dart';
// import 'package:big_news/core/utility.dart';
// import 'package:big_news/resources/resources.dart';
// import 'package:big_news/ui/screens/news/news_screen.dart';
// import 'package:big_news/ui/widgets/widgets.dart';
// import 'package:facebook_audience_network/ad/ad_interstitial.dart';
// import 'package:firebase_remote_config/firebase_remote_config.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_admob_app_open/ad_request_app_open.dart';
// import 'package:flutter_admob_app_open/flutter_admob_app_open.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';
// import 'package:package_info/package_info.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import 'news/welcomescreen.dart';
//
// class SplashScreen extends StatefulWidget {
//   final RemoteConfig remoteConfigData;
//
//   SplashScreen({required this.remoteConfigData});
//
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with WidgetsBindingObserver {
//   String? data;
//   String openAppAdID = '';
//   String adType = '';
//   String interstitialAdID = '';
//   String Fb_interstitialAdID = '';
//   bool isBackground = false;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance!.addObserver(this);
//
//     //getAdData();
//
//     adType = widget.remoteConfigData.getString('interstitial_splash');
//
//     print('splashaddata===========================');
//     print(adType);
//
//     _openAppAdSetup();
//     _oneSignalNotificationSetup();
//     _firebaseSetup();
//     //  _openAppAdSetup();
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance!.removeObserver(this);
//
//     super.dispose();
//   }
//
//   // storePreferenceAd() async {
//   //   await
//   // }
//
//   void _openAppAdSetup() async {
//     await MobileAds.instance.initialize().then((value) {
//       MobileAds.instance.updateRequestConfiguration(
//         RequestConfiguration(testDeviceIds: []),
//       );
//     });
//
//     AdRequestAppOpen targetingInfo = AdRequestAppOpen();
//
//     await AdServices().adsReadData(adId).then((value) {
//       print(value!.appOpen);
//       openAppAdID = value.appOpen;
//       setState(() {});
//     });
//
//     await FlutterAdmobAppOpen.instance.initialize(
//       appAppOpenAdUnitId: openAppAdID,
//       targetingInfo: targetingInfo,
//     );
//   }
//
//   checkSplashAd() async {
//     await Preference.setSplashInterstitialAd(false);
//     Navigator.of(context).pushReplacementNamed(WelcomeScreen.route,
//         arguments:
//         WelcomeScreenData(remoteConfigData: widget.remoteConfigData));
//   }
//
//   getAdId() async {
//     final isShow = await Preference.getSplashInterstitialAd();
//
//     await AdServices().adsReadData(adId).then((value) {
//       interstitialAdID = isShow ? '' : value!.interstitialSplash;
//       Fb_interstitialAdID = isShow ? '' : value!.fbInterstitialSplash;
//       setState(() {});
//       print(Fb_interstitialAdID);
//     });
//
//     interstitialAdID.isEmpty || Fb_interstitialAdID.isEmpty
//         ? checkSplashAd()
//         : _loadInterstitialAd(context);
//   }
//
//   /// One Signal notification setup
//   void _oneSignalNotificationSetup() async {
//     await OneSignal.shared.setAppId('900eaa44-aa2f-4f81-8b4d-c838ea61601d');
//   }
//
//   /// Firebase setup
//   void _firebaseSetup() async {
//     final firebaseService = FirebaseServices();
//     await firebaseService.setupNotification();
//     firebaseService.setupCrashlytics();
//   }
//
//   _loadInterstitialAd(BuildContext context) async {
//     await AdServices().adsReadData(adId).then((value) {
//       interstitialAdID = value!.interstitialSplash;
//       Fb_interstitialAdID = value.fbInterstitialSplash;
//       setState(() {});
//       print(Fb_interstitialAdID);
//     });
//     print(interstitialAdID);
//
//     widget.remoteConfigData.getString('interstitial_splash') == 'FB'
//         ? _loadFbInterstitialAd()
//         : Utility.HomeLoadInterstitialAd(
//         remoteConfigData: widget.remoteConfigData,
//         context: context,
//         interstitialAdID: interstitialAdID);
//   }
//
//   _loadFbInterstitialAd() {
//     print('fb==================');
//     print(Fb_interstitialAdID);
//     FacebookInterstitialAd.loadInterstitialAd(
//       // placementId: "YOUR_PLACEMENT_ID",
//       placementId: Fb_interstitialAdID,
//
//       listener: (result, value) {
//         print(">> FAN > Interstitial Ad: $result --> $value");
//         if (result == InterstitialAdResult.LOADED)
//           print('facebook loaded=============');
//         FacebookInterstitialAd.showInterstitialAd();
//
//         /// Once an Interstitial Ad has been dismissed and becomes invalidated,
//         /// load a fresh Ad by calling this function.
//         if (result == InterstitialAdResult.DISMISSED) {
//           print('facebookdismiss==================');
//           Navigator.of(context).pushReplacementNamed(WelcomeScreen.route,
//               arguments:
//               WelcomeScreenData(remoteConfigData: widget.remoteConfigData));
//         }
//       },
//     );
//   }
//
//   /// Open app ad setup
//
//   bool isLoading = true;
//
//   @override
//   Widget build(BuildContext context) {
//     print('==================================');
//     print(interstitialAdID);
//     print(Fb_interstitialAdID);
//     print(adType);
//     return Scaffold(
//       body: BlocListener<AppVersionBloc, AppVersionState>(
//         listener: (context, state) async {
//           if (state is AppVersionValid) {
//             getAdId();
//           }
//           if (state is AppHasUpdate) {
//             final packageInfo = await PackageInfo.fromPlatform();
//             showDialog(
//               context: context,
//               barrierDismissible: false,
//               builder: (context) => WillPopScope(
//                 onWillPop: () async => false,
//                 child: AlertDialog(
//                   title: Text(packageInfo.appName),
//                   content: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         state.title,
//                         style: TextStyle(
//                           fontSize: 17,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 4,
//                       ),
//                       Text(state.message),
//                     ],
//                   ),
//                   actions: [
//                     TextButton(
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                         state is AppHasSoftUpdate
//                             ? Navigator.of(context).pushReplacementNamed(
//                             NewsScreen.route,
//                             arguments: NewsScreenData(
//                                 remoteConfigData: widget.remoteConfigData))
//                             : SystemNavigator.pop();
//                       },
//                       child: Text(
//                         state is AppHasSoftUpdate ? 'NO, THANKS' : 'EXIT',
//                         style: TextStyle(
//                           color: Colors.green,
//                         ),
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () => launch(
//                           'https://play.google.com/store/apps/details?id=' +
//                               packageInfo.packageName),
//                       style: TextButton.styleFrom(
//                         backgroundColor: Colors.green,
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 8, horizontal: 16),
//                       ),
//                       child: Text(
//                         'UPDATE',
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             );
//           } else if (state is AppVersionFetchingError) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.error),
//                 backgroundColor: Colors.red,
//               ),
//             );
//           }
//         },
//         child: Center(
//           child: AppLogo(
//             fontSize: MediaQuery.of(context).size.width * 0.16,
//           ),
//         ),
//       ),
//     );
//   }
// }
