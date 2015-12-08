class Ckeditor::PicturesController < Ckeditor::ApplicationController
  respond_to :json, :html
  def index
    puts ckeditor_current_user.inspect
    @pictures = Ckeditor.picture_adapter.find_all(ckeditor_pictures_scope(assetable_id: active_story.id, assetable_type: "Story"))
    @pictures = Ckeditor::Paginatable.new(@pictures).page(params[:page])
    respond_with(@pictures, :layout => @pictures.first_page?)
  end

  def create
    @picture = Ckeditor.picture_model.new(assetable_id:  active_story.id, assetable_type: "Story")
    respond_with_asset(@picture)
  end

  def destroy
    @picture.destroy
    respond_with(@picture, :location => pictures_path)
  end

  protected

  def find_asset
    @picture = Ckeditor.picture_adapter.get!(params[:id])
  end

  def authorize_resource
    model = (@picture || Ckeditor.picture_model)
    @authorization_adapter.try(:authorize, params[:action], model)
  end

end
