class Event < ActiveRecord::Base
  attr_accessor :region_id,:venue_name,:venue_address
	belongs_to :venue
  belongs_to :category
  has_many :ticket_types	
  validates_presence_of :extended_html_description, :venue, :category, :starts_at
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}
	mount_uploader :hero_image_url, PhotoUploader
	def self.upcoming
		where("starts_at >= ?", Date.current)
	end
end
