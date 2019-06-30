# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ApplicationRecord.transaction do
    #generate users
    picasso = User.create(username: 'picasso')
    vangogh = User.create(username: 'vangogh')
    leonardo = User.create(username: 'leonardo')
    bryan = User.create(username: 'superbryan')
    paul = User.create(username: 'paulhahaha')

    #generate artworks
    starry_night= Artwork.create(title: 'Starry Night', image_url: 'starry_night.jpg', artist_id: vangogh.id)
    mona_lisa = Artwork.create(title: 'Mona Lisa', image_url: 'mona_lisa.jpg', artist_id: leonardo.id)
    guernica = Artwork.create(title: 'Guernica', image_url: 'guernica.jpg', artist_id: picasso.id)
    #generate artwork shares
    share1 = ArtworkShare.create(viewer_id: bryan.id, artwork_id: mona_lisa.id)
    share2 = ArtworkShare.create(viewer_id: paul.id, artwork_id: mona_lisa.id)
    share3 = ArtworkShare.create(viewer_id: bryan.id, artwork_id: starry_night.id)
    share4 = ArtworkShare.create(viewer_id: paul.id, artwork_id: guernica.id)
end