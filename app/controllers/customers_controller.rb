class CustomersController < ApplicationController

    before_action :authenticate_user!

    def index
        #byebug
        if params[:orderby] && params[:ordering]
            @customer = current_user.customers.order("#{params[:orderby]} #{params[:ordering]}").paginate(:page => params[:page],per_page: 10)
            render :index
        end
        if params[:search]
            @customer = current_user.customers.search(params[:search]).paginate(:page => params[:page],per_page: 10)
        else
            puts(current_user.customers)
            @customer =current_user.customers.paginate(:page => params[:page],per_page: 10)
        end
    end


    def ajaxIndex
        if params[:dataOrdering]
            puts("fsdafsdf")
            dataOrdering = params[:dataOrdering]
            dataOrderingSplitted = dataOrdering.split("-")
            customer = current_user.customers.order("#{dataOrderingSplitted[1]} #{dataOrderingSplitted[0]}")
            render :json => {:customerInfo => customer}
        end
        
        if params[:searchValue]
            searchValue = params[:searchValue]
            customer =  current_user.customers.search(searchValue)
            render :json => {:customerInfo => customer}

        end
    end


    def new
        #byebug
        @customer = Customer.new
    end


    def create
        #byebug
        @customer = Customer.new(customer_params)
        if @customer.save
            redirect_to root_path, notice: "Successfully created account !"
        else
            render 'new'
        end
    end

    def show
        @customer = current_user.customers.find_by(id: params.require(:id))
    end


    # ==========================================
    # Update

    def edit   
        @customer = current_user.customers.find_by(id: params.require(:id))  
    end  
    
    def update   
        byebug
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
        
        @customer = current_user.customers.find_by(id: params.require(:format))  
        @customer.destroy
        redirect_to(
          root_path,
          notice: 'Customer successfully deleted'
        )
    end

    # ==========================================


    private
    def customer_params 
        params.require(:customer).permit(:name, :email, :phone, :address, :user_id)
    end



    







end