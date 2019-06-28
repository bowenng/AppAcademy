class Route < ApplicationRecord
  has_many :buses,
    class_name: 'Bus',
    foreign_key: :route_id,
    primary_key: :id

  def n_plus_one_drivers
    buses = self.buses

    all_drivers = {}
    buses.each do |bus|
      drivers = []
      bus.drivers.each do |driver|
        drivers << driver.name
      end
      all_drivers[bus.id] = drivers
    end

    all_drivers
  end

  def better_drivers_query
    # TODO: your code here
    route_name = self.joins(:buses).joins(:drivers).select("routes.id AS id, drivers.name AS name")
    h = Hash.new()
    route_name.each do |el|
      h[el.id] = el.name
    end
  end
end
