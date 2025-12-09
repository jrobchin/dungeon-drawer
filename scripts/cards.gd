extends Node

enum Suit {
	HEARTS,
	DIAMONDS,
	SPADES,
	CLUBS
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

class Card:
	var suit: Suit = Suit.HEARTS
	var rank: Rank = Rank.ACE
	
	func _init(_suit: Suit, _rank: Rank) -> void:
		self.suit = _suit
		self.rank = _rank
