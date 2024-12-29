import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

final resumeProvider = StateNotifierProvider<ResumeNotifier, ResumeSettings>(
      (ref) => ResumeNotifier(),
);

class ResumeSettings {
  double fontSize;
  Color fontColor;
  Color backgroundColor;
  String name;
  String contactInfo;
  String skills;
  String education;
  String experience;

  ResumeSettings({
    this.fontSize = 14.0,
    this.fontColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.name = '',
    this.contactInfo = '',
    this.skills = '',
    this.education = '',
    this.experience = '',
  });

  ResumeSettings copyWith({
    double? fontSize,
    Color? fontColor,
    Color? backgroundColor,
    String? name,
    String? contactInfo,
    String? skills,
    String? education,
    String? experience,
  }) {
    return ResumeSettings(
      fontSize: fontSize ?? this.fontSize,
      fontColor: fontColor ?? this.fontColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      name: name ?? this.name,
      contactInfo: contactInfo ?? this.contactInfo,
      skills: skills ?? this.skills,
      education: education ?? this.education,
      experience: experience ?? this.experience,
    );
  }
}

class ResumeNotifier extends StateNotifier<ResumeSettings> {
  ResumeNotifier() : super(ResumeSettings());

  void updateFontSize(double size) {
    state = state.copyWith(fontSize: size);
  }

  void updateFontColor(Color color) {
    state = state.copyWith(fontColor: color);
  }

  void updateBackgroundColor(Color color) {
    state = state.copyWith(backgroundColor: color);
  }

  void updateName(String name) {
    state = state.copyWith(name: name);
  }

  void updateContactInfo(String info) {
    state = state.copyWith(contactInfo: info);
  }

  void updateSkills(String skills) {
    state = state.copyWith(skills: skills);
  }

  void updateEducation(String education) {
    state = state.copyWith(education: education);
  }

  void updateExperience(String experience) {
    state = state.copyWith(experience: experience);
  }
}

class ResumeGenerator extends ConsumerWidget {
  const ResumeGenerator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(resumeProvider);

    return SingleChildScrollView(
      child: Column(
        children: [
          // Name Input
          TextField(
            decoration: InputDecoration(labelText: 'Name'),
            onChanged: (value) => ref.read(resumeProvider.notifier).updateName(value),
          ),
          // Contact Information Input
          TextField(
            decoration: InputDecoration(labelText: 'Contact Information'),
            onChanged: (value) => ref.read(resumeProvider.notifier).updateContactInfo(value),
          ),
          // Skills Input
          TextField(
            decoration: InputDecoration(labelText: 'Skills'),
            onChanged: (value) => ref.read(resumeProvider.notifier).updateSkills(value),
          ),
          // Education Input
          TextField(
            decoration: InputDecoration(labelText: 'Education'),
            onChanged: (value) => ref.read(resumeProvider.notifier).updateEducation(value),
          ),
          // Experience Input
          TextField(
            decoration: InputDecoration(labelText: 'Experience'),
            onChanged: (value) => ref.read(resumeProvider.notifier).updateExperience(value),
          ),

          // Customization Controls
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('Font Size: ${settings.fontSize.toStringAsFixed(1)}'),
                Slider(
                  min: 10,
                  max: 30,
                  value: settings.fontSize,
                  onChanged: (value) => ref.read(resumeProvider.notifier).updateFontSize(value),
                ),
                Text('Font Color:'),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: settings.fontColor),
                  onPressed: () async {
                    Color? pickedColor = await showDialog<Color>(
                      context: context,
                      builder: (context) {
                        Color tempColor = settings.fontColor;
                        return AlertDialog(
                          title: Text('Pick a color!'),
                          content: SingleChildScrollView(
                            child: ColorPicker(
                              pickerColor: tempColor,
                              onColorChanged: (color) => tempColor = color,
                              labelTypes: [],  // Disable labels
                              pickerAreaHeightPercent: 0.8,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Select'),
                              onPressed: () {
                                Navigator.of(context).pop(tempColor);
                              },
                            ),
                          ],
                        );
                      },
                    );
                    if (pickedColor != null) {
                      ref.read(resumeProvider.notifier).updateFontColor(pickedColor);
                    }
                  },
                  child: Text('Choose Font Color'),
                ),
                Text('Background Color:'),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: settings.backgroundColor),
                  onPressed: () async {
                    Color? pickedColor = await showDialog<Color>(
                      context: context,
                      builder: (context) {
                        Color tempColor = settings.backgroundColor;
                        return AlertDialog(
                          title: Text('Pick a color!'),
                          content: SingleChildScrollView(
                            child: ColorPicker(
                              pickerColor: tempColor,
                              onColorChanged: (color) => tempColor = color,
                              labelTypes: [],  // Disable labels
                              pickerAreaHeightPercent: 0.8,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Select'),
                              onPressed: () {
                                Navigator.of(context).pop(tempColor);
                              },
                            ),
                          ],
                        );
                      },
                    );
                    if (pickedColor != null) {
                      ref.read(resumeProvider.notifier).updateBackgroundColor(pickedColor);
                    }
                  },
                  child: Text('Choose Background Color'),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final pdf = await generatePDF(settings);
              await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
            },
            child: Text('Generate Resume'),
          ),
        ],
      ),
    );
  }
}

Future<pw.Document> generatePDF(ResumeSettings settings) async {
  final pdf = pw.Document();

  // Convert Flutter Color to PdfColor
  final pdfBackgroundColor = PdfColor(settings.backgroundColor.red / 255,
      settings.backgroundColor.green / 255, settings.backgroundColor.blue / 255);

  final pdfFontColor = PdfColor(settings.fontColor.red / 255,
      settings.fontColor.green / 255, settings.fontColor.blue / 255);

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Container(
        color: pdfBackgroundColor,
        padding: pw.EdgeInsets.all(20), // Add padding for better layout
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(settings.name,
                style: pw.TextStyle(
                  fontSize: settings.fontSize + 4, // Larger font for Name
                  fontWeight: pw.FontWeight.bold,
                  color: pdfFontColor,
                )),
            pw.SizedBox(height: 10),
            pw.Text(settings.contactInfo,
                style: pw.TextStyle(
                  fontSize: settings.fontSize,
                  color: pdfFontColor,
                )),
            pw.SizedBox(height: 10),
            pw.Text('Skills: ${settings.skills}',
                style: pw.TextStyle(
                  fontSize: settings.fontSize,
                  color: pdfFontColor,
                )),
            pw.SizedBox(height: 10),
            pw.Text('Education: ${settings.education}',
                style: pw.TextStyle(
                  fontSize: settings.fontSize,
                  color: pdfFontColor,
                )),
            pw.SizedBox(height: 10),
            pw.Text('Experience: ${settings.experience}',
                style: pw.TextStyle(
                  fontSize: settings.fontSize,
                  color: pdfFontColor,
                )),
          ],
        ),
      ),
    ),
  );
  return pdf;
}