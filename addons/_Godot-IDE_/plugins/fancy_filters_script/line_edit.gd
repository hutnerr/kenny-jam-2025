@tool
extends LineEdit
# =============================================================================	
# Author: Twister
# Fancy Filter Script
#
# Addon for Godot
# =============================================================================	


@export var tree : Tree = null


func _enter_tree() -> void:
	if !is_in_group(&"UPDATE_ON_SAVE"):
		add_to_group(&"UPDATE_ON_SAVE")
	
func _exit_tree() -> void:
	if is_in_group(&"UPDATE_ON_SAVE"):
		remove_from_group(&"UPDATE_ON_SAVE")
	
func _process(delta: float) -> void:
	set_process(false)
	if text.is_empty():
		return
	sxrch.call_deferred(text)
	
func update() -> void:
	set_process(true)
		
func _ready() -> void:
	set_process(false)
	text_changed.connect(sxrch)

func reset() -> void:
	if tree:
		var root : TreeItem = tree.get_root()
		if !root:
			return
		_reset(root)
			
func _reset(root : TreeItem) -> void:
	root.visible = true
	for c : TreeItem in root.get_children():
		_reset(c)

func sxrch(txt : String) -> void:
	reset()
	if txt.is_empty():
		return
	if tree:
		var root : TreeItem = tree.get_root()
		if !root:
			return
		var rgx0 : RegEx = RegEx.create_from_string("(?i)\\b{0}\\b".format([txt]))
		var rgx1 : RegEx = RegEx.create_from_string("(?i).*{0}.*".format([txt]))
		var d0 : Array[TreeItem] = []
		var d1 : Array[TreeItem] = []
		_sxrch(root, rgx0, rgx1, d0, d1)
		root.visible = true
		
		for t : TreeItem in d0:
			_visible(t)
		for t : TreeItem in d1:
			_visible(t)
			
func _visible(root : TreeItem) -> void:
	if root:
		root.visible = true
		_visible(root.get_parent())
	
func _sxrch(root : TreeItem, rgx0 : RegEx, rgx1 : RegEx, d0 : Array[TreeItem], d1 : Array[TreeItem]) -> void:
	var txt : String = root.get_text(0)
	root.visible = false
	if rgx0.search(txt) != null:
		d0.append(root)
	elif d0.size() == 0 and rgx1.search(txt) != null:
		d1.append(root)
	for x : TreeItem in root.get_children():
		_sxrch(x, rgx0, rgx1, d0, d1)
