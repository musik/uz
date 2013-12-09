class AppsController < ApplicationController
  before_action :set_app, only: [:show, :edit, :update, :destroy,:upd]

  def index
    breadcrumbs.add :apps
  end
  def recent
    @apps = App.recent.page(params[:page])
    breadcrumbs.add :apps,apps_url
    breadcrumbs.add :apps_recent
  end
  def top
    @apps = App.top.page(params[:page])
    breadcrumbs.add :apps,apps_url
    breadcrumbs.add :apps_top
  end
  def tags
    @tags = App.tag_counts_on(:tags).page(params[:page]).per(200)
    breadcrumbs.add :apps_tags
  end
  def tag
    @tag = ActsAsTaggableOn::Tag.where(name: params[:id]).first
    @apps = App.tagged_with(@tag).popular.page(params[:page]).per(35)
    breadcrumbs.add :apps_tags,tags_url
    breadcrumbs.add @tag.name
  end

  # GET /apps/1
  # GET /apps/1.json
  def show
    breadcrumbs.add :apps,apps_url
    breadcrumbs.add @app.name
  end
  def upd
    render text: @app.import_data.save
  end

  # GET /apps/new
  def new
    @app = App.new
  end
  #def submit
    #@app = App.new
  #end

  # GET /apps/1/edit
  def edit
  end

  # POST /apps
  # POST /apps.json
  def create
    @app = App.new(app_params)

    respond_to do |format|
      if @app.save
        format.html { redirect_to app_home_url(@app), notice: 'App was successfully created.' }
        format.json { render action: 'show', status: :created, location: @app }
      else
        format.html { render action: 'new' }
        format.json { render json: @app.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /apps/1
  # PATCH/PUT /apps/1.json
  def update
    respond_to do |format|
      if @app.update(app_params)
        format.html { redirect_to app_home_url(@app), notice: 'App was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @app.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apps/1
  # DELETE /apps/1.json
  def destroy
    @app.destroy
    respond_to do |format|
      format.html { redirect_to apps_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app
      @app = App.where(slug: params[:id]).first || App.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def app_params
      params.require(:app).permit(:o_site_id, :o_user_id, :slug, :name, :owner, :pagetype, :uv, :punish, :keywords, :found_at, :site_type, :description, :logo)
    end
end
