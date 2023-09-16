class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[show edit update destroy]
  before_action :set_category

  # GET /expenses or /expenses.json
  def index
    @category = Category.find(params[:category_id])
    @expenses = @category.expenses.where(user_id: current_user.id).order('created_at DESC')
  end

  # GET /expenses/1 or /expenses/1.json
  def show; end

  # GET /expenses/new
  def new
    @expense = Expense.new
    # @category = Category.find(params[:category_id])
    @categories = current_user.categories
  end

  # GET /expenses/1/edit
  def edit; end

  # POST /expenses or /expenses.json
  def create
    # @expense = Expense.new(expense_params)
    # @expense.user = current_user
    @expense = @category.expenses.new(expense_params.merge(user_id: current_user.id))
    # @category = Category.find(params[:category_id])
    # @categories = current_user.categories
    selected_category_id = params[:expense][:category_ids]

    respond_to do |format|
      if @expense.save
        # @expense.categories << @selected_category_id
        format.html do
          redirect_to user_category_expenses_path(selected_category_id), notice: 'Expense was successfully created.'
        end
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expenses/1 or /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to expense_url(@expense), notice: 'Expense was successfully updated.' }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1 or /expenses/1.json
  def destroy
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to expenses_url, notice: 'Expense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_expense
    @expense = Expense.find(params[:id])
  end

  def set_category
    @category = current_user.categories.find(params[:category_id])
  end

  # Only allow a list of trusted parameters through.
  def expense_params
    params.require(:expense).permit(:name, :amount, category_ids: [])
  end
end
