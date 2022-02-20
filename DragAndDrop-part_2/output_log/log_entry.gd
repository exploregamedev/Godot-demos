extends PanelContainer
class_name LogEntry

onready var _entry_text_node: Label = $Padding/VLayout/EntryText
onready var _entry_source_node: Label = $Padding/VLayout/HBoxContainer/EntrySource
onready var _entry_count: Label = $Padding/VLayout/HBoxContainer/EntryOccurenceCount
var _message_count: int = 1


func set_entry(source: String, text: String) -> void:
    _entry_text_node.text = text
    _entry_source_node.text = source


func get_text() -> String:
    return _entry_text_node.text


func get_source() -> String:
    return _entry_source_node.text

func update_message_count() -> void:
    _message_count += 1
    _entry_count.text = "(%s)" % _message_count

