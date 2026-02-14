extends Control

var body_male = preload("res://char_a_p1/1out/char_a_p1_1out_boxr_v01.png")
var body_female = preload("res://char_a_p1/1out/char_a_p1_1out_undi_v01.png")

func _ready():
	var picker = $VBoxContainer/HairStyleArrows/HairColorPicker.get_picker()
	 #size
	
	#Optional swatch
	#picker.set_presets([
		#Color(1,0,0), #Red
	#]



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

		#whats the players sex?
func _on_FemaleButton_pressed():
	$CharacterPreview/ClothesSprite.texture = body_female


func _on_MaleButton_pressed():
	$CharacterPreview/ClothesSprite.texture = body_male



	#Hair HAIR HARRRIIIIIRRRR
var hair_styles = [preload("res://char_a_p1/char_a_p1_4har_bob1_v01.png"), preload("res://char_a_p1/4har/char_a_p1_4har_dap1_v01.png")]
var hair_index = 0

func update_hair():
	$CharacterPreview/HairSprite.texture = hair_styles[hair_index]

func _on_HairLeftButton_pressed():
	hair_index = (hair_index - 1) % hair_styles.size()
	update_hair() 

func _on_HairRightButton_pressed():
	hair_index = (hair_index + 1) % hair_styles.size()
	update_hair()


		#Clothes
var clothes_styles = [preload("res://char_a_p1/1out/char_a_p1_1out_fstr_v04.png"), preload("res://char_a_p1/1out/char_a_p1_1out_pfpn_v04.png")]
var clothes_index = 0

func update_clothes():
	$CharacterPreview/ClothesSprite.texture = clothes_styles[clothes_index]
	
func _on_ClothesLeftButton_pressed() -> void:
	clothes_index = (clothes_index - 1) % clothes_styles.size()
	update_clothes()
	


func _on_ClothesRightButton_pressed() -> void:
	clothes_index = (clothes_index + 1) % clothes_styles.size()
	update_clothes()


func _onHairColorPicker_color_changed(color: Color) -> void:
	$CharacterPreview/HairSprite.modulate = color
