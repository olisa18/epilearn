import 'package:flutter/material.dart';

class CharacterFilterBar extends StatefulWidget {
  final ValueChanged<String> onNameChanged;
  final ValueChanged<String?> onStatusChanged;
  final ValueChanged<String?> onSpeciesChanged;
  final VoidCallback onClearFilters; // new callback
  final List<String> speciesList;
  final String? selectedStatus;
  final String? selectedSpecies;
  final String selectedName;

  const CharacterFilterBar({
    super.key,
    required this.onNameChanged,
    required this.onStatusChanged,
    required this.onSpeciesChanged,
    required this.onClearFilters, // required
    required this.speciesList,
    this.selectedStatus,
    this.selectedSpecies,
    required this.selectedName,
  });

  @override
  State<CharacterFilterBar> createState() => _CharacterFilterBarState();
}

class _CharacterFilterBarState extends State<CharacterFilterBar> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.selectedName);
  }

  @override
  void didUpdateWidget(covariant CharacterFilterBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selectedName != oldWidget.selectedName &&
        widget.selectedName != _nameController.text) {
      _nameController.text = widget.selectedName;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final speciesDropdownItems = <DropdownMenuItem<String>>[
      const DropdownMenuItem(value: '', child: Text('All')),
      ...widget.speciesList.map(
        (s) => DropdownMenuItem(
          value: s,
          child: Text(
            s,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ),
    ];

    final validSelectedSpecies =
        widget.speciesList.contains(widget.selectedSpecies)
            ? widget.selectedSpecies
            : '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _nameController,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: const InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.white70),
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70),
                  ),
                ),
                textInputAction: TextInputAction.done,
                onSubmitted: (value) {
                  widget.onNameChanged(value);
                },
              ),
            ),
            const SizedBox(width: 6),
            Flexible(
              flex: 0,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 110),
                child: DropdownButtonFormField<String>(
                  value: widget.selectedStatus?.isNotEmpty == true
                      ? widget.selectedStatus
                      : '',
                  onChanged: widget.onStatusChanged,
                  isExpanded: true,
                  dropdownColor: Colors.black87,
                  menuMaxHeight: 250,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  decoration: const InputDecoration(
                    labelText: 'Status',
                    labelStyle: TextStyle(color: Colors.white70),
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(value: '', child: Text('All')),
                    DropdownMenuItem(value: 'alive', child: Text('Alive')),
                    DropdownMenuItem(value: 'dead', child: Text('Dead')),
                    DropdownMenuItem(value: 'unknown', child: Text('Unknown')),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 6),
            Flexible(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 130),
                child: DropdownButtonFormField<String>(
                  value: validSelectedSpecies,
                  onChanged: widget.speciesList.isEmpty
                      ? null
                      : widget.onSpeciesChanged,
                  isExpanded: true,
                  dropdownColor: Colors.black87,
                  menuMaxHeight: 250,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  decoration: const InputDecoration(
                    labelText: 'Species',
                    labelStyle: TextStyle(color: Colors.white70),
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white30),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70),
                    ),
                  ),
                  items: speciesDropdownItems,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
