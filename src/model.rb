require_relative 'card'

class Model
    attr_accessor :deck, :board

    # initializes the deck and board for the model object
    def initialize()
        @deck = Array.new(81)
        @board = Array.new(12)
    end

    # generates unique cards to fill the deck and then randomizes it
    def fill_deck()
        current_card = Card.new()
        prev_card = Card.new()
        
        @deck.map! do |current_card|
            current_card = Card.new()
            current_card.copy_card(prev_card)
            current_card.next_card(prev_card)
            prev_card = current_card
        end

        @deck.shuffle!
    end

    # removes cards from the deck to fill the board, assuming the deck is not empty and there is an empty slot on the board
    def fill_board()
        @board.map! do |current_card|
            if current_card == nil && @deck.size > 0
                @deck.shift()
            else
                current_card
            end
        end
    end
end