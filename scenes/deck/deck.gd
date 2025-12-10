@tool
class_name Deck
extends Node2D

@export var animation_player: AnimationPlayer

const MAX_CARDS: int = 46

@onready var deck_card_sprite_0: Sprite2D = $DeckCardSprite0
@onready var deck_card_sprite_1: Sprite2D = $DeckCardSprite1
@onready var deck_card_sprite_2: Sprite2D = $DeckCardSprite2
@onready var deck_card_sprite_3: Sprite2D = $DeckCardSprite3
@onready var deck_card_sprite_4: Sprite2D = $DeckCardSprite4

var cards: Array = _initial_cards()
var hover: bool = false

signal deck_clicked


func _on_clickable_area_clicked() -> void:
	Debug.print_info("Deck clicked")
	emit_signal("deck_clicked")


func _on_clickable_area_mouse_entered() -> void:
	Debug.print_info("Mouse exited deck area")
	hover = true

	animation_player.play("show")


func _on_clickable_area_mouse_exited() -> void:
	Debug.print_info("Mouse exited deck area")
	hover = false

	animation_player.play("hide")


func _on_debug_gui_shuffle_deck() -> void:
	shuffle_deck()


func _initial_cards() -> Array:
	return [
		Cards.Card.new(Cards.Suit.HEARTS, Cards.Rank.ACE),
		Cards.Card.new(Cards.Suit.HEARTS, Cards.Rank.TWO),
		Cards.Card.new(Cards.Suit.HEARTS, Cards.Rank.THREE),
		Cards.Card.new(Cards.Suit.HEARTS, Cards.Rank.FOUR),
		Cards.Card.new(Cards.Suit.HEARTS, Cards.Rank.FIVE),
		Cards.Card.new(Cards.Suit.HEARTS, Cards.Rank.SIX),
		Cards.Card.new(Cards.Suit.HEARTS, Cards.Rank.SEVEN),
		Cards.Card.new(Cards.Suit.HEARTS, Cards.Rank.EIGHT),
		Cards.Card.new(Cards.Suit.HEARTS, Cards.Rank.NINE),
		Cards.Card.new(Cards.Suit.HEARTS, Cards.Rank.TEN),
		Cards.Card.new(Cards.Suit.DIAMONDS, Cards.Rank.ACE),
		Cards.Card.new(Cards.Suit.DIAMONDS, Cards.Rank.TWO),
		Cards.Card.new(Cards.Suit.DIAMONDS, Cards.Rank.THREE),
		Cards.Card.new(Cards.Suit.DIAMONDS, Cards.Rank.FOUR),
		Cards.Card.new(Cards.Suit.DIAMONDS, Cards.Rank.FIVE),
		Cards.Card.new(Cards.Suit.DIAMONDS, Cards.Rank.SIX),
		Cards.Card.new(Cards.Suit.DIAMONDS, Cards.Rank.SEVEN),
		Cards.Card.new(Cards.Suit.DIAMONDS, Cards.Rank.EIGHT),
		Cards.Card.new(Cards.Suit.DIAMONDS, Cards.Rank.NINE),
		Cards.Card.new(Cards.Suit.DIAMONDS, Cards.Rank.TEN),
		Cards.Card.new(Cards.Suit.SPADES, Cards.Rank.ACE),
		Cards.Card.new(Cards.Suit.SPADES, Cards.Rank.TWO),
		Cards.Card.new(Cards.Suit.SPADES, Cards.Rank.THREE),
		Cards.Card.new(Cards.Suit.SPADES, Cards.Rank.FOUR),
		Cards.Card.new(Cards.Suit.SPADES, Cards.Rank.FIVE),
		Cards.Card.new(Cards.Suit.SPADES, Cards.Rank.SIX),
		Cards.Card.new(Cards.Suit.SPADES, Cards.Rank.SEVEN),
		Cards.Card.new(Cards.Suit.SPADES, Cards.Rank.EIGHT),
		Cards.Card.new(Cards.Suit.SPADES, Cards.Rank.NINE),
		Cards.Card.new(Cards.Suit.SPADES, Cards.Rank.TEN),
		Cards.Card.new(Cards.Suit.SPADES, Cards.Rank.JACK),
		Cards.Card.new(Cards.Suit.SPADES, Cards.Rank.QUEEN),
		Cards.Card.new(Cards.Suit.SPADES, Cards.Rank.KING),
		Cards.Card.new(Cards.Suit.CLUBS, Cards.Rank.ACE),
		Cards.Card.new(Cards.Suit.CLUBS, Cards.Rank.TWO),
		Cards.Card.new(Cards.Suit.CLUBS, Cards.Rank.THREE),
		Cards.Card.new(Cards.Suit.CLUBS, Cards.Rank.FOUR),
		Cards.Card.new(Cards.Suit.CLUBS, Cards.Rank.FIVE),
		Cards.Card.new(Cards.Suit.CLUBS, Cards.Rank.SIX),
		Cards.Card.new(Cards.Suit.CLUBS, Cards.Rank.SEVEN),
		Cards.Card.new(Cards.Suit.CLUBS, Cards.Rank.EIGHT),
		Cards.Card.new(Cards.Suit.CLUBS, Cards.Rank.NINE),
		Cards.Card.new(Cards.Suit.CLUBS, Cards.Rank.TEN),
		Cards.Card.new(Cards.Suit.CLUBS, Cards.Rank.JACK),
		Cards.Card.new(Cards.Suit.CLUBS, Cards.Rank.QUEEN),
		Cards.Card.new(Cards.Suit.CLUBS, Cards.Rank.KING),
	]


func initialize():
	cards = _initial_cards()
	_update_card_sprites_visibility()
	Debug.print_info("Deck initialized with %d cards." % cards.size())


func shuffle_deck() -> void:
	cards.shuffle()
	Debug.print_info("Deck shuffled")


func draw_card() -> Cards.Card:
	if cards.size() == 0:
		Debug.print_info("No more cards in the deck to draw, returning null.")
		return null

	var drawn_card: Cards.Card = cards.pop_back()
	_update_card_sprites_visibility()
	Debug.print_info("Drew card: %s of %s" % [Cards.Rank.keys()[drawn_card.rank], Cards.Suit.keys()[drawn_card.suit]])

	return drawn_card


func _update_card_sprites_visibility() -> void:
	var card_sprites = [deck_card_sprite_0, deck_card_sprite_1, deck_card_sprite_2, deck_card_sprite_3, deck_card_sprite_4]
	var cards_remaining_percentage = float(cards.size()) / MAX_CARDS

	for i in range(card_sprites.size() - 1, -1, -1):
		var threshold = float(i + 1) / card_sprites.size()
		card_sprites[i].visible = cards_remaining_percentage > threshold
