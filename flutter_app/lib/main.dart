// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conflict & Peace Predictor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.grey[100],
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late VideoPlayerController _controller;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    // Lock orientation to portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    
    // Initialize video player
    _controller = VideoPlayerController.asset('assets/videos/1116.mp4')
      ..initialize().then((_) {
        setState(() {
          _isVideoInitialized = true;
          // Set video to loop
          _controller.setLooping(true);
          // Set video to play
          _controller.play();
          // Ensure the video fills the screen
          _controller.setVolume(0.0);
        });
      }).catchError((error) {
        print("Error initializing video: $error");
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Video Background
          _isVideoInitialized
              ? SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _controller.value.size.width,
                      height: _controller.value.size.height,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                )
              : Container(
                  color: Colors.black,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ),
          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Column(
              children: [
                // App Bar
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white30),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Text(
                          'CONFLICT ANALYTICS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Main Content
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Modern looking title with gradient
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [Colors.blue, Colors.white],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds),
                          child: const Text(
                            'Peace & Conflict\nPrediction System',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.2,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Text(
                            'Advanced analytics for predicting conflict risks and peace-building success rates using machine learning',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              height: 1.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 48),
                        // Statistics Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildStatistic('95%', 'Accuracy'),
                            _buildStatistic('150+', 'Countries'),
                            _buildStatistic('10K+', 'Predictions'),
                          ],
                        ),
                        const SizedBox(height: 48),
                        // Start Analysis Button
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PredictionScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 48,
                              vertical: 20,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 8,
                            shadowColor: Colors.blue.withOpacity(0.5),
                          ),
                          child: const Text(
                            'START ANALYSIS',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Footer
                const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Text(
                    '© 2024 Conflict Analytics System',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatistic(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
// Prediction input screen

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({Key? key}) : super(key: key);

  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> controllers = {
    'poverty': TextEditingController(),
    'unemployment': TextEditingController(),
    'education': TextEditingController(),
    'stability': TextEditingController(),
    'corruption': TextEditingController(),
    'ethnic': TextEditingController(),
    'religious': TextEditingController(),
    'density': TextEditingController(),
  };

  bool isLoading = false;
  String? error;
  Map<String, dynamic>? predictions;

  // Custom colors
  final Color primaryColor = const Color(0xFF2E4057);
  final Color accentColor = const Color(0xFF48A9A6);
  final Color cardColor = const Color(0xFFF4F6F8);
  final Color textColor = const Color(0xFF1A1F2C);

  Future<void> fetchPrediction() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final response = await http.post(
        Uri.parse('https://african-conflict-api.onrender.com/predict'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'Poverty_Rate': double.parse(controllers['poverty']!.text),
          'Unemployment_Rate': double.parse(controllers['unemployment']!.text),
          'Education_Index': double.parse(controllers['education']!.text),
          'Political_Stability_Index': double.parse(controllers['stability']!.text),
          'Corruption_Perception_Index': double.parse(controllers['corruption']!.text),
          'Ethnic_Diversity_Index': double.parse(controllers['ethnic']!.text),
          'Religious_Diversity_Index': double.parse(controllers['religious']!.text),
          'Population_Density': double.parse(controllers['density']!.text),
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          predictions = json.decode(response.body);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultsScreen(predictions: predictions!),
            ),
          );
        });
      } else {
        setState(() {
          error = 'Server error: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [primaryColor, primaryColor.withOpacity(0.8)],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              // Custom App Bar
              SliverAppBar(
                expandedHeight: 120,
                floating: true,
                pinned: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    'Conflict Risk Assessment',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [primaryColor, primaryColor.withOpacity(0.8)],
                      ),
                    ),
                  ),
                ),
              ),

              // Form Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _buildSection(
                          'Economic Indicators',
                          Icons.bar_chart, // Changed icon
                          [
                            _buildInputField(
                              controllers['poverty']!,
                              'Poverty Rate',
                              'Enter value (0-100%)',
                              (value) => _validatePercentage(value, 'Poverty rate'),
                              icon: Icons.money_off, // Changed icon
                            ),
                            _buildInputField(
                              controllers['unemployment']!,
                              'Unemployment Rate',
                              'Enter value (0-100%)',
                              (value) => _validatePercentage(value, 'Unemployment rate'),
                              icon: Icons.work_off, // Changed icon
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildSection(
                          'Social Indicators',
                          Icons.groups, // Changed icon
                          [
                            _buildInputField(
                              controllers['education']!,
                              'Education Index',
                              'Enter value (0-1)',
                              (value) => _validateRange(value, 'Education index', 0, 1),
                              icon: Icons.school, // This icon exists
                            ),
                            _buildInputField(
                              controllers['ethnic']!,
                              'Ethnic Diversity Index',
                              'Enter value (0-1)',
                              (value) => _validateRange(value, 'Ethnic diversity index', 0, 1),
                              icon: Icons.people_alt, // Changed icon
                            ),
                            _buildInputField(
                              controllers['religious']!,
                              'Religious Diversity Index',
                              'Enter value (0-1)',
                              (value) => _validateRange(value, 'Religious diversity index', 0, 1),
                              icon: Icons.maps_home_work, // Changed icon
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildSection(
                          'Governance Indicators',
                          Icons.account_balance, // This icon exists
                          [
                            _buildInputField(
                              controllers['stability']!,
                              'Political Stability Index',
                              'Enter value (-2.5 to 2.5)',
                              (value) => _validateNumber(value, 'Political stability index'),
                              icon: Icons.security, // Changed icon
                            ),
                            _buildInputField(
                              controllers['corruption']!,
                              'Corruption Perception Index',
                              'Enter value (0-100)',
                              (value) => _validatePercentage(value, 'Corruption perception index'),
                              icon: Icons.warning, // Changed icon
                            ),
                            _buildInputField(
                              controllers['density']!,
                              'Population Density',
                              'Enter value (people/km²)',
                              (value) => _validatePositiveNumber(value, 'Population density'),
                              icon: Icons.group, // This icon exists
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        if (error != null)
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.red.withOpacity(0.3)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.error_outline, color: Colors.red),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    error!,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : fetchPrediction,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: accentColor, // Updated from primary
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                            ),
                            child: isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text(
                                    'Generate Prediction',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, IconData headerIcon, List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(headerIcon, color: accentColor),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: children),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildInputField(
    TextEditingController controller,
    String label,
    String hint,
    String? Function(String?) validator, {
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon, color: accentColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: accentColor, width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[-0-9.]')),
        ],
        validator: validator,
      ),
    );
  }

  // Validation helpers remain the same
  String? _validatePercentage(String? value, String field) {
    if (value == null || value.isEmpty) return '$field is required';
    final number = double.tryParse(value);
    if (number == null) return 'Please enter a valid number';
    if (number < 0 || number > 100) return '$field must be between 0 and 100';
    return null;
  }

  String? _validateRange(String? value, String field, double min, double max) {
    if (value == null || value.isEmpty) return '$field is required';
    final number = double.tryParse(value);
    if (number == null) return 'Please enter a valid number';
    if (number < min || number > max) return '$field must be between $min and $max';
    return null;
  }

  String? _validateNumber(String? value, String field) {
    if (value == null || value.isEmpty) return '$field is required';
    if (double.tryParse(value) == null) return 'Please enter a valid number';
    return null;
  }

  String? _validatePositiveNumber(String? value, String field) {
    if (value == null || value.isEmpty) return '$field is required';
    final number = double.tryParse(value);
    if (number == null) return 'Please enter a valid number';
    if (number < 0) return '$field must be positive';
    return null;
  }
}

// Results Screen with Visualizations
class ResultsScreen extends StatelessWidget {
  final Map<String, dynamic> predictions;

  const ResultsScreen({Key? key, required this.predictions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final conflictRisk = predictions['conflict_risk_prediction'] as double;
    final peaceSuccess = predictions['peacebuilding_success_rate'] as double;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Prediction Results'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Risk Assessment',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 200,
                      child: PieChart(
                        PieChartData(
                          sections: [
                            PieChartSectionData(
                              color: Colors.red,
                              value: conflictRisk,
                              title: '${conflictRisk.toStringAsFixed(1)}%',
                              radius: 100,
                              titleStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            PieChartSectionData(
                              color: Colors.grey,
                              value: 100 - conflictRisk,
                              title: '',
                              radius: 100,
                            ),
                          ],
                          sectionsSpace: 0,
                          centerSpaceRadius: 40,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Conflict Risk',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Peace-building Potential',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 200,
                      child: PieChart(
                        PieChartData(
                          sections: [
                            PieChartSectionData(
                              color: Colors.green,
                              value: peaceSuccess,
                              title: '${peaceSuccess.toStringAsFixed(1)}%',
                              radius: 100,
                              titleStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            PieChartSectionData(
                              color: Colors.grey,
                              value: 100 - peaceSuccess,
                              title: '',
                              radius: 100,
                            ),
                          ],
                          sectionsSpace: 0,
                          centerSpaceRadius: 40,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Peace-building Success Rate',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Analysis Summary',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildSummaryItem(
                      'Conflict Risk Level',
                      _getRiskLevel(conflictRisk),
                      _getRiskColor(conflictRisk),
                    ),
                    const SizedBox(height: 8),
                    _buildSummaryItem(
                      'Peace-building Outlook',
                      _getPeaceOutlook(peaceSuccess),
                      _getPeaceColor(peaceSuccess),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Recommendations:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getRecommendations(conflictRisk, peaceSuccess),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'New Analysis',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color),
          ),
          child: Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  String _getRiskLevel(double risk) {
    if (risk < 30) return 'Low Risk';
    if (risk < 60) return 'Moderate Risk';
    return 'High Risk';
  }

  Color _getRiskColor(double risk) {
    if (risk < 30) return Colors.green;
    if (risk < 60) return Colors.orange;
    return Colors.red;
  }

  String _getPeaceOutlook(double peace) {
    if (peace > 70) return 'Favorable';
    if (peace > 40) return 'Moderate';
    return 'Challenging';
  }

  Color _getPeaceColor(double peace) {
    if (peace > 70) return Colors.green;
    if (peace > 40) return Colors.orange;
    return Colors.red;
  }

  String _getRecommendations(double risk, double peace) {
    if (risk > 60) {
      return 'Immediate conflict prevention measures recommended. Focus on reducing societal tensions and strengthening governance structures.';
    } else if (risk > 30) {
      return 'Monitor situation closely. Implement preventive measures and strengthen peace-building initiatives.';
    } else {
      return 'Maintain current stability measures. Focus on sustainable development and social cohesion programs.';
    }
  }
}