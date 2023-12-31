class StocksController < ApplicationController
    respond_to :js
    
    def search
        if params[:stock].present?
            @stock = Stock.new_lookup(params[:stock])
           if @stock
            respond_to do |format|
                format.turbo_stream do
                  render turbo_stream: turbo_stream.update(
                    "results",
                    partial: "users/result" # render any partial and remove js code.
                  )
                end
              end
           else
                flash[:alert] = "Please enter a valid symbol to search"
                redirect_to my_portfolio_path
           end
        else
            flash[:alert] = "Please enter a symbol to search"
            redirect_to my_portfolio_path
        end

    end

end