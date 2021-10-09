module ShoppingCart
  module LineItem
    class UpdateBargainsActivity
      class << self
        prepend ShoppingCartUpdatable

        def call(cart:, line_item:, previous_quantity:)
          new(line_item: line_item, previous_quantity: previous_quantity).call
        end
      end
      
      attr_accessor :line_item, :previous_quantity
    
      def initialize(line_item:, previous_quantity:)
        @previous_quantity = previous_quantity
        @line_item = line_item
      end
    
      def call
        offers.each do |offer|
          offer.offerable.send(action, **offer_params)
        end
        line_item.reload
      end

      private
      def offers
        line_item.product.offers
      end

      def action
        raise ArgumentError if line_item.quantity == previous_quantity
        action ||= case
        when line_item.quantity > previous_quantity
          :apply
        when line_item.quantity < previous_quantity
          :remove
        end
      end

      def offer_params
        {
          line_item: line_item,
          previous_quantity: previous_quantity
        }
      end
    end  
  end
end
