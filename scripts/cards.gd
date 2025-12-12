extends Node

enum STATUS {
	ROOM,
	WEAPON,
	DEFEATED_MONSTER,
}

enum Suit {
	HEARTS,
	DIAMONDS,
	SPADES,
	CLUBS,
}

enum Rank {
	TWO,
	THREE,
	FOUR,
	FIVE,
	SIX,
	SEVEN,
	EIGHT,
	NINE,
	TEN,
	JACK,
	QUEEN,
	KING,
	ACE,
}


func suit_to_string(suit: Suit) -> String:
	match suit:
		Suit.HEARTS:
			return "Hearts"
		Suit.DIAMONDS:
			return "Diamonds"
		Suit.SPADES:
			return "Spades"
		Suit.CLUBS:
			return "Clubs"
		_:
			return "Unknown Suit"


func rank_to_string(rank: Rank) -> String:
	match rank:
		Rank.TWO:
			return "2"
		Rank.THREE:
			return "3"
		Rank.FOUR:
			return "4"
		Rank.FIVE:
			return "5"
		Rank.SIX:
			return "6"
		Rank.SEVEN:
			return "7"
		Rank.EIGHT:
			return "8"
		Rank.NINE:
			return "9"
		Rank.TEN:
			return "10"
		Rank.JACK:
			return "Jack"
		Rank.QUEEN:
			return "Queen"
		Rank.KING:
			return "King"
		Rank.ACE:
			return "Ace"
		_:
			return "Unknown Rank"


func is_weapon(card: Card):
	return card.suit == Suit.DIAMONDS


func is_monster(card: Card):
	return card.suit == Suit.SPADES or card.suit == Suit.CLUBS


class Card:
	var suit: Suit = Suit.HEARTS
	var rank: Rank = Rank.ACE


	func _init(_suit: Suit, _rank: Rank) -> void:
		self.suit = _suit
		self.rank = _rank


	func _to_string() -> String:
		return "Card<%s,%s>" % [Cards.suit_to_string(suit), Cards.rank_to_string(rank)]
