require 'spec_helper'

describe RecipesController do
  before(:each) do
    login_user
    @recipe = mock("recipe")
    @user_recipes = mock("user recipes", :build => @recipe)
    @user.stub!(:recipes).and_return(@user_recipes)
  end

  it "requires authenticated user" do
    logout_user

    get :index

    response.should redirect_to(:controller => "login", :action => "index")
  end

  it "loads my recipes on index" do
    get :index

    assigns[:recipes].== @user_recipes
  end

  it "loads all recipes on all" do
    recipes = mock("recipes")
    Recipe.should_receive(:find).with(:all, :order => "title").and_return(recipes)

    get :all

    assigns[:recipes].should == recipes
  end

  it "renders index on all" do
    get :all

    response.should render_template("recipes/index")
  end

  it "loads recipe specified on show" do
    Recipe.should_receive(:find).with("456").and_return(@recipe)
    # controller.should_receive(:render).with(:template => "recipes/show")

    get :show, :id => "456", :format => "html"

    assigns[:recipe].should == @recipe
  end

  it "loads recipe specified on edit" do
    @user_recipes.should_receive(:find).with("edit").and_return(@recipe)

    get :edit, :id => "edit"

    assigns[:recipe].should == @recipe
  end

  it "shows an error page if attempting to edit a recipe that is not owned by user" do
    @user_recipes.should_receive(:find).with("not_mine").and_raise ActiveRecord::RecordNotFound

    get :edit, :id => "not_mine"

    response.should render_template("recipes/not_found")
  end


  it "instantiates new recipe on new" do
    @user_recipes.should_receive(:build).and_return(@recipe)

    get :new

    assigns[:recipe].should == @recipe
  end

  describe RecipesController, "recipe creation" do
    before(:each) do
      @params = {"title" => "tossed salad"}
    end

    it "creates a new recipe" do
      @user_recipes.should_receive(:build).with(@params).and_return(@recipe)
      @recipe.should_receive(:save!)

      post :create, :recipe => @params

      response.should redirect_to("http://test.host/recipes")
      assigns[:recipe].should == @recipe
      flash[:message].should == "Successfully created recipe"
    end

    it "renders new if create failed" do
      @real_recipe = Recipe.new
      @recipe.should_receive(:save!).and_raise(ActiveRecord::RecordInvalid.new(@real_recipe))

      post :create, :recipe => @params

      response.should render_template("recipes/new")
      assigns[:recipe].should == @recipe
    end

  end

  it "updates a recipe" do
    @user_recipes.should_receive(:find).with("234").and_return(@recipe)
    @recipe.should_receive(:update_attributes).with({"name" => "chicken pot pie"}).and_return(true)

    post :update, :id => "234", :recipe => {"name" => "chicken pot pie"}

    response.should redirect_to("http://test.host/recipes")
    flash[:message].should == "Successfully updated recipe"
  end

  it "renders edit if update fails" do
    @user_recipes.should_receive(:find).with("234").and_return(@recipe)
    @recipe.should_receive(:update_attributes).with({"name" => "chicken pot pie"}).and_return(false)

    post :update, :id => "234", :recipe => {"name" => "chicken pot pie"}

    response.should render_template("recipes/edit")
  end

  it "destroys a recipe" do
    @user_recipes.should_receive(:find).with("345").and_return(@recipe)
    @recipe.should_receive(:destroy).and_return(true)

    post :destroy, :id => "345"

    response.should redirect_to("http://test.host/recipes")
    flash[:message].should == "Successfully deleted recipe"
  end

  it "shows an error page if user tries to delete a recipe that is not theirs" do
    @user_recipes.should_receive(:find).with("not_mine").and_raise ActiveRecord::RecordNotFound

    post :destroy, :id => "not_mine"

    response.should render_template("recipes/not_found")
  end


  it "searchs for recipes" do
    recipe = mock("recipe")
    @user_recipes.should_receive(:find).with(:all, {:conditions => ["title LIKE ? OR preparation LIKE ? OR source LIKE ?", "%Salad%", "%Salad%", "%Salad%"]}).and_return(recipe)

    post :search, :query => "Salad"

    assigns[:recipes].should == recipe
    response.should render_template("recipes/index")
  end
end
