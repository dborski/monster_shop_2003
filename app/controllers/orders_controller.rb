class OrdersController < BaseController
  before_action :require_regular, except: [:new, :create]

  def index
    @orders = Order.all
  end
  

  def new

  end

  def show
    @order = Order.find(params[:id])
  end

  def create

    order = Order.create(order_params)
    if order.save
      cart.items.each do |item,quantity|
        order.item_orders.create({
          item: item,
          quantity: quantity,
          price: item.price
          })
      end
      session.delete(:cart)
      redirect_to "/orders/#{order.id}"
    else
      flash[:notice] = "Please complete address form to create an order."
      render :new
    end
  end


  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip, :user_id)
  end
end
