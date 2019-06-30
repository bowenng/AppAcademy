class ArtworksController < ApplicationController
    def create
        artwork = Artwork.new(artwork_params)
        if artwork.save
            render json: artwork
        else
            render json: artwork.errors.full_messages, status: :unprocessable_entity
        end
    end

    def destroy
        id = params[:id]
        artwork = Artwork.find(id)
        artwork.destroy
        render json: artwork
    end

    def index
        user_id = params[:user_id]
        user = User.find(user_id)
        artworks_created = user.artworks
        artworks_shared = user.shared_artworks
        render json: {'artworks created' => artworks_created, 'artworks shared' => artworks_shared}
    end

    def show
        id = params[:id]
        artwork = Artwork.find(id)
        render json: artwork
    end

    def update
        artwork = Artwork.find(params[:id])
        if artwork.update_attributes(artwork_params)
            render json: artwork
        else
            render json: artwork.errors.full_messages, status: :unprocessable_entity
        end
    end
    
    private
    def artwork_params
        params.require(:artwork).permit(:title, :image_url, :artist_id)
    end
end