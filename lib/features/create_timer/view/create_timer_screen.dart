import 'package:flutter/material.dart';
import 'package:fleet_assignment/app/widgets/app_background.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:go_router/go_router.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../../app/data/models/task_model.dart';
import '../../../app/data/models/timer_model.dart';
import '../../timers_list/bloc/timer_bloc.dart';

class CreateTimerScreen extends StatefulWidget {
  const CreateTimerScreen({super.key});

  @override
  State<CreateTimerScreen> createState() => _CreateTimerScreenState();
}

class _CreateTimerScreenState extends State<CreateTimerScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedProjectId;
  String? _selectedTaskId;
  String _description = '';
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
      appBar: AppBar(
        title: const Text('Create Timer'),
      ),
      body: BlocBuilder<TimerBloc, TimerState>(
        builder: (context, state) {
          if (state is! TimerLoadSuccess) {
            return const Center(child: CircularProgressIndicator());
          }

          final projects = state.projects;
          final tasks = _selectedProjectId == null
              ? <TaskModel>[]
              : state.tasks.where((t) => t.projectId == _selectedProjectId).toList();

          return Padding(
            padding: EdgeInsets.all(16.r),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField2<String>(
                    value: _selectedProjectId,
                    hint: const Text('Select Project'),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(color: Color(0x29FFFFFF), width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(color: Color(0x29FFFFFF), width: 2),
                      ),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 300.h,
                      width: 361.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: const Color(0xFF0C1D4D),
                        border: Border.all(color: const Color(0x29FFFFFF), width: 2),
                      ),
                      offset: const Offset(0, -5),
                    ),
                    iconStyleData: IconStyleData(
                      icon: Icon(Icons.arrow_drop_down, color: Colors.white.withOpacity(0.7)),
                    ),
                    isExpanded: true,
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.zero,
                    ),
                    menuItemStyleData: MenuItemStyleData(
                      height: 56.h,
                    ),
                    items: projects.map((project) {
                      return DropdownMenuItem<String>(
                        value: project.id,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.w),
                          child: Text(
                            project.name,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedProjectId = value;
                        _selectedTaskId = null;
                      });
                    },
                    validator: (value) => value == null ? 'Please select a project' : null,
                  ),
                  SizedBox(height: 16.h),
                  DropdownButtonFormField2<String>(
                    value: _selectedTaskId,
                    hint: const Text('Select Task'),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(color: Color(0x29FFFFFF), width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(color: Color(0x29FFFFFF), width: 2),
                      ),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      maxHeight: 300.h,
                      width: 361.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: const Color(0xFF0C1D4D),
                        border: Border.all(color: const Color(0x29FFFFFF), width: 2),
                      ),
                      offset: const Offset(0, -5),
                    ),
                    iconStyleData: IconStyleData(
                      icon: Icon(Icons.arrow_drop_down, color: Colors.white.withOpacity(0.7)),
                    ),
                    isExpanded: true,
                    buttonStyleData: const ButtonStyleData(
                      padding: EdgeInsets.zero,
                    ),
                    menuItemStyleData: MenuItemStyleData(
                      height: 56.h,
                    ),
                    items: tasks.map((task) {
                      return DropdownMenuItem<String>(
                        value: task.id,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 0.w),
                          child: Text(
                            task.name,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedTaskId = value;
                      });
                    },
                    validator: (value) => value == null ? 'Please select a task' : null,
                  ),
                  SizedBox(height: 16.h),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Description',
                      filled: true,
                      fillColor: Colors.transparent,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(color: Color(0x29FFFFFF), width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(color: Color(0x29FFFFFF), width: 2),
                      ),
                      isDense: false,
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                    onSaved: (value) => _description = value ?? '',
                    validator: (value) => (value?.isEmpty ?? true) ? 'Please enter a description' : null,
                  ),
                  SizedBox(height: 16.h),
                  CheckboxListTile(
                    title: const Text('Favorite'),
                    value: _isFavorite,
                    onChanged: (value) {
                      setState(() {
                        _isFavorite = value ?? false;
                      });
                    },
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          final newTimer = TimerModel(
                            id: const Uuid().v4(),
                            description: _description,
                            projectId: _selectedProjectId!,
                            taskId: _selectedTaskId!,
                            isFavorite: _isFavorite,
                          );
                          context.read<TimerBloc>().add(AddTimer(newTimer));
                          context.pop();
                        }
                      },
                      child: const Text('Add Timer'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ));
  }
}
