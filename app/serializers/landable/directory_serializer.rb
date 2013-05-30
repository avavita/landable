module Landable
  class DirectorySerializer < ActiveModel::Serializer
    attributes :path

    has_many   :subdirectories, embed: :ids, embed_key: :path
    has_many   :pages, embed: :ids, include: true
  end
end
