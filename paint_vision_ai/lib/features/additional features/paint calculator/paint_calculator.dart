import 'package:flutter/material.dart';
import 'package:paint_vision_ai/constants/app_colors.dart';
import 'package:paint_vision_ai/screens/additional%20features/compare%20product/compare_product.dart';
import 'package:paint_vision_ai/widgets/primary_button.dart';

class PaintCalculatorScreen extends StatefulWidget {
  const PaintCalculatorScreen({super.key});

  @override
  State<PaintCalculatorScreen> createState() => _PaintCalculatorScreenState();
}

class _PaintCalculatorScreenState extends State<PaintCalculatorScreen> {
  // Controllers for text fields
  final TextEditingController lengthController = TextEditingController(
    text: "16",
  );
  final TextEditingController widthController = TextEditingController(
    text: "12",
  );
  final TextEditingController heightController = TextEditingController(
    text: "10",
  );

  // Dropdown selections
  String selectedPaintType = "Interior Emulsion";
  String selectedCoverage = "120 Liters (Approx)";

  // Result values
  int litersNeeded = 18;
  int bucketsNeeded = 2;
  bool showResult = true;

  // Dropdown options
  final List<String> paintTypes = [
    "Interior Emulsion",
    "Exterior Emulsion",
    "Distemper",
    "Enamel Paint",
    "Primer",
  ];

  final List<String> coverageOptions = [
    "80 Liters (Approx)",
    "100 Liters (Approx)",
    "120 Liters (Approx)",
    "140 Liters (Approx)",
    "160 Liters (Approx)",
  ];

  // ✅ Calculate paint required
  void _calculatePaint() {
    // Get values from text fields
    final double length = double.tryParse(lengthController.text) ?? 0;
    final double width = double.tryParse(widthController.text) ?? 0;
    final double height = double.tryParse(heightController.text) ?? 0;

    // Validation
    if (length == 0 || width == 0 || height == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Please enter valid dimensions"),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(16),
        ),
      );
      return;
    }

    // Calculate wall area (4 walls)
    final double wallArea = 2 * (length + width) * height;

    // Get coverage per liter (extract number from string)
    final String coverageStr = selectedCoverage.split(" ")[0]; // "120"
    final double coverage = double.tryParse(coverageStr) ?? 120;

    // Calculate liters needed
    final double liters = wallArea / coverage;

    // Calculate buckets (assume 1 bucket = 10 liters)
    final int buckets = (liters / 10).ceil();

    setState(() {
      litersNeeded = liters.ceil();
      bucketsNeeded = buckets;
      showResult = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: const [
                BackButton(),
                Text(
                  'Paint Calculator',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.02),

                    // Title
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CompareScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Calculate Paint Required",
                        style: TextStyle(
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.025),

                    // Section: Room Dimensions
                    Text(
                      "Room Dimensions",
                      style: TextStyle(
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: height * 0.02),

                    // ✅ Length Input
                    _buildInputRow(
                      label: "Length (ft)",
                      controller: lengthController,
                      width: width,
                      height: height,
                    ),

                    SizedBox(height: height * 0.015),

                    // ✅ Width Input
                    _buildInputRow(
                      label: "Width (ft)",
                      controller: widthController,
                      width: width,
                      height: height,
                    ),

                    SizedBox(height: height * 0.015),

                    // ✅ Height Input
                    _buildInputRow(
                      label: "Height (ft)",
                      controller: heightController,
                      width: width,
                      height: height,
                    ),

                    SizedBox(height: height * 0.015),

                    // ✅ Paint Type Dropdown
                    _buildDropdownRow(
                      label: "Paint Type",
                      value: selectedPaintType,
                      items: paintTypes,
                      width: width,
                      height: height,
                      onChanged: (value) {
                        setState(() {
                          selectedPaintType = value!;
                        });
                      },
                    ),

                    SizedBox(height: height * 0.015),

                    // ✅ Coverage Area Dropdown
                    _buildDropdownRow(
                      label: "Coverage Area",
                      value: selectedCoverage,
                      items: coverageOptions,
                      width: width,
                      height: height,
                      onChanged: (value) {
                        setState(() {
                          selectedCoverage = value!;
                        });
                      },
                    ),

                    SizedBox(height: height * 0.03),

                    // ✅ Result Section
                    if (showResult) _buildResultSection(width, height),

                    SizedBox(height: height * 0.02),
                  ],
                ),
              ),
            ),

            // Recalculate Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: PrimaryButton(
                text: 'Recalculate',
                onTap: () {
                  _calculatePaint();
                },
              ),
            ),

            SizedBox(height: height * 0.02),
          ],
        ),
      ),
    );
  }

  // ✅ Input Row Widget (Label + TextField)
  Widget _buildInputRow({
    required String label,
    required TextEditingController controller,
    required double width,
    required double height,
  }) {
    return Row(
      children: [
        // Label
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontSize: width * 0.04,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // TextField
        Expanded(
          flex: 3,
          child: Container(
            height: height * 0.055,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(width * 0.03),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: width * 0.045,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ✅ Dropdown Row Widget (Label + Dropdown)
  Widget _buildDropdownRow({
    required String label,
    required String value,
    required List<String> items,
    required double width,
    required double height,
    required ValueChanged<String?> onChanged,
  }) {
    return Row(
      children: [
        // Label
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontSize: width * 0.04,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // Dropdown
        Expanded(
          flex: 3,
          child: Container(
            height: height * 0.055,
            padding: EdgeInsets.symmetric(horizontal: width * 0.03),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(width * 0.03),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: width * 0.037,
                        color: Colors.black87,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ✅ Result Section Widget
  Widget _buildResultSection(double width, double height) {
    return Row(
      children: [
        // Left: Text info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "You Need",
                    style: TextStyle(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: width * 0.02),
                  Icon(
                    Icons.help_outline,
                    size: width * 0.045,
                    color: Colors.grey[600],
                  ),
                ],
              ),
              SizedBox(height: height * 0.01),
              Text(
                "$litersNeeded Liters",
                style: TextStyle(
                  fontSize: width * 0.07,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: height * 0.005),
              Text(
                "($bucketsNeeded Buckets)",
                style: TextStyle(
                  fontSize: width * 0.04,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),

        // Right: Paint bucket image
        Container(
          width: width * 0.28,
          height: width * 0.28,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width * 0.02),
          ),
          child: Image.asset(
            "assets/images/fryola.png",
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.indigo[900],
                  borderRadius: BorderRadius.circular(width * 0.02),
                ),
                child: Icon(
                  Icons.format_paint,
                  color: Colors.white,
                  size: width * 0.12,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
