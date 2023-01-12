import 'package:elearning/ui/shared/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

class DropAnswerWidget extends StatefulWidget {
  final List<String> answers;
  final Function(List<String> answers) callBack;

  const DropAnswerWidget({
    Key? key,
    this.answers = const [],
    required this.callBack,
  }) : super(key: key);

  @override
  State<DropAnswerWidget> createState() => _DropAnswerWidgetState();
}

class _DropAnswerWidgetState extends State<DropAnswerWidget> {
  List<Widget> contents = [];
  final List<String> _answers = [];

  @override
  void initState() {
    _answers.addAll(widget.answers);
    for (var _ in widget.answers) {
      contents.add(_buildItemDrag(_));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ReorderableWrap(
        spacing: 8.0,
        runSpacing: 8,
        padding: const EdgeInsets.all(8),
        onReorder: _onReorder,
        children: contents,
      ),
    );
  }

  Widget _buildItemDrag(String content) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColor.neutrals),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      child: Text(
        content,
        style: AppText.text14.copyWith(fontWeight: FontWeight.w700),
      ),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      Widget row = contents.removeAt(oldIndex);
      contents.insert(newIndex, row);
    });
    _answers.insert(newIndex, _answers.removeAt(oldIndex));
    widget.callBack(_answers);
  }
}
