// features/portfolio/presentation/widgets/contact_section.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/app_theme.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isSubmitting = false;
  late AnimationController _submitController;
  late Animation<double> _submitAnimation;

  @override
  void initState() {
    super.initState();
    _submitController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _submitAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _submitController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    _submitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : isTablet ? 24 : 40),
      child: Column(
        children: [
          ShaderMask(
            shaderCallback:
                (bounds) => const LinearGradient(
                  colors: [AppTheme.primaryBlue, AppTheme.secondaryBlue],
                ).createShader(bounds),
            child: Text(
              'Get In Touch',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: isMobile ? 28 : isTablet ? 32 : 36,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: isMobile ? 12 : 16),
          Text(
            'Ready to transform your ideas into reality? Let\'s collaborate!',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: isMobile ? 16 : 18,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: isMobile ? 32 : 48),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 768) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildContactInfo()),
                    const SizedBox(width: 64),
                    Expanded(child: _buildContactForm()),
                  ],
                );
              } else {
                return Column(
                  children: [
                    _buildContactInfo(),
                    SizedBox(height: isMobile ? 24 : 32),
                    _buildContactForm(),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Let's Build Something Amazing!",
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontSize: isMobile ? 20 : 24,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: isMobile ? 16 : 24),
        Text(
          "🚀 Available for exciting opportunities!\n\n• Full-time positions\n• Freelance projects\n• Remote collaborations\n• App development consultations\n\nSpecializing in Flutter, Firebase, and creating seamless user experiences that drive real business results.",
          style: TextStyle(
            color: AppTheme.textSecondary,
            height: 1.6,
            fontSize: isMobile ? 14 : 16,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: isMobile ? 24 : 32),

        // Contact Details
        _buildContactItem(
          Icons.email_rounded,
          'muhammadwasifshah629@gmail.com',
          () => _launchEmail('muhammadwasifshah629@gmail.com'),
          showCopy: true,
        ),
        SizedBox(height: isMobile ? 12 : 16),
        _buildContactItem(
          Icons.location_on_rounded,
          'Okara District, Punjab, Pakistan',
          null,
        ),
        SizedBox(height: isMobile ? 12 : 16),
        _buildContactItem(
          Icons.school_rounded,
          'COMSATS University Islamabad',
          null,
        ),
        SizedBox(height: isMobile ? 12 : 16),
        _buildContactItem(
          Icons.work_history_rounded,
          'Available for immediate start',
          null,
        ),

        SizedBox(height: isMobile ? 24 : 32),

        // Professional Quote
        Container(
          padding: EdgeInsets.all(isMobile ? 16 : 20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.primaryBlue.withOpacity(0.1),
                AppTheme.secondaryBlue.withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.lightbulb_outline_rounded,
                color: AppTheme.primaryBlue,
                size: isMobile ? 20 : 24,
              ),
              SizedBox(width: isMobile ? 8 : 12),
              Expanded(
                child: Text(
                  '"Clean code, innovative solutions, exceptional results."',
                  style: TextStyle(
                    color: AppTheme.primaryBlue,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                    fontSize: isMobile ? 14 : 16,
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: isMobile ? 24 : 32),
        _buildSocialLinks(),

        SizedBox(height: isMobile ? 16 : 24),

        // Response Time Badge
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 12 : 16, 
            vertical: isMobile ? 6 : 8
          ),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.green.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.flash_on_rounded, color: Colors.green, size: isMobile ? 14 : 16),
              SizedBox(width: isMobile ? 4 : 4),
              Text(
                'Usually responds within 24 hours',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: isMobile ? 11 : 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactItem(
    IconData icon,
    String text,
    VoidCallback? onTap, {
    bool showCopy = false,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(isMobile ? 10 : 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.1)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(isMobile ? 6 : 8),
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: AppTheme.primaryBlue, size: isMobile ? 18 : 20),
            ),
            SizedBox(width: isMobile ? 8 : 12),
            Flexible(
              child: Text(
                text,
                style: TextStyle(
                  color: AppTheme.textSecondary,
                  fontWeight: FontWeight.w500,
                  fontSize: isMobile ? 13 : 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (showCopy) ...[
              SizedBox(width: isMobile ? 6 : 8),
              InkWell(
                onTap: () => _copyToClipboard(text),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(
                    Icons.copy_rounded,
                    size: isMobile ? 14 : 16,
                    color: AppTheme.primaryBlue,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSocialLinks() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    
    final socialLinks = [
      {
        'name': 'GitHub',
        'icon': 'assets/icons/github.png', // Use your GitHub icon
        'url': 'https://github.com/muhammadwasif12',
        'color': Colors.white,
      },
      {
        'name': 'LinkedIn',
        'icon': null, // Flutter icon
        'flutter_icon': Icons.work,
        'url':
            'https://www.linkedin.com/in/muhammad-wasif-%F0%9F%87%B5%F0%9F%87%B8-b97577347',
        'color': const Color(0xFF0077B5),
      },
      {
        'name': 'Email',
        'icon': null, // Flutter icon
        'flutter_icon': Icons.email_rounded,
        'url': 'mailto:muhammadwasifshah629@gmail.com',
        'color': AppTheme.primaryBlue,
      },
    ];

    return Column(
      children: [
        Text(
          'Connect with me',
          style: TextStyle(
            color: AppTheme.textSecondary,
            fontSize: isMobile ? 14 : 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: isMobile ? 12 : 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: socialLinks.map((link) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 6 : 8),
              child: Tooltip(
                message: link['name'] as String,
                child: InkWell(
                  onTap: () => _launchUrl(link['url'] as String),
                  borderRadius: BorderRadius.circular(30),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: isMobile ? 50 : 60,
                    height: isMobile ? 50 : 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          (link['color'] as Color).withOpacity(0.1),
                          (link['color'] as Color).withOpacity(0.2),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: (link['color'] as Color).withOpacity(0.3),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: (link['color'] as Color).withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: link['icon'] != null
                        ? Padding(
                            padding: EdgeInsets.all(isMobile ? 10 : 12),
                            child: Image.asset(
                              link['icon'] as String,
                              color: link['color'] as Color,
                            ),
                          )
                        : Icon(
                            link['flutter_icon'] as IconData,
                            color: link['color'] as Color,
                            size: isMobile ? 24 : 28,
                          ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildContactForm() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    
    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : isTablet ? 24 : 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.08),
            Colors.white.withOpacity(0.03),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.primaryBlue.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryBlue.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.send_rounded, color: AppTheme.primaryBlue, size: isMobile ? 24 : 28),
                SizedBox(width: isMobile ? 8 : 12),
                Expanded(
                  child: Text(
                    'Send Me a Message',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontSize: isMobile ? 20 : 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: isMobile ? 4 : 8),
            Text(
              'I\'d love to hear about your project ideas!',
              style: TextStyle(
                color: Colors.grey[400], 
                fontSize: isMobile ? 14 : 16
              ),
            ),
            SizedBox(height: isMobile ? 24 : 32),

            // Name and Email fields - Stack vertically on mobile
            if (isMobile) ...[
              _buildFormField(
                'Full Name',
                _nameController,
                icon: Icons.person_outline_rounded,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildFormField(
                'Email Address',
                _emailController,
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value!)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
            ] else ...[
              // Desktop/Tablet - Side by side
              Row(
                children: [
                  Expanded(
                    child: _buildFormField(
                      'Full Name',
                      _nameController,
                      icon: Icons.person_outline_rounded,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildFormField(
                      'Email Address',
                      _emailController,
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value!)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ],

            SizedBox(height: isMobile ? 16 : 20),

            _buildFormField(
              'Subject',
              _subjectController,
              icon: Icons.subject_rounded,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter a subject';
                }
                return null;
              },
            ),

            SizedBox(height: isMobile ? 16 : 20),

            _buildFormField(
              'Your Message',
              _messageController,
              icon: Icons.message_outlined,
              maxLines: isMobile ? 4 : 5,
              hintText:
                  'Tell me about your project, requirements, timeline, or any questions you have...',
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your message';
                }
                if (value!.length < 20) {
                  return 'Please provide more details (minimum 20 characters)';
                }
                return null;
              },
            ),

            SizedBox(height: isMobile ? 24 : 32),

            AnimatedBuilder(
              animation: _submitAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _submitAnimation.value,
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isSubmitting ? null : _sendMessage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryBlue,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: isMobile ? 16 : 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 8,
                        shadowColor: AppTheme.primaryBlue.withOpacity(0.3),
                      ),
                      child: _isSubmitting
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: isMobile ? 18 : 20,
                                  height: isMobile ? 18 : 20,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: isMobile ? 8 : 12),
                                Text(
                                  'Sending Message...',
                                  style: TextStyle(
                                    fontSize: isMobile ? 14 : 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.send_rounded, size: isMobile ? 20 : 22),
                                SizedBox(width: isMobile ? 8 : 12),
                                Text(
                                  'Send Message',
                                  style: TextStyle(
                                    fontSize: isMobile ? 14 : 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: isMobile ? 12 : 16),

            // Email confirmation note
            Container(
              padding: EdgeInsets.all(isMobile ? 12 : 16),
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.primaryBlue.withOpacity(0.1),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: AppTheme.primaryBlue,
                    size: isMobile ? 18 : 20,
                  ),
                  SizedBox(width: isMobile ? 6 : 8),
                  Expanded(
                    child: Text(
                      'Your message will be sent directly to muhammadwasifshah629@gmail.com',
                      style: TextStyle(
                        color: AppTheme.primaryBlue,
                        fontWeight: FontWeight.w500,
                        fontSize: isMobile ? 12 : 14,
                      ),
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

  Widget _buildFormField(
    String label,
    TextEditingController controller, {
    IconData? icon,
    int maxLines = 1,
    String? hintText,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (icon != null) ...[
              Icon(icon, color: AppTheme.primaryBlue, size: isMobile ? 14 : 16),
              SizedBox(width: isMobile ? 4 : 6),
            ],
            Text(
              label,
              style: TextStyle(
                color: AppTheme.primaryBlue,
                fontWeight: FontWeight.w600,
                fontSize: isMobile ? 12 : 14,
              ),
            ),
          ],
        ),
        SizedBox(height: isMobile ? 6 : 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          style: TextStyle(
            color: AppTheme.textPrimary, 
            fontSize: isMobile ? 14 : 14
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey[500], 
              fontSize: isMobile ? 13 : 14
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(0.08),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppTheme.primaryBlue.withOpacity(0.2),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppTheme.primaryBlue.withOpacity(0.2),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppTheme.primaryBlue,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            contentPadding: EdgeInsets.all(isMobile ? 14 : 16),
          ),
        ),
      ],
    );
  }

  void _sendMessage() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isSubmitting = true;
      });

      _submitController.forward();

      await Future.delayed(const Duration(milliseconds: 300));

      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final subject = _subjectController.text.trim();
      final message = _messageController.text.trim();

      // Enhanced email body with better formatting
      final body = '''
🚀 NEW PROJECT INQUIRY 🚀

👤 Contact Information:
━━━━━━━━━━━━━━━━━━━━
• Name: $name
• Email: $email
• Date: ${DateTime.now().toLocal().toString().split(' ')[0]}

📧 Subject: $subject

💬 Message:
━━━━━━━━━━━━━━━━━━━━
$message

━━━━━━━━━━━━━━━━━━━━
📩 Sent from Muhammad Wasif Portfolio
🌐 Website: https://muhammadwasif.dev
      ''';

      final encodedSubject = Uri.encodeComponent('Portfolio Inquiry: $subject');
      final encodedBody = Uri.encodeComponent(body);

      // Multiple email options
      final gmailUrl =
          'https://mail.google.com/mail/?view=cm&fs=1&to=muhammadwasifshah629@gmail.com&su=$encodedSubject&body=$encodedBody';
      final mailtoUrl =
          'mailto:muhammadwasifshah629@gmail.com?subject=$encodedSubject&body=$encodedBody';

      try {
        // Try Gmail first, then fallback to mailto
        if (!await launchUrl(Uri.parse(gmailUrl))) {
          await launchUrl(Uri.parse(mailtoUrl));
        }

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Message Prepared Successfully!',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Your email client opened with the message ready to send to Muhammad Wasif.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.green[600],
              duration: const Duration(seconds: 5),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );

          // Clear form
          _formKey.currentState?.reset();
          _nameController.clear();
          _emailController.clear();
          _subjectController.clear();
          _messageController.clear();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Could not open email client',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Please email muhammadwasifshah629@gmail.com directly',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.orange[600],
              duration: const Duration(seconds: 5),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }

      _submitController.reverse();

      setState(() {
        _isSubmitting = false;
      });
    }
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text('Copied: $text'),
          ],
        ),
        backgroundColor: AppTheme.primaryBlue,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _launchUrl(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  void _launchEmail(String email) async {
    try {
      final Uri uri = Uri.parse('mailto:$email');
      if (!await launchUrl(uri)) {
        debugPrint('Could not launch $email');
      }
    } catch (e) {
      debugPrint('Error launching email: $e');
    }
  }
}