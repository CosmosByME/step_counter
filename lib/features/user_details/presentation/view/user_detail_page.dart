import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_counter/core/widgets/custom_text_field.dart';
import 'package:step_counter/features/user_details/presentation/cubit/user_details_cubit.dart';
import 'package:step_counter/features/user_details/presentation/widgets/gender_selector.dart';

import '../../../steps/presentation/view/step_page.dart';

class UserDetailPage extends StatefulWidget {
  const UserDetailPage({super.key});

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  String _selectedGender = 'male';

  @override
  void dispose() {
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      // Gradient placed on top-level Container ensures 100% screen coverage
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorScheme.surface, colorScheme.surfaceContainerHighest],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Let gradient show through
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: BlocConsumer<UserDetailsCubit, UserDetailsState>(
            listener: (context, state) {},
            builder: (context, state) {
              return SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 28),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: colorScheme.surfaceContainer,
                        border: Border.all(color: colorScheme.outlineVariant),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Body Characteristics',
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Set your profile for better calorie and activity estimates.',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: colorScheme.onSurfaceVariant),
                          ),
                          const SizedBox(height: 18),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Gender',
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                const SizedBox(height: 8),
                                GenderSelector(
                                  selectedGender: _selectedGender,
                                  onChanged: (value) {
                                    setState(() => _selectedGender = value);
                                  },
                                ),
                                const SizedBox(height: 12),
                                CustomTextField(
                                  controller: _ageController,
                                  hintText: 'Enter your age',
                                  isNumber: true,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Age is required';
                                    }
                                    if (int.tryParse(value.trim()) == null) {
                                      return 'Age must be a valid number';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 12),
                                CustomTextField(
                                  controller: _heightController,
                                  hintText: 'Enter your height (cm)',
                                  isNumber: true,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Height is required';
                                    }
                                    if (double.tryParse(value.trim()) == null) {
                                      return 'Height must be a valid number';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 12),
                                CustomTextField(
                                  controller: _weightController,
                                  hintText: 'Enter your weight (kg)',
                                  isNumber: true,
                                  validator: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return 'Weight is required';
                                    }
                                    if (double.tryParse(value.trim()) == null) {
                                      return 'Weight must be a valid number';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 18),
                                // Stretches the Submit button to full width
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF61FF59),
                                      foregroundColor: Colors.black,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (!(_formKey.currentState?.validate() ??
                                          false)) {
                                        return;
                                      }
                                      final age = int.parse(
                                        _ageController.text.trim(),
                                      );
                                      final height = double.parse(
                                        _heightController.text.trim(),
                                      );
                                      final weight = double.parse(
                                        _weightController.text.trim(),
                                      );
                                      context
                                          .read<UserDetailsCubit>()
                                          .saveUserDetails({
                                            'age': age,
                                            'heightCm': height,
                                            'weightKg': weight,
                                            'gender': _selectedGender,
                                          });
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const StepPage(),
                                        ),
                                      );
                                    },
                                    child: const Text('Submit'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
