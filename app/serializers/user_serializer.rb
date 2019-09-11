class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id,
    :name,
    :email
    #:images

    def images
      return unless object.images.attachments
      image_urls = object.images.map do |image|
        rails_blob_path(image, only_path:true)
      end
      image_urls
    end
end
