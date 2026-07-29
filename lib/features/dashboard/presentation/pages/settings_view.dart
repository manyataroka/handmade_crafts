// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:proximity_sensor/proximity_sensor.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({super.key});

//   @override
//   State<SettingsScreen> createState() => _SettingsScreenState();
// }

// class _SettingsScreenState extends State<SettingsScreen>
//     with WidgetsBindingObserver {
//   bool _notificationsEnabled = true;
//   bool _darkModeEnabled = false;
//   bool _loading = true;
//   bool _proximityNear = false;

//   StreamSubscription<dynamic>? _proximitySubscription;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     _loadPreferences();
//     _initProximitySensor();
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     _proximitySubscription?.cancel();
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       _initProximitySensor();
//     } else if (state == AppLifecycleState.paused) {
//       _proximitySubscription?.cancel();
//       _proximitySubscription = null;
//     }
//   }

//   Future<void> _initProximitySensor() async {
//     _proximitySubscription?.cancel();
//     try {
//       _proximitySubscription = ProximitySensor.events.listen((int event) {
//         if (!mounted) return;
//         setState(() {
//           _proximityNear = event > 0; // >0 means near, 0 means far
//         });
//       });
//     } catch (e) {
//       // Proximity sensor not available on this device — silently ignore
//     }
//   }

//   Future<void> _loadPreferences() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;
//       _darkModeEnabled = prefs.getBool('dark_mode_enabled') ?? false;
//       _loading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Scaffold(
//           backgroundColor: const Color(0xFFFCEEEE),
//           appBar: AppBar(
//             backgroundColor: Colors.white,
//             elevation: 0,
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back, color: Colors.black87),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//             title: const Text(
//               'Settings',
//               style: TextStyle(
//                 color: Colors.black87,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             centerTitle: true,
//           ),
//           body: _loading
//               ? const Center(child: CircularProgressIndicator())
//               : SingleChildScrollView(
//                   physics: const BouncingScrollPhysics(),
//                   padding: const EdgeInsets.all(20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // ── Preferences Section ──
//                       Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(16),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.05),
//                               blurRadius: 8,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           children: [
//                             SwitchListTile(
//                               title: const Text(
//                                 'Push Notifications',
//                                 style: TextStyle(color: Colors.black87),
//                               ),
//                               subtitle: const Text(
//                                 'Get notified about order updates',
//                                 style: TextStyle(color: Colors.black54),
//                               ),
//                               secondary: const Icon(
//                                 Icons.notifications_outlined,
//                                 color: Colors.redAccent,
//                               ),
//                               value: _notificationsEnabled,
//                               activeColor: Colors.redAccent,
//                               onChanged: (val) async {
//                                 setState(() => _notificationsEnabled = val);
//                                 final prefs =
//                                     await SharedPreferences.getInstance();
//                                 await prefs.setBool(
//                                   'notifications_enabled',
//                                   val,
//                                 );
//                               },
//                             ),
//                             const Divider(height: 0, indent: 16, endIndent: 16),
//                             SwitchListTile(
//                               title: const Text(
//                                 'Dark Mode',
//                                 style: TextStyle(color: Colors.black87),
//                               ),
//                               subtitle: const Text(
//                                 'Switch to dark theme',
//                                 style: TextStyle(color: Colors.black54),
//                               ),
//                               secondary: const Icon(
//                                 Icons.dark_mode_outlined,
//                                 color: Colors.redAccent,
//                               ),
//                               value: _darkModeEnabled,
//                               activeColor: Colors.redAccent,
//                               onChanged: (val) async {
//                                 setState(() => _darkModeEnabled = val);
//                                 final prefs =
//                                     await SharedPreferences.getInstance();
//                                 await prefs.setBool('dark_mode_enabled', val);
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 20),

