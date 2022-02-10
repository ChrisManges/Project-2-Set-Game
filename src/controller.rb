require_relative 'model'
require_relative 'view'
require_relative 'player'

class Game
    attr_accessor :model, :deck, :board, :view, :continue_playing, :answer, :answer_format, :input, :players, :turn_tracker

    # initializes the game
    def initialize()
        @model = Model.new()
        @model.fill_deck()
        @model.fill_board()
        @view = View.new()
        @view.clear_screen()
        @answer = Array.new()
        @deck = @model.deck
        @board = @model.board
        @continue_playing = true
        @answer_format = false
        @players = Array.new()
        @turn_tracker = 0
    end

    # sets up the players, and then cycles between them choosing sets until the game is over
    def play()
        @view.get_player_name(1)
        @players.push(Player.new(gets))
        @view.get_player_name(2)
        @players.push(Player.new(gets))

        while true do
            @view.updateBoard(@board, @players)
            @view.player_input(@players[turn_tracker])
            get_ans()

            if matching_set?()
                @players[turn_tracker].turn_end()
                change_turn()
                @view.matching_set()
                replace_set()
            else
                @view.bad_set()
                @players[turn_tracker].penalty()
            end
            if continue?()
                @view.winner(players)
                exit
            end
        end
    end

    private

    # gets the current player's response for a set, quits if they respond with 'quit'
    def get_ans()
        while !@answer_format do
            @players[turn_tracker].turn_start()
            @input = gets
            parse_ans()

            if quit?()
                @view.quit_game()
                exit
            end
        end
        @answer_format = false
    end

    # parses their answer and verifies that it's acceptable
    def parse_ans()
        answer_sequence = @input.match(/^\d\/\d\/\d$/)
        answer_bounds = true
        answer_no_rep = true
        answer_not_nill = true
        
        @answer = @input.scan(/\d+/).map(&:to_i)

        answer_quantity = @answer.length == 3

        if answer_quantity
            @answer.each do |current_number|
                answer_bounds = current_number >= 1 || current_number <= 12
                break if !answer_bounds
                answer_not_nill = @board[current_number-1] != nil
                break if !answer_not_nill
            end
            answer_no_rep = @answer[0] != @answer[1] &&  @answer[1] != @answer[2] && @answer[0] != @answer[2]
        end

        @answer_format = answer_sequence && answer_quantity && answer_bounds && answer_no_rep && answer_not_nill
        
        if !@answer_format && !quit?()
            @view.incorrect_input()
        end
    end

    # checks if the current player's answer forms a set
    def matching_set?()
        quantity_match = all_same?('quantity') || all_diff?('quantity')
        shape_match = all_same?('shape') || all_diff?('shape')
        shading_match = all_same?('shading') || all_diff?('shading')
        color_match = all_same?('color') || all_diff?('color')

        quantity_match && shape_match && shading_match && color_match
    end

    # checks if the player's selected card's selected descriptor are all the same
    def all_same?(card_quality)
        card1 = @board[answer[0]-1]
        card2 = @board[answer[1]-1]
        card3 = @board[answer[2]-1]

        case card_quality
        when 'quantity'
            card1.quantity == card2.quantity && card2.quantity == card3.quantity
        when 'shape'
            card1.shape == card2.shape && card2.shape == card3.shape
        when 'shading'
            card1.shading == card2.shading && card2.shading == card3.shading
        when 'color'
            card1.color == card2.color && card2.color == card3.color
        else
            puts 'Incorrect card quality.'
        end
    end

    # checks if the player's selected card's selected descriptor are all unique
    def all_diff?(card_quality)
        card1 = @board[answer[0]-1]
        card2 = @board[answer[1]-1]
        card3 = @board[answer[2]-1]

        case card_quality
        when 'quantity'
            card1.quantity != card2.quantity && card2.quantity != card3.quantity && card1.quantity != card3.quantity
        when 'shape'
            card1.quantity != card2.quantity && card2.quantity != card3.quantity && card1.quantity != card3.quantity
        when 'shading'
            card1.shading != card2.shading && card2.shading != card3.shading && card1.shading != card3.shading
        when 'color'
            card1.color != card2.color && card2.color != card3.color && card1.color != card3.color
        else
            puts 'Incorrect card quality.'
        end
    end

    # removes the selected cards from the board and replaces them from the deck, if it is not empty
    def replace_set
        @answer.each do |current_set|
            @board[current_set-1] = nil
        end

        @model.fill_board()
    end

    # cycles between who the active player is
    def change_turn
        if @turn_tracker == 0
            @turn_tracker = 1
        else
            @turn_tracker = 0
        end
    end

    # returns true if each board slot is empty
    def continue?()
        @board.each do |board_slot|
            break if board_slot != nil
        end
    end

    # returns true if the user's input is 'quit'
    def quit?()
        @input.chomp.to_s == 'quit'
    end
end