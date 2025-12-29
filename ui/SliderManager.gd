extends VBoxContainer

func _ready():
	$Separation/Value.text = str($SepSlide.value)
	$Alignement/Value.text = str($AliSlide.value)
	$Cohesion/Value.text = str($CohSlide.value)
	$Mouse/Value.text = str($MouseSlide.value)
	$Wall/Value.text = str($WallSlide.value)

func _on_sep_slide_value_changed(value):
	$Separation/Value.text = str($SepSlide.value)
	Globals.sep_weight = $SepSlide.value

func _on_ali_slide_value_changed(value):
	$Alignement/Value.text = str($AliSlide.value)
	Globals.ali_weight = $AliSlide.value

func _on_coh_slide_value_changed(value):
	$Cohesion/Value.text = str($CohSlide.value)
	Globals.coh_weight = $CohSlide.value

func _on_mouse_slide_value_changed(value):
	$Mouse/Value.text = str($MouseSlide.value)
	Globals.mouse_weight = $MouseSlide.value

func _on_wall_slide_value_changed(value):
	$Wall/Value.text = str($WallSlide.value)
	Globals.avoid_weight = $WallSlide.value
