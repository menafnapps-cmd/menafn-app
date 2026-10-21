import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  // ---------------------------------------------------------
  // URL
  // ---------------------------------------------------------

  Future<void> _openUrl(String url) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
  }

   Future<void> _callPhone() async {
  final Uri uri = Uri(
    scheme: 'tel',
    path: '+96265690450',
  );

  try {
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  } catch (e) {
    debugPrint('Error opening phone app: $e');
  }
}

Future<void> _sendEmail() async {
  final Uri uri = Uri(
    scheme: 'mailto',
    path: 'press.rel@menafn.com',
    queryParameters: {
      'subject': 'Contact MENAFN',
    },
  );

  try {
    final bool launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );

    if (!launched) {
      debugPrint('Could not launch email app: $uri');
    }
  } catch (e) {
    debugPrint('Error opening email app: $e');
  }
}

  // ---------------------------------------------------------
  // CONTACT ITEM
  // ---------------------------------------------------------

  Widget _contactItem({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 9,
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: 19,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(width: 12),

            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF555555),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------
  // SOCIAL ITEM
  // ---------------------------------------------------------

  Widget _socialItem({
    required Widget icon,
    required String platform,
    required String username,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 7,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 36,
              height: 36,
              child: Center(
                child: icon,
              ),
            ),

            const SizedBox(width: 12),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  platform,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  username,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF555555),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------
  // CARD
  // ---------------------------------------------------------

  Widget _buildCard({
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        16,
        15,
        16,
        14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 8),

          child,
        ],
      ),
    );
  }

  // ---------------------------------------------------------
  // BUILD
  // ---------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),

      // -----------------------------------------------------
      // APP BAR
      // -----------------------------------------------------

      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: const Color(0xFFFAFAFA),
        foregroundColor: const Color(0xFF444444),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 19,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 0,
        title: const Text(
          'Contact Us',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF444444),
          ),
        ),
      ),

      // -----------------------------------------------------
      // BODY
      // -----------------------------------------------------

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            16,
            6,
            16,
            30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // -------------------------------------------------
              // DESCRIPTION
              // -------------------------------------------------

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 1,
                ),
                child: Text(
                  'You can get in touch with us through below platforms. '
                  'Our team will reach out to you as soon as it would be possible.',
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.5,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // -------------------------------------------------
              // CUSTOMER SUPPORT
              // -------------------------------------------------

              _buildCard(
                title: 'Customer Support',
                child: Column(
                  children: [
                    _contactItem(
                      icon: Icons.phone_outlined,
                      label: 'Contact Number',
                      value: '+962 6 5690450',
                      onTap: _callPhone,
                    ),

                    const Divider(
                      height: 1,
                      color: Color(0xFFF2F2F2),
                    ),

                    _contactItem(
                      icon: Icons.email_outlined,
                      label: 'Email Address',
                      value: 'press.rel@menafn.com',
                      onTap: _sendEmail,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // -------------------------------------------------
              // SOCIAL MEDIA
              // -------------------------------------------------

              _buildCard(
                title: 'Social Media',
                child: Column(
                  children: [
                    _socialItem(
                      platform: 'Instagram',
                      username: '@menafn',
                      icon: Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFFEDA75),
                              Color(0xFFFA7E1E),
                              Color(0xFFD62976),
                              Color(0xFF4F5BD5),
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                        ),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {
                        _openUrl(
                          'https://www.instagram.com/menafn/',
                        );
                      },
                    ),

                    const Divider(
                      height: 1,
                      color: Color(0xFFF2F2F2),
                    ),

                  _socialItem(
                    platform: 'X',
                    username: '@menafn',
                    icon: const Text(
                        '𝕏',
                        style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        ),
                    ),
                    onTap: () {
                        _openUrl('https://x.com/menafn');
                    },
                    ),
                    _socialItem(
                      platform: 'Facebook',
                      username: '@menafn',
                      icon: const Icon(
                        Icons.facebook,
                        color: Color(0xFF1877F2),
                        size: 23,
                      ),
                      onTap: () {
                        _openUrl(
                          'https://www.facebook.com/menafn/',
                        );
                      },
                    ),
                    _socialItem(
                    platform: 'Google+',
                    username: 'MENAFN',
                    icon: const Text(
                        'G+',
                        style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.red,
                        ),
                    ),
                    onTap: () {
                        _openUrl('https://menafn.com/MF/Nl_sub');
                    },
                    ),
                    _socialItem(
                        platform: 'Daily Email',
                        username: 'Subscribe to MENAFN Daily Email',
                        icon: const Icon(
                            Icons.mark_email_unread_outlined,
                            color: Color(0xFF555555),
                            size: 23,
                        ),
                        onTap: () {
                            _openUrl('https://menafn.com/MF/Nl_sub');
                        },
                        ),
                        _socialItem(
                            platform: 'LinkedIn',
                            username: 'MENAFN',
                            icon: const Text(
                                'in',
                                style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF0A66C2),
                                ),
                            ),
                            onTap: () {
                                _openUrl('https://www.linkedin.com/company/menafn/');
                            },
                            ),
                            _socialItem(
                                platform: 'RSS',
                                username: 'MENAFN RSS Feed',
                                icon: const Icon(
                                    Icons.rss_feed_rounded,
                                    color: Color(0xFFF26522),
                                    size: 24,
                                ),
                                onTap: () {
                                    _openUrl('https://menafn.com/Rss');
                                },
                                ),
                  ],
                ),
              ),

              // -------------------------------------------------
              // FOOTER / LOGO
              // -------------------------------------------------

              //const SizedBox(height: 70),

              // Center(
              //   child: Column(
              //     children: [
              //       // Star / Logo symbol
              //       Icon(
              //         Icons.auto_awesome,
              //         size: 28,
              //         color: Colors.grey.shade300,
              //       ),

              //       const SizedBox(height: 5),

              //       const Text(
              //         'MENAFN',
              //         style: TextStyle(
              //           fontSize: 17,
              //           fontWeight: FontWeight.w500,
              //           color: Color(0xFFCCCCCC),
              //           letterSpacing: 1,
              //         ),
              //       ),

              //       const SizedBox(height: 2),

              //       Text(
              //         'Since 2000',
              //         style: TextStyle(
              //           fontSize: 8,
              //           color: Colors.grey.shade400,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
