class CustomersController < ApplicationController

    before_action :authenticate_user!

    def index
        if params[:orderby] && params[:ordering]
            @customer = Customer.order("#{params[:orderby]} #{params[:ordering]}").paginate(:page => params[:page],per_page: 10)
            render :index
        end
        if params[:search]
            @customer = Customer.search(params[:search]).paginate(:page => params[:page],per_page: 10)
        else
            @customer = Customer.paginate(:page => params[:page],per_page: 10)
        end
    end


    def new
        #byebug
        @customer = Customer.new
    end


    def create
        @customer = Customer.new(customer_params)
        if @customer.save
            redirect_to root_path, notice: "Successfully created account !"
        else
            render 'new'
        end
    end

    def show
        @customer = Customer.find_by(id: params.require(:id))
    end


    # ==========================================
    # Update

    def edit   
        @customer = Customer.find_by(id: params.require(:id))  
    end  
    
    def update   
        @customer = Customer.find_by(id: params.require(:format))    
        if @customer.update_attributes(customer_params)   
          flash[:notice] = 'Customer details updated!'   
          redirect_to root_path   
        else   
          flash[:alert] = 'Failed to update details of customer!'   
          render :edit   
        end   
    end

    # ==========================================
    # Delete


    def delete
        
        @customer = Customer.find_by(id: params.require(:format))  
        @customer.destroy
        redirect_to(
          root_path,
          notice: 'Customer successfully deleted'
        )
    end

    # ==========================================


    private
    def customer_params 
        params.require(:customer).permit(:name, :email, :phone, :address)
    end



    







end