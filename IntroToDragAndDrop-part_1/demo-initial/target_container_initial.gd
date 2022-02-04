extends Panel

func can_drop_data(position: Vector2, data) -> bool:
    var can_drop: bool = data is Node and data.is_in_group("DRAGGABLE")
    print("[TargetContainer] can_drop_data has run, returning %s" % can_drop)
    return can_drop

func drop_data(position: Vector2, data) -> void:
    print("[TargetContainer] drop_data has run")

