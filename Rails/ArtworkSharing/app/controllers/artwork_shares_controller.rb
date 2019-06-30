class ArtworkSharesController < ApplicationController
    def create
        artwork_share = ArtworkShare.new(artwork_shares_params)
        if artwork_share.save
            render json: artwork_share
        else
            render json: artwork_share.errors.full_messages
        end
    end

    def destroy
        artwork_share = ArtworkShare.find(params[:id])
        artwork_share.destroy
        render json: artwork_share
    end

    def index
        all_shares = ArtworkShare.all
        render json: all_shares
    end
    
    def artwork_shares_params
        params.require(:artwork_share).permit(:viewer_id, :artwork_id)
    end
end