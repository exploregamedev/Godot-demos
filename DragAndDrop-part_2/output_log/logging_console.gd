extends Control
class_name LoggingConsole

var _max_scroll_lenght: int
var _previous_entry: LogEntry
var _marker_count: int
const OutputEntry: PackedScene = preload("res://output_log/log_entry.tscn")


onready var _history: VBoxContainer = $Container/Padding/VLayout/Scroll/OutputHistory
onready var _scroll: ScrollContainer = $Container/Padding/VLayout/Scroll
onready var _v_scroll_bar: VScrollBar = _scroll.get_v_scrollbar()


func _ready() -> void:
    ConsoleLogger.connect("log_statement_made", self, "_add_entry")
    _v_scroll_bar.connect("changed", self, "_on_v_scroll_changed")
    _max_scroll_lenght = _v_scroll_bar.max_value

func _input(event: InputEvent) -> void:
    if Input.is_action_just_pressed("console_marker"):
        if _previous_entry.get_source().begins_with("-- MARKER"):
            return
        _add_entry("-- MARKER #%s --" % _marker_count, "")
        _marker_count += 1

func _add_entry(source: String, message: String):
    if _previous_entry and message == _previous_entry.get_text():
        _previous_entry.update_message_count()
        return
    var entry = OutputEntry.instance()
    _history.add_child(entry)
    entry.set_entry(source, message)
    _previous_entry = entry


func _on_v_scroll_changed():
    if _scroll_length_has_changed():
        _max_scroll_lenght = _v_scroll_bar.max_value
        _scroll.scroll_vertical = _v_scroll_bar.max_value


func _scroll_length_has_changed() -> bool:
    return _max_scroll_lenght != _v_scroll_bar.max_value
