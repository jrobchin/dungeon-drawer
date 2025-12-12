class_name StateInitializer
extends Node

@export var draw_deck: Deck
@export var discard_deck: Deck
@export var room: Room
@export var state_manager: StateManager
@export var card_tree: CardTree
@export var game_state_machine: StateMachine
@export var weapon_card_drop: CardDrop
@export var hand_card_drop: CardDrop


func _initial_cards() -> Array[Cards.Card]:
	return [
		# Cards.Card.new(Cards.Suit.HEARTS, Cards.Rank.TWO),
		# Cards.Card.new(Cards.Suit.HEARTS, Cards.Rank.THREE),
		# Cards.Card.new(Cards.Suit.HEARTS, Cards.Rank.FOUR),
		# Cards.Card.new(Cards.Suit.HEARTS, Cards.Rank.FIVE),
		# Cards.Card.new(Cards.Suit.HEARTS, Cards.Rank.SIX),
		# Cards.Card.new(Cards.Suit.HEARTS, Cards.Rank.SEVEN),
		# Cards.Card.new(Cards.Suit.HEARTS, Cards.Rank.EIGHT),
		# Cards.Card.new(Cards.Suit.HEARTS, Cards.Rank.NINE),
		# Cards.Card.new(Cards.Suit.HEARTS, Cards.Rank.TEN),
		Cards.Card.new(Cards.Suit.DIAMONDS, Cards.Rank.TWO),
		# Cards.Card.new(Cards.Suit.DIAMONDS, Cards.Rank.THREE),
		# Cards.Card.new(Cards.Suit.DIAMONDS, Cards.Rank.FOUR),
		# Cards.Card.new(Cards.Suit.DIAMONDS, Cards.Rank.FIVE),
		# Cards.Card.new(Cards.Suit.DIAMONDS, Cards.Rank.SIX),
		# Cards.Card.new(Cards.Suit.DIAMONDS, Cards.Rank.SEVEN),
		# Cards.Card.new(Cards.Suit.DIAMONDS, Cards.Rank.EIGHT),
		# Cards.Card.new(Cards.Suit.DIAMONDS, Cards.Rank.NINE),
		# Cards.Card.new(Cards.Suit.DIAMONDS, Cards.Rank.TEN),
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
		# Cards.Card.new(Cards.Suit.CLUBS, Cards.Rank.ACE),
		# Cards.Card.new(Cards.Suit.CLUBS, Cards.Rank.TWO),
		# Cards.Card.new(Cards.Suit.CLUBS, Cards.Rank.THREE),
		# Cards.Card.new(Cards.Suit.CLUBS, Cards.Rank.FOUR),
		# Cards.Card.new(Cards.Suit.CLUBS, Cards.Rank.FIVE),
		# Cards.Card.new(Cards.Suit.CLUBS, Cards.Rank.SIX),
		# Cards.Card.new(Cards.Suit.CLUBS, Cards.Rank.SEVEN),
		# Cards.Card.new(Cards.Suit.CLUBS, Cards.Rank.EIGHT),
		# Cards.Card.new(Cards.Suit.CLUBS, Cards.Rank.NINE),
		# Cards.Card.new(Cards.Suit.CLUBS, Cards.Rank.TEN),
		# Cards.Card.new(Cards.Suit.CLUBS, Cards.Rank.JACK),
		# Cards.Card.new(Cards.Suit.CLUBS, Cards.Rank.QUEEN),
		# Cards.Card.new(Cards.Suit.CLUBS, Cards.Rank.KING),

		# TODO: BELOW THIS LINE IS CUSTOM REMOVE LATER
		Cards.Card.new(Cards.Suit.DIAMONDS, Cards.Rank.TWO),
	]


func initialize_game_state() -> void:
	draw_deck.initialize(_initial_cards())
	# draw_deck.shuffle_deck()

	discard_deck.initialize()

	room.initialize()
	weapon_card_drop.initialize()
	hand_card_drop.initialize()

	card_tree.initialize()

	state_manager.initialize()
