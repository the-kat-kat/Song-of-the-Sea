extends TextureRect

@export var subviewport_path: NodePath
@export var subv: SubViewport

var _last_view_size: Vector2i = Vector2i.ZERO

func _ready() -> void:
	print("ready — engine:", Engine.get_version_info())
	print("OS:", OS.get_name())

	set_anchors_preset(Control.PRESET_FULL_RECT)
	stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED

	# resolve SubViewport if you set the path in inspector
	if subviewport_path != NodePath():
		var n := get_node_or_null(subviewport_path)
		if n:
			subv = n as SubViewport
			print("resolved subv from path:", subviewport_path)
		else:
			push_warning("subviewport_path set but node not found")

	if is_instance_valid(subv):
		print("subv is valid:", subv.get_class())
	else:
		push_warning("subv is not assigned")

	_sync_size_once()

func _process(_delta: float) -> void:
	var vsf := get_viewport().get_visible_rect().size
	var vsi := Vector2i(vsf)
	if vsi != _last_view_size:
		_last_view_size = vsi
		_sync_size_once()

func _sync_size_once() -> void:
	var vsf := get_viewport().get_visible_rect().size
	var vsi := Vector2i(vsf)

	position = Vector2i.ZERO
	size = vsi
	print("resized TextureRect to", vsi)

	if not is_instance_valid(subv):
		return

	# update SubViewport size
	subv.size = vsi

	# only assign texture if SubViewport is ready
	if subv.is_inside_tree():
		var tex := subv.get_texture()
		if tex:
			texture = tex
			print("assigned SubViewport texture")
		else:
			push_warning("subv.get_texture() returned null")
