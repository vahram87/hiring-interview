class TransactionsController < ApplicationController

  def index
    @transactions = Transaction.page(params[:page])
  end

  def show
    @transaction = Transaction.find_by_id(params[:id])
    return if @transaction

    redirect_to transactions_path
  end

  def new
    @transaction = Transaction.new

    render "new_#{params[:type]}"
  end

  def create
    @transaction = Transaction.new(transaction_params)

    @transaction.manager = Manager.order('RANDOM()').limit(1).last if @transaction.extra_large?

    if @transaction.save
      redirect_to @transaction
    else
      render "new_#{params[:type]}"
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(
      :first_name,
      :last_name,
      :from_amount,
      :from_currency,
      :to_currency
    )
  end

end
