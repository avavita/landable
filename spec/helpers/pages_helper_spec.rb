require 'spec_helper'

module Landable
  describe PagesHelper do
    describe '#current_page' do
      it 'can handle previewing pages' do
        page = create :page
        params[:controller] = 'landable/public/preview/pages'
        params[:id] = page.id

        helper.current_page.should eq page
      end

      it 'can handle previewing page_revisions' do
        pr = create :page_revision
        params[:controller] = 'landable/public/preview/page_revisions'
        params[:id] = pr.id

        helper.current_page.should eq pr
      end

      it 'can handle viewing published pages' do
        page = create :page
        page.publish! author: create(:author)
        @request.path = page.path

        helper.current_page.should eq page
      end

      it 'should inherit helpers from the host application' do
        helper.render_hello_world.should eql('hello world')
      end
    end
  end
end
