def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.
  Movie.joins(:actors).select(:title, :id).where("actors.name IN (?)", those_actors).group("movies.id").having("COUNT(*) = ?", those_actors.length)
end

def golden_age
  # Find the decade with the highest average movie score.
  Movie.group("FLOOR(yr / 10) * 10").order("AVG(score) DESC").limit(1).pluck("FLOOR(yr / 10) * 10")[0].to_i
end

def costars(name)
  # List the names of the actors that the named actor has ever
  # appeared with.
  # Hint: use a subquery
  subquery = Actor.joins(:castings).where("actors.name = ?", name).select("movie_id")
  Movie.joins(:actors).where("actors.name != ?", name).where("movie_id IN (?)", subquery).distinct.pluck(:name)
end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  Actor.left_outer_joins(:castings).where(castings: {movie_id: nil}).count
end

def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the
  # letters in whazzername, ignoring case, in order.

  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but
  # not like "stallone sylvester" or "zylvester ztallone"
  Movie.joins(:actors).where("UPPER(actors.name) LIKE UPPER(?)", "%#{whazzername.upcase.split(//).join("%")}%")
end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of
  # their career.
  Actor.joins(:movies).select("actors.id, actors.name, (MAX(movies.yr) - MIN(movies.yr)) AS career").group(:id).order("career DESC").limit(3)
end
