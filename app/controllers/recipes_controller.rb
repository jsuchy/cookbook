class RecipesController < ApplicationController
  layout "default"

  before_filter :secure_page

  def index
    @recipes = user_recipes
  end

  def all
    @recipes = Recipe.find(:all, :order => "title")
    render :template => "recipes/index"
  end

  def show
    @recipe = Recipe.find(params[:id])

    respond_to do |format|
      format.iphone do
        render :layout => false
      end
      format.html do
        render :template => "recipes/show"
      end
    end
  end

  def new
    @recipe = user_recipes.build
  end

  def create
    begin
      @recipe = user_recipes.build(params[:recipe])
      @recipe.save!
      flash[:message] = "Successfully created recipe"
      redirect_to :action => "index"
    rescue ActiveRecord::RecordInvalid
      render :template => "recipes/new", :layout => false
    end
  end

  def edit
    begin
      @recipe = user_recipes.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render :template => "recipes/not_found"
    end
  end

  def update
    @recipe = user_recipes.find(params[:id])
    if @recipe.update_attributes(params[:recipe])
      flash[:message] = "Successfully updated recipe"
      redirect_to :action => "index"
    else
      render :template => "recipes/edit"
    end
  end

  def destroy
    begin
      @recipe = user_recipes.find(params[:id])
      if @recipe.destroy
        flash[:message] = "Successfully deleted recipe"
        redirect_to :action => "index"
      end
    rescue ActiveRecord::RecordNotFound
      render :template => "recipes/not_found"
    end
  end

  def search
    @recipes = user_recipes.find(:all, :conditions => [Recipe.search_clause, "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%"])
    render :template => "recipes/index"
  end

  private #################################################

  def secure_page
    if session[:user_id].nil?
      redirect_to :controller => "login", :action => "index"
    else
      @user = User.find(session[:user_id])
    end
  end

  def user_recipes
    return @user.recipes
  end

end
