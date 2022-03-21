require 'roo'

class CustomersController < ApplicationController
  before_action :set_customer, only: %i[ show edit update destroy ]

  # GET /customers or /customers.json
  def index
    @customers = Customer.all
  end

  # GET /customers/1 or /customers/1.json
  def show
  end

  # GET /customers/new
  def new
    @customer = Customer.new
  end

  # GET /customers/1/edit
  def edit
  end

  # POST /customers or /customers.json
  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to customer_url(@customer), notice: "Customer was successfully created." }
        format.json { render :show, status: :created, location: @customer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customers/1 or /customers/1.json
  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html { redirect_to customer_url(@customer), notice: "Customer was successfully updated." }
        format.json { render :show, status: :ok, location: @customer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1 or /customers/1.json
  def destroy
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to customers_url, notice: "Customer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # GET /clear
  def clear
    Customer.delete_all
    redirect_to action: 'index'
  end

  # GET /randomize
  def randomize
    customers = Customer.all
    array = customers.map {|e| e.attributes.values}
    array.each do |c|
      c.each_with_index do |cc, idx|
        next if idx == 0 or idx > 4
        c[idx] = array.sample[rand(1..4)]
      end
      customer = Customer.find c[0]
      customer.first_name = c[1]
      customer.last_name = c[2]
      customer.occupation = c[3]
      customer.company = c[4]
      customer.save!
    end
    redirect_to action: 'index'
  end

  # GET /import
  def upload

  end

  # POST /import
  def import
    excel_file = params[:excel_file]
    file = FileUploader.new
    file.store!(excel_file)
    data = Roo::Spreadsheet.open("#{file.store_path}")
    headers = data.row 1
    data.each_with_index do |row, idx|
      next if idx == 0 # skip header row
      # create hash from headers and cells
      customer_data = Hash[[headers, row].transpose]

      customer = Customer.new(customer_data)
      puts "Saving Customer with name '#{customer.last_name}, #{customer.first_name}"
      customer.save!
    end
    redirect_to action: 'index'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :occupation, :company, :age, :salary, :address)
    end
end
