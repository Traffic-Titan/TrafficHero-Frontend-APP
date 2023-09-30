// ignore_for_file: camel_case_types, file_names, prefer_typing_uninitialized_variables, non_constant_identifier_names, prefer_const_constructors_in_immutables, unnecessary_set_literal, must_be_immutable

import 'package:traffic_hero/Imports.dart';

class dropDown_Select extends StatefulWidget {
  dropDown_Select(
      {super.key,
      required this.List_value,
      required this.Select_Value,
      required this.primaryColor,
      required this.select_name_English,
      required this.select_name,
      required this.onChange});

  late var Select_Value;
  late final List_value;
  late final primaryColor;
  late var select_name_English;
  late var select_name;
   Function? onChange;
   

  @override
  State<dropDown_Select> createState() => _dropDown_SelectState();
}

class _dropDown_SelectState extends State<dropDown_Select> {
  @override
  Widget build(BuildContext context) {
    return SmartSelect<String>.multiple(
        title: widget.select_name,
        placeholder: widget.select_name_English,
        selectedValue: widget.Select_Value,
        onChange: (selected) {
          widget.onChange;

          setState(() => {
                widget.Select_Value = selected.value,
                widget.onChange
                
              });
        },
        
        choiceItems: S2Choice.listFrom<String, Map<String, String>>(
          source: widget.List_value,
          value: (index, item) => item['value'] ?? '',
          title: (index, item) => item['title'] ?? '',
          group: (index, item) => item['body'] ?? '',
        ),
        choiceActiveStyle: const S2ChoiceStyle(color: Colors.redAccent),
        modalType: S2ModalType.bottomSheet,
        modalConfirm: true,
        modalFilter: true,
        groupEnabled: true,
        groupSortBy: S2GroupSort.byCountInDesc(),
        groupBuilder: (context, state, group) {
          return StickyHeader(
            header: state.groupHeader(group),
            content: state.groupChoices(group),
          );
        },
        groupHeaderBuilder: (context, state, group) {
          return Container(
            color: widget.primaryColor,
            padding: const EdgeInsets.all(15),
            alignment: Alignment.centerLeft,
            child: S2Text(
              text: group.name,
              highlight: state.filter?.value,
              highlightColor: Colors.teal,
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
        tileBuilder: (context, state) {
          return S2Tile.fromState(
            state,
            isTwoLine: true,
          );
        });
  }
}
