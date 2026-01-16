import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  final Color primaryGreen = const Color(0xFF1E8E5A);

  Future<void> _launchUrl(String url) async {
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
      color: Colors.white, // ✅ ALL CARDS WHITE
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
      onTap: () => _launchUrl(url),
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
        title: Text("terms_and_conditions".tr),
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
              "BEH Teleophthalmology",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: primaryGreen,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Effective Date: 17 August 2025",
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 16),

            const Text(
              "These Terms & Conditions govern your use of the BEH Teleophthalmology mobile applications. By using the Apps, you agree to these Terms.",
              style: TextStyle(fontSize: 14, height: 1.6),
            ),

            const SizedBox(height: 20),

            _sectionCard(
              title: "1. Definitions",
              icon: Icons.book,
              points: [
                "Patient – Registered user booking consultations",
                "Doctor – Licensed medical professional",
                "Services – Tele-consultations & prescriptions",
                "BEH – Bangladesh Eye Hospital & Institute",
              ],
            ),

            _sectionCard(
              title: "2. Eligibility",
              icon: Icons.verified_user,
              points: [
                "Patients must be 18+ or supervised by a guardian",
                "Doctors must be licensed and verified specialists",
              ],
            ),

            _sectionCard(
              title: "3. Use of Services",
              icon: Icons.medical_services,
              points: [
                "Patients may upload medical details and receive prescriptions",
                "Doctors conduct consultations and issue prescriptions",
              ],
            ),

            _sectionCard(
              title: "4. Payments",
              icon: Icons.payments,
              points: [
                "Consultation fees are shown before booking",
                "Secure third-party payment gateways are used",
                "Platform fees are deducted before payouts",
              ],
            ),

            _sectionCard(
              title: "5. Medical Disclaimer",
              icon: Icons.warning_amber,
              points: [
                "BEH is a digital platform, not a medical provider",
                "Tele-consultation does not replace physical exams",
              ],
            ),

            _sectionCard(
              title: "6. User Responsibilities",
              icon: Icons.rule,
              points: [
                "Users must keep credentials secure",
                "Doctors must follow professional standards",
              ],
            ),

            _sectionCard(
              title: "7. Data Privacy",
              icon: Icons.lock,
              points: [
                "Data use follows the Privacy Policy",
                "Patients consent to share data with doctors",
              ],
            ),

            _sectionCard(
              title: "8. Limitation of Liability",
              icon: Icons.report_problem,
              points: [
                "BEH is not responsible for medical outcomes",
                "BEH is not liable for technical failures",
              ],
            ),

            _sectionCard(
              title: "9. Governing Law",
              icon: Icons.gavel,
              points: [
                "These Terms are governed by the laws of Bangladesh",
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
              "78, Satmasjid Road, Dhanmondi, Dhaka",
              "https://maps.google.com/?q=Bangladesh+Eye+Hospital+Dhanmondi",
            ),
            _contactTile(
              Icons.phone,
              "Phone",
              "10620 / 09666787878",
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
