extends Node


signal log_statement_made(source, message)

func log(source, message):
    emit_signal("log_statement_made", source, message)
