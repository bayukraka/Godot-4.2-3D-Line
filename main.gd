@tool
extends Node3D

@export var generate : bool = false : set = start_generate
@export var line_from : Vector3 = Vector3(0,0,0) : set = set_line_from
@export var line_to : Vector3 = Vector3(1,1,1) : set = set_line_to

var material : Material
var mesh : ImmediateMesh
var meshInstance : MeshInstance3D

func start_generate(_val:bool)->void:
	if Engine.is_editor_hint():
		start()

func set_line_from(_val:Vector3):
	line_from = _val

func set_line_to(_val:Vector3):
	line_to = _val

func start():
	var n = get_children()
	for i in n:
		i.queue_free()
	
	mesh = ImmediateMesh.new()
	
	material = StandardMaterial3D.new()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.no_depth_test = true
	material.vertex_color_use_as_albedo = true
	material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	material.cull_mode = BaseMaterial3D.CULL_DISABLED
	
	meshInstance = MeshInstance3D.new()
	meshInstance.mesh = mesh
	meshInstance.material_override = material
	
	add_child(meshInstance)
	#draw_line(Vector3(0,0,0), Vector3(5,5,5), Color.AZURE)
	draw_line(line_from, line_to, Color.WHITE)
	
func draw_line(from: Vector3, to: Vector3, color: Color):
	mesh.surface_begin(Mesh.PRIMITIVE_LINES)
	mesh.surface_set_color(color)
	mesh.surface_add_vertex(from)
	mesh.surface_add_vertex(to)
	mesh.surface_end()
