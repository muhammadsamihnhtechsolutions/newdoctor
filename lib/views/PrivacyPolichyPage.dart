import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  final Color primaryGreen = const Color(0xFF1E8E5A);

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  /// ---------------- SECTION CARD ----------------
  Widget _sectionCard({
    required String title,
    required IconData icon,
    required List<String> points,
  }) {
    return Card(
      color: Colors.white,
      elevation: 0.8,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: primaryGreen.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: primaryGreen, size: 20),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryGreen,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...points.map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  "• $e",
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.6,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ---------------- CONTACT TILE ----------------
  Widget _contactTile(
      IconData icon, String label, String value, String url) {
    return ListTile(
      onTap: () => _launch(url),
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 18,
        backgroundColor: primaryGreen.withOpacity(0.12),
        child: Icon(icon, color: primaryGreen, size: 18),
      ),
      title: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        value,
        style: TextStyle(
          color: primaryGreen,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  /// ---------------- UI ----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text("privacy_policy".tr),
        backgroundColor: Colors.white,
            foregroundColor: Colors.black,
        elevation: 0.5,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            Text(
              "Privacy Policy – BEH Teleophthalmology",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: primaryGreen,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Effective Date: 17 August 2025\nLast Updated: 17 August 2025",
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 16),

            const Text(
              "BEH Teleophthalmology operates the BEH Patient App and BEH Doctor App. "
              "We are committed to protecting your personal, medical, and financial data.",
              style: TextStyle(fontSize: 14, height: 1.6),
            ),

            const SizedBox(height: 20),

            _sectionCard(
              title: "1. Information We Collect",
              icon: Icons.inventory_2,
              points: [
                "Patient personal and medical information including eye images",
                "Doctor professional credentials and consultation data",
                "Payment and transaction details",
                "Device, usage logs, and crash reports",
              ],
            ),

            _sectionCard(
              title: "2. How We Use Your Information",
              icon: Icons.settings,
              points: [
                "To enable tele-consultations and medical records",
                "To process secure payments",
                "To comply with legal obligations",
                "To improve app performance and security",
              ],
            ),

            _sectionCard(
              title: "3. Data Storage & Protection",
              icon: Icons.lock,
              points: [
                "All sensitive data is encrypted",
                "Medical data follows healthcare security standards",
                "Payments handled by trusted third-party providers",
              ],
            ),

            _sectionCard(
              title: "4. Sharing of Information",
              icon: Icons.share,
              points: [
                "We never sell or rent your data",
                "Shared only with consent or legal requirements",
                "Used for fraud prevention when necessary",
              ],
            ),

            _sectionCard(
              title: "5. Data Retention",
              icon: Icons.storage,
              points: [
                "Records retained according to legal requirements",
                "Account deletion requests handled as per law",
              ],
            ),

            _sectionCard(
              title: "6. Your Rights",
              icon: Icons.verified_user,
              points: [
                "Access or correct your personal data",
                "Request deletion or withdraw consent",
                "Lodge complaints with authorities",
              ],
            ),

            _sectionCard(
              title: "7. Children’s Privacy",
              icon: Icons.child_care,
              points: [
                "Patient App intended for adults or supervised minors",
              ],
            ),

            _sectionCard(
              title: "8. Security Commitment",
              icon: Icons.security,
              points: [
                "Strong technical and administrative safeguards",
                "Users must keep login credentials secure",
              ],
            ),

            _sectionCard(
              title: "9. Policy Updates",
              icon: Icons.update,
              points: [
                "Policy may be updated periodically",
                "Continued use means acceptance of updates",
              ],
            ),

            const SizedBox(height: 8),

            Text(
              "Contact Us",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryGreen,
              ),
            ),

            _contactTile(
              Icons.location_on,
              "Address",
              "78, Satmasjid Road, Dhanmondi, Dhaka-1209",
              "https://maps.google.com/?q=78, Satmasjid Road, Dhanmondi, Dhaka-1209",
            ),
            _contactTile(
              Icons.phone,
              "Phone",
              "10620, 09666787878",
              "tel:10620",
            ),
            _contactTile(
              Icons.email,
              "Email",
              "info@bdeyehospital.com",
              "mailto:info@bdeyehospital.com",
            ),
            _contactTile(
              Icons.language,
              "Website",
              "dhanmondi.bdeyehospital.com",
              "https://dhanmondi.bdeyehospital.com",
            ),

            const SizedBox(height: 20),

            Center(
              child: Text(
                "© Bangladesh Eye Hospital & Institute",
                style: TextStyle(color: Colors.black45, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
