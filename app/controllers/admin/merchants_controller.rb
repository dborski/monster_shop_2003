class Admin::MerchantsController < Admin::BaseController

  def show
    @merchant = Merchant.find(params[:id])
  end

  def index
    @merchants = Merchant.all
  end

  def update
    merchant = Merchant.find(params[:id])
    case params[:edit]
    when "active_false"
      merchant.update(active?: false)
      deactivate_items(merchant)
      flash[:notice] = "Merchant #{merchant.id} has been disabled"
    when "active_true"
      merchant.update(active?: true)
      activate_items(merchant)
      flash[:notice] = "Merchant #{merchant.id} has been enabled"
    end
  
    redirect_to admin_merchants_path
  end

  private 

  def deactivate_items(merchant)
    merchant.items.each do |item|
      item.update(active?: false)
    end
  end
  def activate_items(merchant)
    merchant.items.each do |item|
      item.update(active?: true)
    end
  end

  
  
  
  
end