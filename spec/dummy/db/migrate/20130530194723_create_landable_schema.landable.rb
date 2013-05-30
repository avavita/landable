# This migration comes from landable (originally 20130510221424)
class CreateLandableSchema < ActiveRecord::Migration
  def change
    # This really should not be in this migration, but it's a convenient location
    # while everything's still under development.
    #
    # TODO extract to a separate migration, check if it exists, maybe check if we
    # actually have permission to do it, etc.
    enable_extension "uuid-ossp"
    enable_extension "hstore"

    # Currently prevents creation of Pages due to apparent AR4 bug:
    # execute " DROP DOMAIN IF EXISTS uri;
    #           CREATE DOMAIN uri AS TEXT
    #           CHECK(
    #             VALUE ~ '^/[a-zA-Z0-9/_.~-]*$'
    #           );"

    execute "DROP SCHEMA IF EXISTS landable; CREATE SCHEMA landable;"

    create_table 'landable.pages', id: :uuid, primary_key: :page_id do |t|
      # t.column "path", :uri, null: false
      t.text      :path, null: false
      t.text      :theme_name

      t.text      :title
      t.text      :body

      t.integer   :status_code, null: false, default: 200
      t.text      :redirect_url

      t.hstore    :meta_tags

      t.timestamp :imported_at
      t.timestamps
    end

    add_index 'landable.pages', :path, unique: true

    create_table 'landable.authors', id: :uuid, primary_key: :author_id do |t|
      t.text :email,      null: false
      t.text :username,   null: false
      t.text :first_name, null: false
      t.text :last_name,  null: false
      t.timestamps
    end

    create_table 'landable.access_tokens', id: :uuid, primary_key: :access_token_id do |t|
      t.uuid      :author_id,  null: false
      t.timestamp :expires_at, null: false
      t.timestamps
    end
  end
end
