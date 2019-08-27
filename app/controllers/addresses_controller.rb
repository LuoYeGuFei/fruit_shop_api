class AddressesController < ApplicationController

  before_action :set_customer
  before_action :set_customer_address, only: [:show, :update, :destroy]

  def index
    json_response(@customer.addresses)
  end

  def show
    json_response(@address)
  end

  def create
    @customer.addresses.create!(address_params)
    json_response(@customer, :created)
  end

  def update
    @address.update(address_params)
    head :no_content
  end

  def destroy
    @address.destroy
    head :no_content
  end

  private

  def address_params
    params.permit(:receiver, :tel, :addr)
  end

  def set_customer
    @customer = Customer.find(params[:customer_id])
  end

  def set_customer_address
    @address = @customer.addresses.find_by!(id: params[:id]) if @customer
  end

end
