class Event < ActiveRecord::Base
	# scope :published, -> { where(published_at: nil) }
	# TODO: How to make SCOPE work ????

	attr_accessor :region_id,:venue_name,:venue_address,:ticket_name,:ticket_price,:ticket_max
	belongs_to :venue
  belongs_to :category
  has_many :ticket_types	
  validates_presence_of :extended_html_description, :venue, :category, :starts_at
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}
	mount_uploader :hero_image_url, PhotoUploader
	def self.upcoming
		where("starts_at >= ? AND published_at is not null", Date.current)
	end

	def have_enough_ticket_types?
		TicketType.where(event_id: id).count > 0
	end
end
