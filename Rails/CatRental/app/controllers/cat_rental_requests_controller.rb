class CatRentalRequestsController < ApplicationController
    def new
        @cats = Cat.all
        render :new
    end

    def create
        request = CatRentalRequests.new(cat_rental_request_params)

        if request.save
            redirect_to :root
        else
            render :new
        end
    end

    private
    def cat_rental_request_params
        params.require(:request).permit(:start_date, :end_date, :cat_id)
    end
end