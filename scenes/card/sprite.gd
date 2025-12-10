@tool
extends Sprite2D

const suit_to_frame_coord_y = {
	Cards.Suit.HEARTS: 0,
	Cards.Suit.DIAMONDS: 1,
	Cards.Suit.SPADES: 2,
	Cards.Suit.CLUBS: 3,
}

const rank_to_frame_coord_x = {
	Cards.Rank.ACE: 0,
	Cards.Rank.TWO: 1,
	Cards.Rank.THREE: 2,
	Cards.Rank.FOUR: 3,
	Cards.Rank.FIVE: 4,
	Cards.Rank.SIX: 5,
	Cards.Rank.SEVEN: 6,
	Cards.Rank.EIGHT: 7,
	Cards.Rank.NINE: 8,
	Cards.Rank.TEN: 9,
	Cards.Rank.JACK: 10,
	Cards.Rank.QUEEN: 11,
	Cards.Rank.KING: 12,
}


func update_sprite(rank: Cards.Rank, suit: Cards.Suit) -> void:
	frame_coords = Vector2(rank_to_frame_coord_x[rank], suit_to_frame_coord_y[suit])


func _on_draggable_area_on_drag_start() -> void:
	pass # Replace with function body.
