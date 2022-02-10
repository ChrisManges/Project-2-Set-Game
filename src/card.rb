class Card
    attr_accessor :quantity, :shape, :shading, :color

    # initializes the card object
    def initialize()
        @quantity = nil
        @shape = nil
        @shading = nil
        @color = nil
    end

    # copies the attributes of the selected card
    def copy_card(prev_card)
        @quantity = prev_card.quantity
        @shape = prev_card.shape
        @shading = prev_card.shading
        @color = prev_card.color
    end

    # generates the next card in the sequence (4 digit base 3)
    def next_card(prevCard)
        if prevCard == nil
            @quantity = 1
            @shape = 'diamond'
            @shading = 'solid'
            @color = 'red'
        else
            self.next_quantity()
        end

    end

    private

    # cycles between 1-3 for the quantity attribute of the card. Increments the shape if it resets
    def next_quantity()
        case @quantity
        when 1
            @quantity = 2
        when 2
            @quantity = 3
        else
            @quantity = 1
            self.next_shape()
        end
    end

    # cycles between diamond, squiggle, and oval for the shape attribute of the card. Increments the shading if it resets
    def next_shape()
        case @shape
        when 'diamond'
            @shape = 'squiggle'
        when 'squiggle'
            @shape = 'oval'
        else
            @shape = 'diamond'
            self.next_shading()
        end
    end

    # cycles between solid, striped, and open for the shading attribute of the card. Increments the color if it resets
    def next_shading()
        case @shading
        when 'solid'
            @shading = 'striped'
        when 'striped'
            @shading = 'open'
        else
            @shading = 'solid'
            self.next_color()
        end
    end

    # cycles between red, green, and purple for the color attribute of the card.
    def next_color()
        case @color
        when 'red'
            @color = 'green'
        when 'green'
            @color = 'purple'
        else
            @color = 'red'
        end
    end
end