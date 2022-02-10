class View

    # displays the board of available cards and timer
    def updateBoard(board, players)
        clear_screen()
        puts '     color     shading   shape     quantity  cards left: ' + board.size.to_s

        board.each_with_index do |card_on_board, card_num|
            if card_on_board != nil
                current_card = (card_num+1).to_s.ljust(5, ' ')
                current_card += card_on_board.color.to_s.ljust(10, ' ')
                current_card += card_on_board.shading.to_s.ljust(10, ' ')
                current_card += card_on_board.shape.to_s.ljust(10, ' ')
                current_card += card_on_board.quantity.to_s
                puts current_card
            elsif card_on_board == nil
                puts
            end
        end
        puts
        display_timer(players)
    end

    # displays the option to form a set to the relevent player
    def player_input(player)
        print player.name + ', please select 3 cards to form a set (#/#/#): '
    end

    # displays the time of each player
    def display_timer(players)
        puts 'Time elapsed:   ' + players[0].name + ' - ' + players[0].turn_time.to_s + '       ' + players[1].name + ' - ' + players[1].turn_time.to_s
    end

    # displays that a set has been formed
    def matching_set()
        print 'You created a set.'
        gets
    end

    # displays that a set has not been formed plus a penalty
    def bad_set()
        print 'Your three cards do not form a true set. You have been penalized (Press enter to continue): '
        gets
    end

    # displays that the user submitted an improper set selection
    def incorrect_input()
        print 'Your response is in an incorrect format, please re-enter your response: '
    end

    # displays that the game has ended
    def quit_game()
        puts 'You have decided to end the game. Have a nice day.'
    end

    # displays the final score for each player and declares a winner (or a tie)
    def winner(players)
        system("clear")
        puts 'FINAL SCORE:  ' + players[0].name + ' - ' + players[0].turn_time.to_s + '       ' + players[1].name + ' - ' + players[1].turn_time.to_s
        winner = ' '
        if players[0].turn_time > players[1].turn_time
            winner += players[1].name + 'you are the winner!'
        elsif players[0].turn_time < players[1].turn_time
            winner += players[0].name + 'you are the winner!'
        else
            winner = ', it\'s a draw!'
        end
        puts 'Congrats' + winner
    end

    # displays a request for a player's name
    def get_player_name(player_num)
        print 'Please enter the name for player ' + player_num.to_s + ': '
    end

    # clears the screen
    def clear_screen()
        system("clear")
    end
end