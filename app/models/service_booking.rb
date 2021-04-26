class ServiceBooking < ApplicationRecord
  belongs_to :service
  belongs_to :booking

  private

  def self.join_service_with_name(name)
    service = Service.arel_table
    joins(:service).where(service[:name].eq(name))
  end

end


