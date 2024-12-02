import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn with Online Learning'),
      ),
      body: const FormSection(),
    );
  }
}

class FormSection extends StatefulWidget {
  const FormSection({Key? key}) : super(key: key);

  @override
  State<FormSection> createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection> {
  String selectedLevel = 'First Year';
  List<String> selectedCourses = [];
  String selectedDifficulty = 'Easy';
  final TextEditingController feedbackController = TextEditingController();
  String feedbackText = '';


  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    feedbackController.dispose();
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void toggleCourseSelection(String course, bool? value) {
    setState(() {
      if (value == true) {
        selectedCourses.add(course);
      } else {
        selectedCourses.remove(course);
      }
    });
  }

  void resetForm() {
    setState(() {
      selectedCourses.clear();
      selectedLevel = 'First Year';
      selectedDifficulty = 'Easy';
      nameController.clear();
      emailController.clear();
    });
  }

  void submitFeedback() {
    setState(() {
      feedbackText = feedbackController.text; // Capture the feedback
    });

    feedbackController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Feedback Submitted')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const SectionHeader(title: "Enter Your Name and Email:"),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Your Name'),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Your Email'),
          ),
          const SizedBox(height: 16),

          const SectionHeader(title: "Select Education Level:"),
          DropdownButton<String>(
            value: selectedLevel,
            onChanged: (value) {
              setState(() {
                selectedLevel = value!;
              });
            },
            items: ['First Year', 'Second Year', 'Last Year'].map((String level) {
              return DropdownMenuItem<String>(
                value: level,
                child: Text(level),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          const SectionHeader(title: "Select Courses to Learn:"),
          Column(
            children: [
              CourseCheckbox(
                title: 'Biology',
                value: selectedCourses.contains('BIO'),
                onChanged: (value) => toggleCourseSelection('BIO', value),
              ),
              CourseCheckbox(
                title: 'Physics',
                value: selectedCourses.contains('PHY'),
                onChanged: (value) => toggleCourseSelection('PHY', value),
              ),
              CourseCheckbox(
                title: 'Mathematics',
                value: selectedCourses.contains('MATH'),
                onChanged: (value) => toggleCourseSelection('MATH', value),
              ),
              CourseCheckbox(
                title: 'Chemistry',
                value: selectedCourses.contains('CHEM'),
                onChanged: (value) => toggleCourseSelection('CHEM', value),
              ),
            ],
          ),
          const SizedBox(height: 16),

          const SectionHeader(title: "Select Difficulty Level:"),
          Column(
            children: ['Easy', 'Medium', 'Hard'].map((difficulty) {
              return RadioListTile<String>(
                title: Text(difficulty),
                value: difficulty,
                groupValue: selectedDifficulty,
                onChanged: (value) {
                  setState(() {
                    selectedDifficulty = value!;
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          const SectionHeader(title: "Form Summary:"),
          Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 16),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Education Level: $selectedLevel"),
                  const SizedBox(height: 8),
                  Text(
                    selectedCourses.isNotEmpty
                        ? "Selected Courses: ${selectedCourses.join(', ')}"
                        : "No courses selected.",
                  ),
                  const SizedBox(height: 8),
                  Text("Difficulty Level: $selectedDifficulty"),
                  const SizedBox(height: 8),
                  Text("Name: ${nameController.text.isNotEmpty ? nameController.text : 'Not provided'}"),
                  const SizedBox(height: 8),
                  Text("Email: ${emailController.text.isNotEmpty ? emailController.text : 'Not provided'}"),
                ],
              ),
            ),
          ),

          ElevatedButton(
            onPressed: resetForm,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Reset Form'),
          ),
          const SizedBox(height: 32),

          const SectionHeader(title: "Enter Feedback After Completing the Course:"),
          TextField(
            controller: feedbackController,
            decoration: const InputDecoration(labelText: 'Your Feedback'),
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: submitFeedback,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Submit Feedback'),
          ),
          const SizedBox(height: 16),

          const SectionHeader(title: "Submitted Feedback:"),
          Text(
            feedbackText.isNotEmpty ? feedbackText : 'No feedback submitted yet.',
            style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }
}

class CourseCheckbox extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CourseCheckbox({
    Key? key,
    required this.title,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
}
