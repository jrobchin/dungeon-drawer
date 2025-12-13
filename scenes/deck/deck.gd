@tool
class_name Deck
extends Node2D

@export var animation_player: AnimationPlayer

const MAX_CARDS: int = 46

var card_scene: PackedScene = preload("res://scenes/card/card.tscn")

@onready var deck_card_sprite_0: Sprite2D = $DeckCardSprite0
@onready var deck_card_sprite_1: Sprite2D = $DeckCardSprite1
@onready var deck_card_sprite_2: Sprite2D = $DeckCardSprite2
@onready var deck_card_sprite_3: Sprite2D = $DeckCardSprite3
@onready var deck_card_sprite_4: Sprite2D = $DeckCardSprite4

var cards: Array[Cards.Card]
var hover: bool = false

signal deck_clicked
signal cards_changed(deck: Deck)


func _ready() -> void:
	_update_card_sprites_visibility()


func _on_clickable_area_clicked() -> void:
	Debug.print_info("Deck clicked")
	deck_clicked.emit()


func _on_clickable_area_mouse_entered() -> void:
	Debug.print_info("Mouse exited deck area")
	hover = true

	animation_player.play("show")


func _on_clickable_area_mouse_exited() -> void:
	Debug.print_info("Mouse exited deck area")
	hover = false

	animation_player.play("hide")


func _cards_changed() -> void:
	_update_card_sprites_visibility()
	cards_changed.emit(self)


func initialize(_cards: Array[Cards.Card] = []):
	cards = _cards
	_cards_changed()
	Debug.print_info("%s initialized with %d cards." % [self, cards.size()])


func shuffle_deck() -> void:
	cards.shuffle()
	_cards_changed()
	Debug.print_info("%s shuffled" % self)


## Draws a card from the deck. Instantiates the card node.
func draw_card() -> CardNode:
	if cards.size() == 0:
		Debug.print_info("No more cards in the deck: %s to draw, returning null." % self)
		return null

	var drawn_card: Cards.Card = cards.pop_back()
	Debug.print_info(
		"Drew card from %s: %s of %s" % [
			self,
			Cards.rank_to_string(drawn_card.rank),
			Cards.suit_to_string(drawn_card.suit),
		],
	)

	var card_node = card_scene.instantiate() as CardNode
	card_node.name = str(drawn_card)
	card_node.card = drawn_card

	_cards_changed()

	return card_node


## Adds card to deck. Since decks do not need nodes, cards added to the deck are freed.
func add_card(card_node: CardNode) -> void:
	cards.append(card_node.card)
	Debug.print_info("Added card %s: %s" % [self, card_node.card])

	var tween := create_tween()

	var target_position := global_position

	tween.tween_property(
		card_node,
		"global_position",
		target_position,
		0.25,
	).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN)

	await tween.finished

	card_node.queue_free()

	_cards_changed()


func _update_card_sprites_visibility() -> void:
	var card_sprites = [deck_card_sprite_0, deck_card_sprite_1, deck_card_sprite_2, deck_card_sprite_3, deck_card_sprite_4]

	if cards.size() == 0:
		for i in range(card_sprites.size() - 1, -1, -1):
			card_sprites[i].visible = false
	else:
		var cards_remaining_percentage = float(cards.size()) / MAX_CARDS + 0.2

		for i in range(card_sprites.size() - 1, -1, -1):
			var threshold = float(i + 1) / card_sprites.size()
			card_sprites[i].visible = cards_remaining_percentage > threshold
