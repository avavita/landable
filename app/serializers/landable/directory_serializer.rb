module Landable
  class DirectorySerializer < ActiveModel::Serializer
    attributes :path

    embed :ids, include: true
    has_many   :directories, embed_key: :path
    has_many   :pages
  end
end
