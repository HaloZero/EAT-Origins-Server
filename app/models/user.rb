class User < ActiveRecord::Base
	include Paperclip::Glue	


	has_attached_file :picture, 
		:path => "public/images/:class/:style/:basename.:extension", 
		:url => "/images/:class/:style/:basename.:extension",
		:styles => {
			:thumb => "100x100>",
			:ios_density_2 => "300x300>",
			:ios_density_3 => "450x450>",
		}

	validates_attachment_content_type :picture, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

	def to_json()
		{
			id: self.id,
			name: self.name,
			picture_url: EatOriginsServer::App.settings.host+self.picture.url
		}
	end

end