//                       // ── Support Section ──
//                       Container(
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(16),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.05),
//                               blurRadius: 8,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: Column(
//                           children: [
//                             ListTile(
//                               leading: const Icon(
//                                 Icons.description_outlined,
//                                 color: Colors.black54,
//                               ),
//                               title: const Text(
//                                 'Policies',
//                                 style: TextStyle(color: Colors.black87),
//                               ),
//                               trailing: const Icon(
//                                 Icons.chevron_right,
//                                 color: Colors.black45,
//                               ),
//                               onTap: () {
//                                 showDialog(
//                                   context: context,
//                                   builder: (ctx) => AlertDialog(
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(16),
//                                     ),
//                                     title: const Text('Policies'),
//                                     content: const SingleChildScrollView(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             '1. Return & Refund Policy',
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                           SizedBox(height: 4),
//                                           Text(
//                                             'Items can be returned within 7 days of delivery in original condition. Refunds will be processed within 5-7 business days.',
//                                             style: TextStyle(
//                                               color: Colors.black54,
//                                             ),
//                                           ),
//                                           SizedBox(height: 16),
//                                           Text(
//                                             '2. Shipping Policy',
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                           SizedBox(height: 4),
//                                           Text(
//                                             'Free shipping on orders above ₹500. Standard delivery takes 3-7 business days.',
//                                             style: TextStyle(
//                                               color: Colors.black54,
//                                             ),
//                                           ),
//                                           SizedBox(height: 16),
//                                           Text(
//                                             '3. Privacy Policy',
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                           SizedBox(height: 4),
//                                           Text(
//                                             'Your personal information is kept secure and never shared with third parties without your consent.',
//                                             style: TextStyle(
//                                               color: Colors.black54,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     actions: [
//                                       TextButton(
//                                         onPressed: () => Navigator.pop(ctx),
//                                         child: const Text(
//                                           'Close',
//                                           style: TextStyle(
//                                             color: Colors.redAccent,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             ),
//                             const Divider(height: 0, indent: 16, endIndent: 16),
//                             ListTile(
//                               leading: const Icon(
//                                 Icons.help_outline,
//                                 color: Colors.black54,
//                               ),
//                               title: const Text(
//                                 'Help & Support',
//                                 style: TextStyle(color: Colors.black87),
//                               ),
//                               trailing: const Icon(
//                                 Icons.chevron_right,
//                                 color: Colors.black45,
//                               ),
//                               onTap: () {
//                                 showDialog(
//                                   context: context,
//                                   builder: (ctx) => AlertDialog(
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(16),
//                                     ),
//                                     title: const Text('Help & Support'),
//                                     content: const Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           'FAQs',
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         SizedBox(height: 8),
//                                         Text(
//                                           '• How to place an order?\n'
//                                           'Browse products, add to cart, and proceed to checkout.',
//                                           style: TextStyle(
//                                             color: Colors.black54,
//                                           ),
//                                         ),
//                                         SizedBox(height: 8),
//                                         Text(
//                                           '• How to track my order?\n'
//                                           'Go to Orders section in your profile to view status.',
//                                           style: TextStyle(
//                                             color: Colors.black54,
//                                           ),
//                                         ),
//                                         SizedBox(height: 8),
//                                         Text(
//                                           '• How to cancel an order?\n'
//                                           'Contact our support team within 24 hours of placing the order.',
//                                           style: TextStyle(
//                                             color: Colors.black54,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     actions: [
//                                       TextButton(
//                                         onPressed: () => Navigator.pop(ctx),
//                                         child: const Text(
//                                           'Close',
//                                           style: TextStyle(
//                                             color: Colors.redAccent,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             ),
//                             const Divider(height: 0, indent: 16, endIndent: 16),
//                             ListTile(
//                               leading: const Icon(
//                                 Icons.info_outline,
//                                 color: Colors.black54,
//                               ),
//                               title: const Text(
//                                 'About Us',
//                                 style: TextStyle(color: Colors.black87),
//                               ),
//                               trailing: const Icon(
//                                 Icons.chevron_right,
//                                 color: Colors.black45,
//                               ),
//                               onTap: () {
//                                 showDialog(
//                                   context: context,
//                                   builder: (ctx) => AlertDialog(
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(16),
//                                     ),
//                                     title: const Text('About Us'),
//                                     content: const Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           'Handmade Crafts',
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 18,
//                                           ),
//                                         ),
//                                         SizedBox(height: 12),
//                                         Text(
//                                           'We are a passionate team dedicated to bringing you the finest handmade jewelry and crafts. Each piece is carefully curated to ensure quality and uniqueness.',
//                                           style: TextStyle(
//                                             color: Colors.black54,
//                                           ),
//                                         ),
//                                         SizedBox(height: 12),
//                                         Text(
//                                           'Our mission is to support local artisans and provide customers with authentic, handcrafted products that tell a story.',
//                                           style: TextStyle(
//                                             color: Colors.black54,
//                                           ),
//                                         ),
//                                         SizedBox(height: 12),
//                                         Text(
//                                           'Version: 1.0.0',
//                                           style: TextStyle(
//                                             color: Colors.black45,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     actions: [
//                                       TextButton(
//                                         onPressed: () => Navigator.pop(ctx),
//                                         child: const Text(
//                                           'Close',
//                                           style: TextStyle(
//                                             color: Colors.redAccent,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             ),
//                             const Divider(height: 0, indent: 16, endIndent: 16),
//                             ListTile(
//                               leading: const Icon(
//                                 Icons.phone_outlined,
//                                 color: Colors.black54,
//                               ),
//                               title: const Text(
//                                 'Call Us',
//                                 style: TextStyle(color: Colors.black87),
//                               ),
//                               subtitle: const Text(
//                                 '+977-9812345678',
//                                 style: TextStyle(color: Colors.black54),
//                               ),
//                               trailing: const Icon(
//                                 Icons.chevron_right,
//                                 color: Colors.black45,
//                               ),
//                               onTap: () {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                     content: Text('Calling +977-9812345678...'),
//                                     backgroundColor: Colors.redAccent,
//                                   ),
//                                 );
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 24),

//                       // ── App Version ──
//                       Center(
//                         child: Text(
//                           'Handmade Crafts v1.0.0',
//                           style: TextStyle(color: Colors.black45, fontSize: 13),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                     ],
//                   ),
//                 ),
//         ),

//         // ── Proximity Sensor Overlay ──
//         if (_proximityNear)
//           Positioned.fill(
//             child: AnimatedOpacity(
//               opacity: _proximityNear ? 1.0 : 0.0,
//               duration: const Duration(milliseconds: 150),
//               child: Container(
//                 color: Colors.black,
//                 child: const Center(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(
//                         Icons.visibility_off,
//                         color: Colors.white54,
//                         size: 64,
//                       ),
//                       SizedBox(height: 16),
//                       Text(
//                         'Screen Blanked',
//                         style: TextStyle(
//                           color: Colors.white54,
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       SizedBox(height: 8),
//                       Text(
//                         'Move device away to restore',
//                         style: TextStyle(color: Colors.white38, fontSize: 14),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }
